import 'package:flutter/material.dart';
import 'wall_ui.dart';
import 'wall_painter.dart';

class MapEditor extends StatefulWidget {
  const MapEditor({super.key});

  @override
  State<MapEditor> createState() => _MapEditorState();
}

class _MapEditorState extends State<MapEditor> {
  final int gridSize = 13;
  List<List<WallType>> grid = [];
  WallType selectedTool = WallType.L;
  bool isErasing = false;

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

  @override
  void initState() {
    super.initState();
    _initializeGrid();
  }

  void _initializeGrid() {
    grid = List.generate(gridSize, (_) => List.filled(gridSize, WallType.N));
  }

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

  void _exportMap() {
    final buffer = StringBuffer();
    for (int row = 0; row < gridSize; row++) {
      final rowSymbols = grid[row].map(_wallTypeToSymbol).toList();
      buffer.writeln(
        "'${rowSymbols.join(' ')}'${row < gridSize - 1 ? ',' : ''}",
      );
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Экспорт карты'),
        content: SelectableText(buffer.toString()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
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
            icon: const Icon(Icons.cleaning_services),
            onPressed: _clearGrid,
            tooltip: 'Очистить',
          ),
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _exportMap,
            tooltip: 'Экспорт',
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
    if (painter == null) return const Icon(Icons.clear, size: 20);

    return SizedBox(
      width: 30,
      height: 30,
      child: CustomPaint(painter: painter),
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

  Widget _buildModeSwitch() {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.grey[100],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }

  Widget _buildEditorGrid() {
    const cellSize = 40.0;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white24, width: 2),
      ),
      child: SizedBox(
        width: gridSize * cellSize,
        height: gridSize * cellSize,
        child: Stack(
          children: [
            // Сетка
            _buildGridLines(cellSize),

            // Элементы стен
            for (int row = 0; row < gridSize; row++)
              for (int column = 0; column < gridSize; column++)
                _buildGridCell(row, column, cellSize),
          ],
        ),
      ),
    );
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
          child: painter != null ? CustomPaint(painter: painter) : null,
        ),
      ),
    );
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
