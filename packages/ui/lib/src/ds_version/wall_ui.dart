import 'package:flutter/material.dart';
import 'package:ui/src/ds_version/wall_painter.dart';

const double sizeWall = 60;

class PlayGround extends StatelessWidget {
  const PlayGround({super.key, this.elementSize = sizeWall});

  final double elementSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 5 * elementSize,
      width: 5 * elementSize,
      child: Container(
        color: const Color(0xFF50427D),
        child: DynamicWallWidget(
          board: GameBoard(GameBoard.defaultLayout),
          elementSize: elementSize,
        ),
      ),
    );
  }
}

class GameBoard {
  static const List<String> defaultLayout = [
    '11111',
    '10001',
    '10001',
    '10001',
    '11111',
    //   'topLeftIn, top,top,top, topRightIn',
    // 'left, none, none, none, right',
    // 'left, none, none, none, right',
    // 'left, none, none, none, right',
    // 'bottomLeftIn,bottom,bottom,bottom,bottomRightIn',
  ];

  final List<List<int>> grid;

  GameBoard(List<String> layout) : grid = _parseLayout(layout);

  static List<List<int>> _parseLayout(List<String> layout) {
    return layout.map((row) => row.split('').map(int.parse).toList()).toList();
  }

  bool isWall(int column, int row) {
    if (row < 0 ||
        row >= grid.length ||
        column < 0 ||
        column >= grid[0].length) {
      return true;
    }
    return grid[row][column] == 1;
  }
}

enum WallType {
  horizontalTop, // Горизонтальная стена СВЕРХУ (бывший top)
  horizontalBottom, // Горизонтальная стена СНИЗУ (бывший bottom)
  verticalLeft, // Вертикальная стена СЛЕВА (бывший left)
  verticalRight, // Вертикальная стена СПРАВА (бывший right)
  topLeftOut,
  topRightOut,
  bottomLeftOut,
  bottomRightOut,
  topLeftIn,
  topRightIn,
  bottomLeftIn,
  bottomRightIn,
  verticalBoth, // Вертикальная стена (сверху и снизу)
  horizontalBoth, // Горизонтальная стена (слева и справа)
  tDown,
  tUp,
  tLeft,
  tRight,
  cross,
  single,
  none,
}

class WallDetector {
  static WallType getWallType(int column, int row, GameBoard board) {
    if (!board.isWall(column, row)) {
      return _getWallTypeForEmptyCell(column, row, board);
    } else {
      return _getWallTypeForWallCell(column, row, board);
    }
  }

  static WallType _getWallTypeForEmptyCell(
    int column,
    int row,
    GameBoard board,
  ) {
    final bool right = board.isWall(column + 1, row);
    final bool bottom = board.isWall(column, row + 1);
    final bool left = board.isWall(column - 1, row);
    final bool top = board.isWall(column, row - 1);

    // Внутренние углы в пустых клетках
    if (right && bottom && !board.isWall(column + 1, row + 1)) {
      return WallType.topLeftIn;
    }
    if (left && bottom && !board.isWall(column - 1, row + 1)) {
      return WallType.topRightIn;
    }
    if (right && top && !board.isWall(column + 1, row - 1)) {
      return WallType.bottomLeftIn;
    }
    if (left && top && !board.isWall(column - 1, row - 1)) {
      return WallType.bottomRightIn;
    }

    return WallType.none;
  }

  static WallType _getWallTypeForWallCell(
    int column,
    int row,
    GameBoard board,
  ) {
    final bool left = board.isWall(column - 1, row);
    final bool right = board.isWall(column + 1, row);
    final bool top = board.isWall(column, row - 1);
    final bool bottom = board.isWall(column, row + 1);

    // Отдельно стоящая стена
    if (!left && !right && !top && !bottom) {
      return WallType.single;
    }

    // ВНУТРЕННИЕ УГЛЫ
    if (top && left && !right && !bottom) return WallType.topLeftIn;
    if (top && right && !left && !bottom) return WallType.topRightIn;
    if (bottom && left && !right && !top) return WallType.bottomLeftIn;
    if (bottom && right && !left && !top) return WallType.bottomRightIn;

    // ВНЕШНИЕ УГЛЫ
    if (!top && !left && (right || bottom)) return WallType.topLeftOut;
    if (!top && !right && (left || bottom)) return WallType.topRightOut;
    if (!bottom && !left && (right || top)) return WallType.bottomLeftOut;
    if (!bottom && !right && (left || top)) return WallType.bottomRightOut;

    // ВЕРХНЯЯ СТЕНА: является частью верхней границы и имеет стены по бокам
    if (top && left && right && !bottom) return WallType.horizontalTop;

    // НИЖНЯЯ СТЕНА: является частью нижней границы и имеет стены по бокам
    if (bottom && left && right && !top) return WallType.horizontalBottom;

    // ЛЕВАЯ СТЕНА: является частью левой границы и имеет стены сверху и снизу
    if (left && top && bottom && !right) return WallType.verticalLeft;

    // ПРАВАЯ СТЕНА: является частью правой границы и имеет стены сверху и снизу
    if (right && top && bottom && !left) return WallType.verticalRight;

    // КРАЙНИЕ СТЕНЫ (для верхнего/нижнего ряда без боковых стен)
    if (top && !bottom && !left && !right) return WallType.horizontalBottom;
    if (bottom && !top && !left && !right) return WallType.horizontalTop;
    if (left && !right && !top && !bottom) return WallType.verticalRight;
    if (right && !left && !top && !bottom) return WallType.verticalLeft;

    // ПОЛНЫЕ СТЕНЫ (со всех сторон, кроме противоположной границы)
    if (left && right && !top && !bottom) return WallType.horizontalBoth;
    if (top && bottom && !left && !right) return WallType.verticalBoth;

    // Т-ОБРАЗНЫЕ СОЕДИНЕНИЯ
    if (top && left && right && !bottom) return WallType.tDown;
    if (bottom && left && right && !top) return WallType.tUp;
    if (left && top && bottom && !right) return WallType.tRight;
    if (right && top && bottom && !left) return WallType.tLeft;

    // ПЕРЕКРЕСТКИ
    if (top && bottom && left && right) return WallType.cross;

    return WallType.single;
  }
}

class DynamicWallWidget extends StatelessWidget {
  final GameBoard board;
  final double elementSize;

  const DynamicWallWidget({
    required this.board,
    required this.elementSize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final walls = <Widget>[];

    for (int row = 0; row < board.grid.length; row++) {
      for (int column = 0; column < board.grid[row].length; column++) {
        final wallType = WallDetector.getWallType(column, row, board);
        print('R $row C $column $wallType');
        if (wallType != WallType.none) {
          final wallPainter = _getWallPainter(wallType);

          if (wallPainter != null) {
            walls.add(
              DrawWallWidget(
                wall: wallPainter,
                column: column,
                row: row,
                elementSize: elementSize,
                flipX: _needsFlipX(wallType),
                rotate: _getRotation(wallType),
              ),
            );
          }
        }
      }
    }

    return Stack(children: walls);
  }

  CustomPainter? _getWallPainter(WallType type) {
    switch (type) {
      // ГОРИЗОНТАЛЬНЫЕ СТЕНЫ
      case WallType.horizontalTop:
        return TWCustomPainter(); // Верхняя горизонтальная
      case WallType.horizontalBottom:
        return BWCustomPainter(); // Нижняя горизонтальная
      case WallType.horizontalBoth:
        return TWCustomPainter(); // Полная горизонтальная

      // ВЕРТИКАЛЬНЫЕ СТЕНЫ
      case WallType.verticalLeft:
        return LWCustomPainter(); // Левая вертикальная
      case WallType.verticalRight:
        return LWCustomPainter(); // LW + Flip = правая вертикальная
      case WallType.verticalBoth:
        return LWCustomPainter(); // Полная вертикальная

      // УГЛЫ (остальное без изменений)
      case WallType.topLeftIn:
        return TLIACustomPainter();
      case WallType.topRightIn:
        return TLIACustomPainter();
      case WallType.bottomLeftIn:
        return BLIACustomPainter();
      case WallType.bottomRightIn:
        return BLIACustomPainter();
      case WallType.topLeftOut:
        return TLOACustomPainter();
      case WallType.topRightOut:
        return TLOACustomPainter();
      case WallType.bottomLeftOut:
        return BROACustomPainter();
      case WallType.bottomRightOut:
        return BROACustomPainter();

      // Т-СОЕДИНЕНИЯ И ПЕРЕКРЕСТКИ
      case WallType.tDown:
        return TWCustomPainter();
      case WallType.tUp:
        return BWCustomPainter();
      case WallType.tLeft:
        return LWCustomPainter();
      case WallType.tRight:
        return LWCustomPainter();
      case WallType.cross:
        return TWCustomPainter();
      case WallType.single:
        return TWCustomPainter();

      default:
        return TWCustomPainter();
    }
  }

  bool _needsFlipX(WallType type) {
    return type == WallType.topRightIn ||
        type == WallType.topRightOut ||
        type == WallType.bottomRightIn ||
        type == WallType.bottomLeftOut ||
        type == WallType.verticalRight || // LW + Flip = правая вертикальная
        type == WallType.tRight;
  }

  int _getRotation(WallType type) {
    switch (type) {
      // НИЖНИЕ ГОРИЗОНТАЛЬНЫЕ СТЕНЫ И УГЛЫ
      case WallType.horizontalBottom:
        return 2; // BW - нижняя горизонтальная
      case WallType.bottomLeftIn:
        return 2; // BLIA -> нижний левый внутрь
      case WallType.bottomRightIn:
        return 2; // BLIA + Flip -> нижний правый внутрь
      case WallType.bottomLeftOut:
        return 2; // BROA + Flip -> нижний левый наружу
      case WallType.bottomRightOut:
        return 2; // BROA -> нижний правый наружу
      case WallType.tUp:
        return 2; // BW + дополнительные элементы

      // ВЕРТИКАЛЬНЫЕ СТЕНЫ
      case WallType.verticalLeft:
        return 1; // LW + Flip = вертикальная слева
      case WallType.verticalRight:
        return 1; // LW = вертикальная справа
      case WallType.verticalBoth:
        return 1; // LW = полная вертикальная
      case WallType.tLeft:
        return 1; // LW = T-слева
      case WallType.tRight:
        return 1; // LW + Flip = T-справа

      // ГОРИЗОНТАЛЬНЫЕ СТЕНЫ (без rotation)
      case WallType.horizontalTop:
      case WallType.horizontalBoth:
      case WallType.tDown:
      default:
        return 0;
    }
  }
}

class DrawWallWidget extends StatelessWidget {
  const DrawWallWidget({
    required this.wall,
    required this.column,
    required this.row,
    super.key,
    this.flipX = false,
    this.rotate = 0,
    required this.elementSize,
  });
  final CustomPainter wall;
  final int column;
  final int row;
  final bool flipX;
  final int rotate;
  final double elementSize;

  @override
  Widget build(BuildContext context) => Positioned(
    top: row * elementSize,
    left: column * elementSize,
    child: Transform.flip(
      flipX: flipX,
      child: RotatedBox(
        quarterTurns: rotate,
        child: SizedBox(
          height: elementSize,
          width: elementSize,
          child: CustomPaint(
            size: Size(elementSize, (elementSize * 1).toDouble()),
            painter: wall,
          ),
        ),
      ),
    ),
  );
}
