import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qlutter/game/core/core.dart';

class LevelManager {
  static const int emptyCell = 0;
  static const int blockCell = 1;
  static const int ballCall1 = 2;
  static const int ballCell2 = 3;
  static const int ballCell3 = 4;
  static const int ballCell4 = 5;
  static const int ballCell5 = 6;
  static const int ballCell6 = 7;

  static const int holeCell1 = 22;
  static const int holeCell2 = 33;
  static const int holeCell3 = 44;
  static const int holeCell4 = 55;
  static const int holeCell5 = 66;
  static const int holeCell6 = 77;

  late LevelManager? instance;
  Map<int, Level>? levels;
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
    } else if (field?.level.levelId != levelIndex) {
      field = Field(levels![levelIndex]!);
    }
    return Future.value(field);
  }

  Field copyField(Field field) {
    Field newField = Field(Level(
        field.level.field.map((row) => [...row]).toList(), field.level.levelId)
      ..size = field.level.size);
    return newField;
  }

  Item? convertLegendToItem(int itemLegend, int id) {
    switch (itemLegend) {
      case emptyCell:
        return null;

      case blockCell:
        return Block();

      case ballCall1:
        return Ball(Colors.green, id);

      case ballCell2:
        return Ball(Colors.red, id);

      case ballCell3:
        return Ball(Colors.blue, id);

      case ballCell4:
        return Ball(Colors.yellow, id);

      case ballCell5:
        return Ball(Colors.purple, id);

      case ballCell6:
        return Ball(Colors.cyan, id);

      case holeCell1:
        return Hole(Colors.green);

      case holeCell2:
        return Hole(Colors.red);

      case holeCell3:
        return Hole(Colors.blue);

      case holeCell4:
        return Hole(Colors.yellow);

      case holeCell5:
        return Hole(Colors.purple);

      case holeCell6:
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
      levels[level] = Level(l, level)..size = Size(h + .0, w + .0);
    }
    return Future.value(levels);
  }
}
