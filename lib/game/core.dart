import 'package:flutter/material.dart';

abstract class Item {
  late Color color;

  Item({required Color color}) {
    setColor(color);
  }

  Color getColor() {
    return color;
  }

  setColor(Color color) {
    this.color = color;
  }
}

class Block extends Item {
  Block({super.color = Colors.grey});
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
}

class Coordinates {
  int horizontal;
  int vertical;

  Coordinates(this.horizontal, this.vertical);
}
