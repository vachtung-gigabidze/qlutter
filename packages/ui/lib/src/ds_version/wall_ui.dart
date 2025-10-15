import 'package:flutter/material.dart';
import 'package:ui/src/wall_painter.dart';

const double sizeWall = 100;

class PlayGround extends StatelessWidget {
  const PlayGround({super.key, this.elementSize = sizeWall});

  final double elementSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 7 * elementSize,
      width: 7 * elementSize,
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
    'B LIT RIT B B B B',
    'LIT LOT ROT T T RIT B',
    'L N ROD LOD N ROT RIT',
    'L ROD RID LID LOD ROD RID',
    'L ROT T T LOT R B',
    'LID LOD N N N R B',
    'B LID D D D RID B',

    //   'topLeftIn, top,top,top, topRightIn',
    // 'left, none, none, none, right',
    // 'left, none, none, none, right',
    // 'left, none, none, none, right',
    // 'bottomLeftIn,bottom,bottom,bottom,bottomRightIn',
  ];

  final List<List<WallType>> grid;

  GameBoard(List<String> textLayout) : grid = _parseTextLayout(textLayout);

  static List<List<WallType>> _parseTextLayout(List<String> textLayout) {
    return textLayout.map((row) {
      // Разделяем строку по пробелам и преобразуем в WallType
      return row.split(' ').map((symbol) {
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
          default:
            return WallType.N;
        }
      }).toList();
    }).toList();
  }

  WallType getWallType(int column, int row) {
    if (row < 0 ||
        row >= grid.length ||
        column < 0 ||
        column >= grid[0].length) {
      return WallType.N;
    }
    return grid[row][column];
  }
}

enum WallType {
  N, // None
  L, // LeftWallCP
  R, // LeftWallCP + Flip
  T, // TopWallCP
  D, // DownWallCP
  LIT, // TopLeftInAngleCP
  RIT, // TopLeftInAngleCP + Flip
  LID, // DownLeftInAngleCP
  RID, // DownLeftInAngleCP + Flip
  LOT, // TopLeftOutAngleCP
  ROT, // TopLeftOutAngleCP + Flip
  LOD, // DownRightOutAngleCP + Flip
  ROD, // DownRightOutAngleCP
  B, // BlockCP
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
        final wallType = board.getWallType(column, row);

        if (wallType != WallType.N) {
          final wallPainter = _getWallPainter(wallType);

          if (wallPainter != null) {
            walls.add(
              DrawWallWidget(
                wall: wallPainter,
                column: column,
                row: row,
                elementSize: elementSize,
                flipX: _needsFlipX(wallType),
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
    // right: 0,
    // height: elementSize - (row > 0 ? 1 : 0),
    child: Transform.flip(
      flipX: flipX,
      child: SizedBox(
        height: elementSize + 1, // Небольшой overlap
        width: elementSize + 1,
        child: CustomPaint(size: Size(elementSize, elementSize), painter: wall),
      ),
    ),
  );
}
