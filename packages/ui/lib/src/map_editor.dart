import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'wall_ui.dart';
import 'wall_painter.dart';

class MapEditor extends StatefulWidget {
  const MapEditor({super.key});

  @override
  State<MapEditor> createState() => _MapEditorState();
}

class _MapEditorState extends State<MapEditor> {
  int gridSize = 13; // Начальный размер
  List<List<WallType>> grid = [];
  WallType selectedTool = WallType.L;
  bool isErasing = false;

  final TextEditingController _sizeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeGrid();
    _sizeController.text = gridSize.toString();
  }

  @override
  void dispose() {
    _sizeController.dispose();
    super.dispose();
  }

  void _initializeGrid() {
    grid = List.generate(gridSize, (_) => List.filled(gridSize, WallType.N));
  }

  // Панель инструментов
  final List<MapEntry<String, WallType>> tools = [
    const MapEntry('L', WallType.L),
    const MapEntry('R', WallType.R),
    const MapEntry('T', WallType.T),
    const MapEntry('D', WallType.D),
    const MapEntry('LIT', WallType.LIT),
    const MapEntry('RIT', WallType.RIT),
    const MapEntry('LID', WallType.LID),
    const MapEntry('RID', WallType.RID),
    const MapEntry('LOT', WallType.LOT),
    const MapEntry('ROT', WallType.ROT),
    const MapEntry('LOD', WallType.LOD),
    const MapEntry('ROD', WallType.ROD),
    const MapEntry('B', WallType.B),
    const MapEntry('N', WallType.N),
  ];

  void _onCellTapped(int row, int column) {
    setState(() {
      if (isErasing) {
        grid[row][column] = WallType.N;
      } else {
        grid[row][column] = selectedTool;
      }
    });
  }

  void _onCellDragged(int row, int column) {
    _onCellTapped(row, column);
  }

  void _clearGrid() {
    setState(() {
      _initializeGrid();
    });
  }

  String _wallTypeToSymbol(WallType type) {
    switch (type) {
      case WallType.L:
        return 'L';
      case WallType.R:
        return 'R';
      case WallType.T:
        return 'T';
      case WallType.D:
        return 'D';
      case WallType.LIT:
        return 'LIT';
      case WallType.RIT:
        return 'RIT';
      case WallType.LID:
        return 'LID';
      case WallType.RID:
        return 'RID';
      case WallType.LOT:
        return 'LOT';
      case WallType.ROT:
        return 'ROT';
      case WallType.LOD:
        return 'LOD';
      case WallType.ROD:
        return 'ROD';
      case WallType.B:
        return 'B';
      case WallType.N:
        return 'N';
      case WallType.LB:
        // TODO: Handle this case.
        throw UnimplementedError();
      case WallType.RB:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Редактор карт'),
        backgroundColor: const Color(0xFF50427D),
        actions: [
          IconButton(
            icon: const Icon(Icons.aspect_ratio),
            onPressed: _changeGridSize,
            tooltip: 'Размер карты',
          ),
          IconButton(
            icon: const Icon(Icons.upload),
            onPressed: _importMap,
            tooltip: 'Импорт',
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _exportMap,
            tooltip: 'Экспорт',
          ),
          IconButton(
            icon: const Icon(Icons.cleaning_services),
            onPressed: _clearGrid,
            tooltip: 'Очистить',
          ),
        ],
      ),
      body: Column(
        children: [
          // Панель инструментов
          _buildToolbar(),

          // Переключатель режима
          _buildModeSwitch(),

          // Сетка редактора
          Expanded(
            child: Container(
              color: const Color(0xFF50427D),
              child: Center(child: _buildEditorGrid()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolbar() {
    return Container(
      height: 80,
      color: Colors.grey[200],
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tools.length,
        itemBuilder: (context, index) {
          final tool = tools[index];
          final isSelected = selectedTool == tool.value && !isErasing;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedTool = tool.value;
                isErasing = false;
              });
            },
            child: Container(
              width: 60,
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildToolPreview(tool.value),
                  Text(
                    tool.key,
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildToolPreview(WallType type) {
    final painter = _getPainterForType(type);
    final needsFlip = _needsFlipX(type);
    if (painter == null) return const Icon(Icons.clear, size: 20);

    return SizedBox(
      width: 30,
      height: 30,
      child: Transform.flip(
        flipX: needsFlip,
        child: CustomPaint(painter: painter),
      ),
    );
  }

  CustomPainter? _getPainterForType(WallType type) {
    switch (type) {
      case WallType.L:
        return LeftWallCP();
      case WallType.R:
        return LeftWallCP(); // + Flip
      case WallType.T:
        return TopWallCP();
      case WallType.D:
        return DownWallCP();
      case WallType.LIT:
        return TopLeftInAngleCP();
      case WallType.RIT:
        return TopLeftInAngleCP(); // + Flip
      case WallType.LID:
        return DownLeftInAngleCP();
      case WallType.RID:
        return DownLeftInAngleCP(); // + Flip
      case WallType.LOT:
        return TopLeftOutAngleCP();
      case WallType.ROT:
        return TopLeftOutAngleCP(); // + Flip
      case WallType.LOD:
        return DownRightOutAngleCP(); // + Flip
      case WallType.ROD:
        return DownRightOutAngleCP();
      case WallType.B:
        return BlockCP();
      case WallType.LB:
        return LeftBridgeWOTShadowCP();
      case WallType.RB:
        return LeftBridgeWOTShadowCP();
      case WallType.N:
      default:
        return null;
    }
  }

  bool _needsFlipX(WallType type) {
    return type == WallType.R ||
        type == WallType.RIT ||
        type == WallType.RID ||
        type == WallType.ROT ||
        type == WallType.LOD;
  }

  Widget _buildModeSwitch() {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.grey[100],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Text('Режим рисования'),
              const SizedBox(width: 16),
              Switch(
                value: !isErasing,
                onChanged: (value) {
                  setState(() {
                    isErasing = !value;
                  });
                },
              ),
              const Text('Ластик'),
            ],
          ),
          Text(
            'Размер: $gridSize×$gridSize',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildEditorGrid() {
    const cellSize = 40.0;
    bool isDrawing = false;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white24, width: 2),
      ),
      child: SizedBox(
        width: gridSize * cellSize,
        height: gridSize * cellSize,
        child: Listener(
          onPointerDown: (event) {
            isDrawing = true;
            _handlePointerEvent(event, cellSize);
          },
          onPointerMove: (event) {
            if (isDrawing) {
              _handlePointerEvent(event, cellSize);
            }
          },
          onPointerUp: (event) {
            isDrawing = false;
          },
          child: Stack(
            children: [
              // Сетка
              _buildGridLines(cellSize),

              // Элементы стен
              for (int row = 0; row < grid.length; row++)
                for (int column = 0; column < grid[row].length; column++)
                  _buildGridCell(row, column, cellSize),
            ],
          ),
        ),
      ),
    );
  }

  void _handlePointerEvent(PointerEvent event, double cellSize) {
    final column = (event.localPosition.dx / cellSize).floor();
    final row = (event.localPosition.dy / cellSize).floor();

    if (row >= 0 && row < gridSize && column >= 0 && column < gridSize) {
      setState(() {
        if (isErasing) {
          grid[row][column] = WallType.N;
        } else {
          grid[row][column] = selectedTool;
        }
      });
    }
  }

  Widget _buildGridLines(double cellSize) {
    return Positioned.fill(
      child: CustomPaint(
        painter: _GridPainter(gridSize: gridSize, cellSize: cellSize),
      ),
    );
  }

  Widget _buildGridCell(int row, int column, double cellSize) {
    final wallType = grid[row][column];
    final painter = _getPainterForType(wallType);
    final needsFlip = _needsFlipX(wallType);
    return Positioned(
      left: column * cellSize,
      top: row * cellSize,
      child: GestureDetector(
        onTap: () => _onCellTapped(row, column),
        onPanUpdate: (details) {
          final localPosition = details.localPosition;
          final cellRow = (localPosition.dy / cellSize).floor();
          final cellColumn = (localPosition.dx / cellSize).floor();

          if (cellRow >= 0 &&
              cellRow < gridSize &&
              cellColumn >= 0 &&
              cellColumn < gridSize) {
            _onCellDragged(cellRow, cellColumn);
          }
        },
        child: Container(
          width: cellSize,
          height: cellSize,
          child: painter != null
              ? Transform.flip(
                  flipX: needsFlip,
                  child: CustomPaint(painter: painter),
                )
              : null,
        ),
      ),
    );
  }

  void _importMap() {
    final textController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Импорт карты'),
        content: SizedBox(
          width: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Вставьте код карты:'),
              const SizedBox(height: 16),
              Expanded(
                child: TextField(
                  controller: textController,
                  maxLines: 10,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Вставьте сюда код из экспорта...",
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              _parseImportedMap(textController.text);
              Navigator.pop(context);
            },
            child: const Text('Импорт'),
          ),
        ],
      ),
    );
  }

  void _parseImportedMap(String importedText) {
    try {
      // Очищаем текст от лишних символов
      final cleanedText = importedText
          .replaceAll('[', '')
          .replaceAll(']', '')
          .replaceAll("'", '')
          .trim();

      // Разбиваем на строки
      final lines = cleanedText
          .split('\n')
          .where((line) => line.trim().isNotEmpty)
          .toList();

      final importedSize = lines.length;
      if (importedSize < 5 || importedSize > 20) {
        _showError(
          'Неверный размер карты: $importedSize. Допустимо от 5 до 20.',
        );
        return;
      }

      final newGrid = <List<WallType>>[];

      for (final line in lines) {
        final trimmedLine = line.trim();
        // Убираем запятые в конце строк
        final cleanLine = trimmedLine.endsWith(',')
            ? trimmedLine.substring(0, trimmedLine.length - 1)
            : trimmedLine;

        final symbols = cleanLine
            .split(' ')
            .where((symbol) => symbol.isNotEmpty)
            .toList();

        if (symbols.length != importedSize) {
          _showError(
            'Неверное количество элементов в строке: ${symbols.length}. Ожидается $importedSize.',
          );
          return;
        }

        final row = symbols.map(_symbolToWallType).toList();
        newGrid.add(row);
      }

      setState(() {
        gridSize = importedSize;
        grid = newGrid;
        _sizeController.text = importedSize.toString();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Карта $importedSize×$importedSize успешно импортирована!',
          ),
        ),
      );
    } catch (e) {
      _showError('Ошибка при импорте: $e');
    }
  }

  void _exportMap() {
    final buffer = StringBuffer();
    buffer.writeln('[');

    for (int row = 0; row < gridSize; row++) {
      final rowSymbols = grid[row].map(_wallTypeToSymbol).toList();
      final rowString = "'${rowSymbols.join(' ')}'";

      if (row < gridSize - 1) {
        buffer.writeln('  $rowString,');
      } else {
        buffer.writeln('  $rowString');
      }
    }

    buffer.write(']');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Экспорт карты $gridSize×$gridSize'),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Размер: $gridSize×$gridSize'),
              const SizedBox(height: 8),
              SelectableText(
                buffer.toString(),
                style: const TextStyle(fontFamily: 'monospace'),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.content_copy),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: buffer.toString()));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Скопировано в буфер обмена!'),
                        ),
                      );
                    },
                    tooltip: 'Копировать',
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  WallType _symbolToWallType(String symbol) {
    switch (symbol) {
      case 'L':
        return WallType.L;
      case 'R':
        return WallType.R;
      case 'T':
        return WallType.T;
      case 'D':
        return WallType.D;
      case 'LIT':
        return WallType.LIT;
      case 'RIT':
        return WallType.RIT;
      case 'LID':
        return WallType.LID;
      case 'RID':
        return WallType.RID;
      case 'LOT':
        return WallType.LOT;
      case 'ROT':
        return WallType.ROT;
      case 'LOD':
        return WallType.LOD;
      case 'ROD':
        return WallType.ROD;
      case 'B':
        return WallType.B;
      case 'N':
        return WallType.N;
      default:
        return WallType.N;
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _changeGridSize() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Размер карты'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Введите размер карты (5-20):'),
            const SizedBox(height: 16),
            TextField(
              controller: _sizeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '13',
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: Wrap(
                spacing: 8,
                children: [5, 8, 10, 13, 15, 20].map((size) {
                  return ElevatedButton(
                    onPressed: () {
                      _sizeController.text = size.toString();
                    },
                    child: Text('$size'),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              final newSize = int.tryParse(_sizeController.text);
              if (newSize != null && newSize >= 5 && newSize <= 20) {
                _resizeGrid(newSize);
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Размер должен быть от 5 до 20'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text('Применить'),
          ),
        ],
      ),
    );
  }

  void _resizeGrid(int newSize) {
    setState(() {
      final oldGrid = grid;
      gridSize = newSize;

      // Создаем новую сетку
      final newGrid = List.generate(newSize, (row) {
        if (row < oldGrid.length) {
          // Копируем существующие строки
          return List.generate(newSize, (col) {
            if (col < oldGrid[row].length) {
              return oldGrid[row][col]; // Сохраняем существующие данные
            } else {
              return WallType.N; // Заполняем новые клетки пустотами
            }
          });
        } else {
          // Создаем новые строки
          return List.filled(newSize, WallType.N);
        }
      });

      grid = newGrid;
    });
  }
}

// Painter для сетки
class _GridPainter extends CustomPainter {
  final int gridSize;
  final double cellSize;

  const _GridPainter({required this.gridSize, required this.cellSize});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white24
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Вертикальные линии
    for (int i = 0; i <= gridSize; i++) {
      final x = i * cellSize;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Горизонтальные линии
    for (int i = 0; i <= gridSize; i++) {
      final y = i * cellSize;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
