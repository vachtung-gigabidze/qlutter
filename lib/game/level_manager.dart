import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qlutter/game/core.dart';

class LevelManager {
  // final String LEVELS_FOLDER = "classic";
  // final String LEVEL_FILE_EXTENSION = ".txt";

  static const int EMPTY_CELL = 0;
  static const int BLOCK_CELL = 1;
  static const int BALL1_CELL = 2;
  static const int BALL2_CELL = 3;
  static const int BALL3_CELL = 4;
  static const int BALL4_CELL = 5;
  static const int BALL5_CELL = 6;
  static const int BALL6_CELL = 7;

  static const int HOLE1_CELL = 22;
  static const int HOLE2_CELL = 33;
  static const int HOLE3_CELL = 44;
  static const int HOLE4_CELL = 55;
  static const int HOLE5_CELL = 66;
  static const int HOLE6_CELL = 77;

  late LevelManager? instance;
  Map<int, Level>? levels = null;
  late Field? field;

  LevelManager();

  LevelManager build() {
    instance ??= LevelManager();
    return instance!;
  }

  Future<Field?> getFiled(int levelIndex) async {
    if (levels == null) {
      levels = await openLevels();

      field = Field(levels![levelIndex]!);
    }
    return Future.value(field);
  }

  Item? convertLegendToItem(int itemLegend, int id) {
    switch (itemLegend) {
      case EMPTY_CELL:
        return null;

      case BLOCK_CELL:
        return Block();

      case BALL1_CELL:
        return Ball(Colors.green, id);

      case BALL2_CELL:
        return Ball(Colors.red, id);

      case BALL3_CELL:
        return Ball(Colors.blue, id);

      case BALL4_CELL:
        return Ball(Colors.yellow, id);

      case BALL5_CELL:
        return Ball(Colors.purple, id);

      case BALL6_CELL:
        return Ball(Colors.cyan, id);

      case HOLE1_CELL:
        return Hole(Colors.green);

      case HOLE2_CELL:
        return Hole(Colors.red);

      case HOLE3_CELL:
        return Hole(Colors.blue);

      case HOLE4_CELL:
        return Hole(Colors.yellow);

      case HOLE5_CELL:
        return Hole(Colors.purple);

      case HOLE6_CELL:
        return Hole(Colors.cyan);
    }

    return null;
  }

  Future<Map<int, Level>> openLevels() async {
    String levelsFile = await rootBundle.loadString('assets/classic.txt');
    Map<int, Level> levels = <int, Level>{};
    int rowNum = 0;
    int elementId = 0;

    List<String> rows = levelsFile.split('\n');

    int level = 0;
    while (level != 10) {
      level = int.parse(rows[rowNum]);
      rowNum++;
      int h = int.parse(rows[rowNum].split(' ')[1]);
      int w = int.parse(rows[rowNum].split(' ')[0]);
      rowNum++;

      List<List<Item?>> l = [];
      for (var i = 0; i < h; i++) {
        List<Item?> fieldRow = [];
        for (int element in rows[rowNum].split(' ').map((e) => int.parse(e))) {
          elementId++;
          fieldRow.add(convertLegendToItem(element, elementId));
        }
        l.add(fieldRow);
        rowNum++;
      }
      levels[level] = Level(l)..size = Size(h + .0, w + .0);
    }
    return Future.value(levels);
  }
}
