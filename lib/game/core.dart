import 'package:flutter/material.dart';

abstract class Item {
  Color color;

  Item({required this.color});
}

class Block extends Item {
  Block(Color color) : super(color: color);
}

class Ball extends Item {
  Ball(Color color) : super(color: color);
}

class Hole extends Item {
  Hole(Color color) : super(color: color);
}

class Level {
  late List<List<Item?>> field;
  late int ballsCount;

  Level(this.field) {
    ballsCount = _countBallOnLevel();
  }

  int _countBallOnLevel() {
    ballsCount = field.fold(
        0, (pre, el) => el.fold(0, (pre, el) => (el is Ball) ? pre++ : pre));

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

    if (level.field[vertical][horizontal] == null) {
      return null;
    }

    if (level.field[vertical][horizontal] is! Ball) {
      return null;
    }

    switch (direction) {
      case Direction.right:
        return moveRight(horizontal, vertical);

      case Direction.left:
        return moveLeft(horizontal, vertical);

      case Direction.up:
        return moveUp(horizontal, vertical);

      case Direction.down:
        return moveDown(horizontal, vertical);
      case Direction.nowhere:
        return null;
    }
  }

  bool acceptBall(int horizontal, int vertical) {
    try {
      // int horizontal = coordinates.horizontal;
      // int vertical = coordinates.vertical;

      Item? upItem = level.field[vertical][horizontal];
      Item? item = level.field[vertical][horizontal];

      if (upItem == null || upItem is! Hole || !(upItem.color == item?.color)) {
        return false;
      }

      level.field[vertical][horizontal] = null;
    } catch (e) {
      throw Exception(e);
    }

    return true;
  }

  bool acceptHole(Coordinates coordinates, Direction direction) {
    bool isAccepted = false;
    switch (direction) {
      case Direction.up:
        isAccepted =
            acceptBall(coordinates.horizontal, coordinates.vertical - 1);
        break;

      case Direction.down:
        isAccepted =
            acceptBall(coordinates.horizontal, coordinates.vertical + 1);
        break;

      case Direction.right:
        isAccepted =
            acceptBall(coordinates.horizontal + 1, coordinates.vertical);
        break;

      case Direction.left:
        isAccepted =
            acceptBall(coordinates.horizontal - 1, coordinates.vertical);
        break;
      case Direction.nowhere:
        return false;
    }

    if (!isAccepted) {
      return false;
    }

    catchBall();

    return checkWin();
  }

  catchBall() {
    ballsCount--;
  }

  checkWin() {
    return ballsCount == 0;
  }

  bool makeTurn(Coordinates coordinates, Direction direction) {
    Coordinates? newCoordinates = moveItem(coordinates, direction);
    return newCoordinates != null && acceptHole(newCoordinates, direction);
  }
}

class Coordinates {
  int horizontal;
  int vertical;

  Coordinates(this.horizontal, this.vertical);
}