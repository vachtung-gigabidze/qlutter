import 'package:flutter/material.dart';
import 'package:qlutter/feature/level_manager/domain/entities/level_entity/level_entity.dart';

class Item {
  Color color;
  Item({required this.color});

  int get hashCode => Object.hash(runtimeType, color);

  @override
  bool operator ==(other) => other is Item && other.color == color;
}

class Block extends Item {
  Block() : super(color: Colors.grey);
}

class Ball extends Item {
  bool get selected => true;
  int id;
  Ball(Color color, this.id) : super(color: color);
}

class Hole extends Item {
  Hole(Color color) : super(color: color);
}

// class Level {
//   int levelId;
//   late List<List<Item?>> field;
//   late int ballsCount;
//   late Map<Color, int> colorsBall;
//   late Size size;

//   Level(this.field, this.levelId) {
//     ballsCount = _countBallOnLevel();
//   }

//   int elements() => (size.width * size.height).round();

//   int _countBallOnLevel() {
//     colorsBall = <Color, int>{};
//     ballsCount = field.fold(
//         0,
//         (int sum, List<Item?> el) =>
//             sum +
//             el.fold(0, (int pre, Item? item) {
//               if (item != null && item is Ball) {
//                 colorsBall[item.color] = (colorsBall[item.color] ?? 0) + 1;
//               }
//               return (item is Ball) ? pre + 1 : pre;
//             }));

//     return ballsCount;
//   }
// }

enum Direction { left, right, up, down, nowhere }

class Field {
  Level level;
  late int ballsCount;
  late int moveCount;
  late DateTime? start;
  late DateTime? end;

  Field(this.level) {
    start = null;
    end = null;
    moveCount = 0;
    ballsCount = level.ballsCount;
  }

  static Field copyField(Field field) {
    Field newField = Field(Level(
        field.level.field.map((row) => [...row]).toList(), field.level.levelId)
      ..size = field.level.size);
    return newField;
  }

  Coordinates moveRight(int xCoord, int yCoord) {
    try {
      while (level.field[yCoord][xCoord + 1] == null) {
        level.field[yCoord][xCoord + 1] = level.field[yCoord][xCoord];

        level.field[yCoord][xCoord++] = null;
      }
    } catch (e) {
      throw Exception(e);
    }

    return Coordinates(xCoord, yCoord);
  }

  Coordinates moveLeft(int xCoord, int yCoord) {
    try {
      while (level.field[yCoord][xCoord - 1] == null) {
        level.field[yCoord][xCoord - 1] = level.field[yCoord][xCoord];

        level.field[yCoord][xCoord--] = null;
      }
    } catch (e) {
      throw Exception(e);
    }

    return Coordinates(xCoord, yCoord);
  }

  Coordinates moveUp(int xCoord, int yCoord) {
    try {
      while (level.field[yCoord - 1][xCoord] == null) {
        level.field[yCoord - 1][xCoord] = level.field[yCoord][xCoord];

        level.field[yCoord--][xCoord] = null;
      }
    } catch (e) {
      throw Exception(e);
    }

    return Coordinates(xCoord, yCoord);
  }

  Coordinates moveDown(int xCoord, int yCoord) {
    try {
      while (level.field[yCoord + 1][xCoord] == null) {
        level.field[yCoord + 1][xCoord] = level.field[yCoord][xCoord];

        level.field[yCoord++][xCoord] = null;
      }
    } catch (e) {
      throw Exception(e);
    }

    return Coordinates(xCoord, yCoord);
  }

  Coordinates? moveItem(Coordinates coordinates, Direction direction) {
    int horizontal = coordinates.horizontal;
    int vertical = coordinates.vertical;

    start ??= DateTime.now();

    if (level.field[horizontal][vertical] == null) {
      return null;
    }

    if (level.field[horizontal][vertical] is! Ball) {
      return null;
    }

    switch (direction) {
      case Direction.right:
        return moveRight(vertical, horizontal);

      case Direction.left:
        return moveLeft(vertical, horizontal);

      case Direction.up:
        return moveUp(vertical, horizontal);

      case Direction.down:
        return moveDown(vertical, horizontal);
      case Direction.nowhere:
        return null;
    }
  }

  bool isEdge(Coordinates coordItemNearly) {
    //TODO: need check null cell until not edge field
    return (coordItemNearly.horizontal == 0 ||
        coordItemNearly.vertical == 0 ||
        coordItemNearly.horizontal == level.size.height - 1 ||
        coordItemNearly.vertical == level.size.height - 1 ||
        coordItemNearly.horizontal == level.size.width - 1 ||
        coordItemNearly.vertical == level.size.width - 1);
  }

  bool acceptBall(Coordinates coordItem, Coordinates coordItemNearly) {
    try {
      Item? item = level.field[coordItem.horizontal][coordItem.vertical];
      Item? itemNearly =
          level.field[coordItemNearly.horizontal][coordItemNearly.vertical];

      if (itemNearly == null ||
          itemNearly is! Hole ||
          !(itemNearly.color == item?.color)) {
        return false;
      }

      if (isLastColorBall(item!.color)) {
        if (isEdge(coordItemNearly)) {
          level.field[coordItemNearly.horizontal][coordItemNearly.vertical] =
              Block();
        } else {
          level.field[coordItemNearly.horizontal][coordItemNearly.vertical] =
              null;
        }
      }

      level.field[coordItem.horizontal][coordItem.vertical] = null;
      catchBall();
    } catch (e) {
      throw Exception(e);
    }

    return true;
  }

  bool acceptHole(Coordinates coordinates) {
    bool isAccepted = false;

    isAccepted = (acceptBall(coordinates,
            Coordinates(coordinates.horizontal, coordinates.vertical - 1)) ||
        acceptBall(coordinates,
            Coordinates(coordinates.horizontal, coordinates.vertical + 1)) ||
        acceptBall(coordinates,
            Coordinates(coordinates.horizontal + 1, coordinates.vertical)) ||
        acceptBall(coordinates,
            Coordinates(coordinates.horizontal - 1, coordinates.vertical)));

    return isAccepted;
  }

  catchBall() {
    ballsCount--;
  }

  checkWin() {
    if (ballsCount == 0) {
      end ??= DateTime.now();
      return true;
    }
    return false;
  }

  List<bool> canMove(Coordinates coordinates) {
    return [
      level.field[coordinates.horizontal][coordinates.vertical + 1] == null,
      level.field[coordinates.horizontal][coordinates.vertical - 1] == null,
      level.field[coordinates.horizontal + 1][coordinates.vertical] == null,
      level.field[coordinates.horizontal - 1][coordinates.vertical] == null
    ];
  }

  bool isLastColorBall(Color color) {
    level.colorsBall.update(color, (value) => value -= 1);
    return (level.colorsBall[color] == 0);
  }
}

class Coordinates {
  int horizontal;
  int vertical;

  Coordinates(this.horizontal, this.vertical);
}
