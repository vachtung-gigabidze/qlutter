import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qlutter/game/core.dart';

class LevelManager {
  final String LEVELS_FOLDER = "levels";
  final String LEVEL_FILE_EXTENSION = ".lev";

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
  late Future<Map<int, Level>> levels;

  LevelManager() {
    levels = openLevels();
  }

  LevelManager build() {
    instance ??= LevelManager();
    return instance!;
  }

  Future<Level?> getLevel(int levelIndex) async {
    return levels.then((value) => value[levelIndex]);
    ;
  }

  Item? convertLegendToItem(int itemLegend) {
    switch (itemLegend) {
      case EMPTY_CELL:
        return null;

      case BLOCK_CELL:
        return Block(Colors.grey);

      case BALL1_CELL:
        return Ball(Colors.green);

      case BALL2_CELL:
        return Ball(Colors.red);

      case BALL3_CELL:
        return Ball(Colors.blue);

      case BALL4_CELL:
        return Ball(Colors.yellow);

      case BALL5_CELL:
        return Ball(Colors.purple);

      case BALL6_CELL:
        return Ball(Colors.cyan);

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

    List<String> rows = levelsFile.split('\n');

    int level = 0;
    while (level != 60) {
      level = int.parse(rows[rowNum]);
      rowNum++;
      int h = int.parse(rows[rowNum].split(' ')[1]);
      int w = int.parse(rows[rowNum].split(' ')[0]);
      rowNum++;

      List<List<Item?>> l = [];
      for (var i = 0; i < h; i++) {
        List<Item?> fieldRow = [];
        for (int element in rows[rowNum].split(' ').map((e) => int.parse(e))) {
          fieldRow.add(convertLegendToItem(element));
        }
        l.add(fieldRow);
        rowNum++;
      }
      levels[level] = Level(l)..size = Size(w + .0, h + .0);
    }
    return Future.value(levels);
  }
}
