// widgets/field_widget.dart
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qlutter/ver_2/game/field_engine.dart';
import 'package:qlutter/ver_2/models/coordinates.dart';
import 'package:qlutter/ver_2/models/item.dart';
import 'package:qlutter/ver_2/models/level.dart';

class FieldWidget extends StatefulWidget {
  const FieldWidget({
    super.key,
    required this.level,
    this.onLevelComplete,
    this.onStateChanged,
  });
  final Level level;
  final VoidCallback? onLevelComplete;
  final VoidCallback? onStateChanged;

  @override
  State<FieldWidget> createState() => _FieldWidgetState();
}

class _FieldWidgetState extends State<FieldWidget> {
  late FieldEngine _engine;
  Coordinates? _startDragCoords;
  double _elementSize = 40; // Начальный размер по умолчанию

  @override
  void initState() {
    super.initState();
    _engine = FieldEngine(widget.level);
  }

  @override
  void didUpdateWidget(FieldWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.level != widget.level) {
      _engine.resetLevel(widget.level);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Рассчитываем оптимальный размер элемента
        _elementSize = _calculateOptimalElementSize(
          constraints,
          isLandscape,
          mediaQuery,
        );

        return Column(
          children: [
            // Адаптивная статусная панель
            _buildAdaptiveStatusBar(isLandscape),
            const SizedBox(height: 8),
            // Контейнер игрового поля с анимацией
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              height: _calculateFieldHeight(constraints, isLandscape),
              child: _buildGameField(constraints, isLandscape),
            ),
          ],
        );
      },
    );
  }

  double _calculateOptimalElementSize(
    BoxConstraints constraints,
    bool isLandscape,
    MediaQueryData mediaQuery,
  ) {
    final maxWidth = constraints.maxWidth;
    final maxHeight = constraints.maxHeight * (isLandscape ? 0.8 : 0.7);

    // Рассчитываем размер на основе ширины и высоты
    final widthBasedSize = maxWidth / _engine.level.width;
    final heightBasedSize = maxHeight / _engine.level.height;

    double elementSize = min(widthBasedSize, heightBasedSize);

    // Ограничения по минимальному и максимальному размеру
    final minSize = _calculateMinElementSize(mediaQuery);
    final maxSize = _calculateMaxElementSize(mediaQuery);

    return elementSize.clamp(minSize, maxSize);
  }

  double _calculateMinElementSize(MediaQueryData mediaQuery) {
    // Адаптивный минимальный размер в зависимости от устройства
    if (kIsWeb) {
      return 30;
    } else if (mediaQuery.size.shortestSide < 600) {
      // Мобильные телефоны
      return 28;
    } else if (mediaQuery.size.shortestSide < 900) {
      // Планшеты
      return 35;
    } else {
      // Десктоп
      return 40;
    }
  }

  double _calculateMaxElementSize(MediaQueryData mediaQuery) {
    // Адаптивный максимальный размер
    if (kIsWeb) {
      return 80;
    } else if (mediaQuery.size.shortestSide < 600) {
      return 55;
    } else {
      return 70;
    }
  }

  double _calculateFieldHeight(BoxConstraints constraints, bool isLandscape) {
    final fieldHeight = _elementSize * _engine.level.height;
    final maxHeight = constraints.maxHeight * (isLandscape ? 0.75 : 0.65);

    return min(fieldHeight, maxHeight);
  }

  Widget _buildAdaptiveStatusBar(bool isLandscape) {
    final textStyle = TextStyle(
      fontSize: isLandscape ? 14 : 16,
      fontWeight: FontWeight.w600,
    );

    final iconSize = isLandscape ? 20.0 : 24.0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Кнопка отмены
          IconButton(
            iconSize: iconSize,
            icon: Icon(
              Icons.undo,
              color: _engine.canUndo ? Colors.blue : Colors.grey,
            ),
            onPressed: _engine.canUndo ? _undo : null,
          ),

          // Счетчик шаров
          Text('Шары: ${_engine.ballsCount}', style: textStyle),

          // Кнопка сброса
          IconButton(
            iconSize: iconSize,
            icon: const Icon(Icons.refresh),
            onPressed: _resetLevel,
          ),
        ],
      ),
    );
  }

  Widget _buildGameField(BoxConstraints constraints, bool isLandscape) =>
      Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: _elementSize * _engine.level.width,
            maxHeight: _elementSize * _engine.level.height,
          ),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            border: Border.all(
              color: Colors.grey.shade300,
              width: isLandscape ? 1.5 : 2.0,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onPanStart: _onDragStart,
              onPanEnd: _onDragEnd,
              onPanCancel: () => _startDragCoords = null,
              child: _buildFieldGrid(),
            ),
          ),
        ),
      );

  Widget _buildFieldGrid() => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      for (int y = 0; y < _engine.level.height; y++)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int x = 0; x < _engine.level.width; x++)
              _buildFieldElement(x, y),
          ],
        ),
    ],
  );

  Widget _buildFieldElement(int x, int y) {
    final item = _engine.level.field[y][x];
    final padding = _calculateElementPadding();

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      width: _elementSize,
      height: _elementSize,
      padding: padding,
      child: _buildElementContent(item, x, y),
    );
  }

  EdgeInsets _calculateElementPadding() {
    final padding = _elementSize * 0.04;
    return EdgeInsets.all(padding);
  }

  Widget _buildElementContent(Item? item, int x, int y) => Material(
    color: Colors.transparent,
    child: InkWell(
      borderRadius: BorderRadius.circular(_elementSize * 0.15),
      onTap: () => _onElementTap(x, y),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_elementSize * 0.15),
          color: _getColorForItem(item),
          boxShadow: _getElementShadow(item),
        ),
        child: _buildItemSpecialContent(item),
      ),
    ),
  );

  List<BoxShadow> _getElementShadow(Item? item) {
    if (item == null) return [];

    if (item is Block) {
      return [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 2,
          offset: const Offset(1, 1),
        ),
      ];
    } else if (item is Ball) {
      return [
        BoxShadow(
          color: Colors.black.withOpacity(0.4),
          blurRadius: 3,
          offset: const Offset(2, 2),
        ),
        BoxShadow(
          color: _getColorForItem(item).withOpacity(0.6),
          blurRadius: 6,
          offset: const Offset(-1, -1),
        ),
      ];
    } else if (item is Hole) {
      return [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 1,
          offset: const Offset(1, 1),
        ),
      ];
    }

    return [];
  }

  Widget _buildItemSpecialContent(Item? item) {
    if (item == null) return const SizedBox();

    if (item is Hole) {
      return Container(
        margin: EdgeInsets.all(_elementSize * 0.15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_elementSize * 0.25),
          border: Border.all(
            color: Colors.black.withOpacity(0.4),
            width: max(2, _elementSize * 0.08),
          ),
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 0.6,
            colors: [
              _getColorForItem(item).withOpacity(0.3),
              _getColorForItem(item).withOpacity(0.1),
            ],
          ),
        ),
      );
    }

    if (item is Ball) {
      return Container(
        margin: EdgeInsets.all(_elementSize * 0.1),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 0.8,
            colors: [
              _getColorForItem(item),
              _getColorForItem(item).withOpacity(0.7),
            ],
            stops: const [0.5, 1.0],
          ),
        ),
      );
    }

    return const SizedBox();
  }

  Color _getColorForItem(Item? item) {
    if (item == null) return Colors.transparent;

    switch (item.color) {
      case ItemColor.green:
        return const Color(0xFF4CAF50);
      case ItemColor.red:
        return const Color(0xFFF44336);
      case ItemColor.blue:
        return const Color(0xFF2196F3);
      case ItemColor.yellow:
        return const Color(0xFFFFEB3B);
      case ItemColor.purple:
        return const Color(0xFF9C27B0);
      case ItemColor.cyan:
        return const Color(0xFF00BCD4);
      case ItemColor.gray:
        return const Color(0xFF607D8B);
    }
  }

  void _onElementTap(int x, int y) {
    // Обработка тапа на элемент (для десктопной версии)
    if (kIsWeb ||
        defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.linux) {
      _showDirectionMenu(x, y);
    }
  }

  void _showDirectionMenu(int x, int y) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Выберите направление'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDirectionButton('Вверх', Direction.up, x, y),
            _buildDirectionButton('Вниз', Direction.down, x, y),
            _buildDirectionButton('Влево', Direction.left, x, y),
            _buildDirectionButton('Вправо', Direction.right, x, y),
          ],
        ),
      ),
    );
  }

  Widget _buildDirectionButton(
    String text,
    Direction direction,
    int x,
    int y,
  ) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: ElevatedButton(
      onPressed: () {
        Navigator.of(context).pop();
        _makeMove(Coordinates(x, y), direction);
      },
      child: Text(text),
    ),
  );

  void _makeMove(Coordinates coords, Direction direction) {
    final isLevelComplete = _engine.makeTurn(coords, direction);

    setState(() {
      widget.onStateChanged?.call();
    });

    if (isLevelComplete) {
      widget.onLevelComplete?.call();
    }
  }

  void _onDragStart(DragStartDetails details) {
    final renderBox = context.findRenderObject() as RenderBox;
    final localPosition = renderBox.globalToLocal(details.globalPosition);

    final x = (localPosition.dx / _elementSize).floor();
    final y = (localPosition.dy / _elementSize).floor();

    if (x >= 0 &&
        x < _engine.level.width &&
        y >= 0 &&
        y < _engine.level.height) {
      _startDragCoords = Coordinates(x, y);
    }
  }

  void _onDragEnd(DragEndDetails details) {
    if (_startDragCoords == null) return;

    final velocity = details.velocity;
    final direction = _getSwipeDirection(velocity.pixelsPerSecond);

    if (direction != Direction.nowhere) {
      _makeMove(_startDragCoords!, direction);
    }

    _startDragCoords = null;
  }

  Direction _getSwipeDirection(Offset velocity) {
    final dx = velocity.dx.abs();
    final dy = velocity.dy.abs();
    final swipeLength = sqrt(dx * dx + dy * dy);

    // Адаптивная чувствительность свайпа
    final sensitivity = _elementSize * 0.8;
    if (swipeLength < sensitivity) return Direction.nowhere;

    if (dx >= dy) {
      return velocity.dx > 0 ? Direction.right : Direction.left;
    } else {
      return velocity.dy > 0 ? Direction.down : Direction.up;
    }
  }

  void _undo() {
    if (_engine.undo()) {
      setState(() {
        widget.onStateChanged?.call();
      });
    }
  }

  void _resetLevel() {
    _engine.resetLevel(widget.level);
    setState(() {
      widget.onStateChanged?.call();
    });
  }
}
