import 'package:flutter/material.dart';

abstract class Item {
  Color color;

  Item({required this.color});
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

class Level {
  int levelId;
  late List<List<Item?>> field;
  late int ballsCount;
  late Size size;

  Level(this.field, this.levelId) {
    ballsCount = _countBallOnLevel();
  }

  int elements() => (size.width * size.height).round();

  int _countBallOnLevel() {
    ballsCount = field.fold(
        0,
        (int sum, List<Item?> el) =>
            sum +
            el.fold(0, (int pre, Item? item) {
              return (item is Ball) ? pre + 1 : pre;
            }));

    return ballsCount;
  }
}

enum Direction { left, right, up, down, nowhere }

class Field {
  Level level;
  late int ballsCount;

  Field(this.level) {
    ballsCount = level._countBallOnLevel();
  }

  Coordinates moveRight(int xCoord, int yCoord) {
    try {
      while (level.field[yCoord][xCoord + 1] ==
              null /* ||
          level.field[yCoord][xCoord]?.color ==
              level.field[yCoord][xCoord + 1]?.color*/
          ) {
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
      while (level.field[yCoord][xCoord - 1] ==
              null /*||
          level.field[yCoord][xCoord]?.color ==
              level.field[yCoord][xCoord - 1]?.color*/
          ) {
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
      while (level.field[yCoord - 1][xCoord] ==
              null /*||
          level.field[yCoord][xCoord]?.color ==
              level.field[yCoord - 1][xCoord]?.color*/
          ) {
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
      while (level.field[yCoord + 1][xCoord] ==
              null /*||
          level.field[yCoord + 1][xCoord]?.color ==
              level.field[yCoord][xCoord]?.color*/
          ) {
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

      if (isEdge(coordItemNearly)) {
        level.field[coordItemNearly.horizontal][coordItemNearly.vertical] =
            Block();
      } else {
        level.field[coordItemNearly.horizontal][coordItemNearly.vertical] =
            null;
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

    // if (!isAccepted) {
    //   return false;
    // }

    // catchBall();

    // return checkWin();
  }

  catchBall() {
    ballsCount--;
  }

  checkWin() {
    return ballsCount == 0;
  }

  List<bool> canMove(Coordinates coordinates) {
    return [
      level.field[coordinates.horizontal][coordinates.vertical + 1] == null,
      level.field[coordinates.horizontal][coordinates.vertical - 1] == null,
      level.field[coordinates.horizontal + 1][coordinates.vertical] == null,
      level.field[coordinates.horizontal - 1][coordinates.vertical] == null
    ];
  }

  // bool gameStep(Coordinates coordinates, Direction direction) {
  //   Coordinates? newCoordinates = moveItem(coordinates, direction);
  //   return newCoordinates != null && acceptHole(newCoordinates);
  // }
}

class Coordinates {
  int horizontal;
  int vertical;

  Coordinates(this.horizontal, this.vertical);
}
