import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:qlutter/app/di/init_di.dart';
import 'package:qlutter/feature/game_core/game_core.dart';
import 'package:qlutter/feature/level_manager/domain/entities/level_entity/level_entity.dart';
import 'package:qlutter/feature/level_manager/domain/level_repository.dart';
import 'package:qlutter/feature/style/palette.dart';

@Singleton()
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
  late Map<int, Level>? levels;
  late Field? field;

  LevelManager();

  LevelManager build() {
    instance ??= LevelManager();
    return instance!;
  }

  readLevels() async {
    LevelRepository repo = locator.get<LevelRepository>();
    List<Level> levelList = await repo.getLevels();
    levels = levelList.asMap();
    //levels = await openLevels();
  }

  Future<Field?> getFiledAsync(int levelIndex) async {
    if (levels == null) {
      levels = await openLevels();

      field = Field(levels![levelIndex]!);
    } else if (field?.level.levelId != levelIndex) {
      field = Field(levels![levelIndex]!);
    }
    return Future.value(field);
  }

  Field? getFiled(int levelIndex) {
    if (levels != null && field?.level.levelId != levelIndex) {
      field = Field(levels![levelIndex]!);
    }
    return field;
  }

  Field copyField(Field field) {
    Field newField = Field(Level(
        field.level.field.map((row) => [...row]).toList(), field.level.levelId)
      ..size = field.level.size);
    return newField;
  }

  static Item? convertLegendToItem(int itemLegend, int id) {
    final pallete = locator.get<Palette>();
    switch (itemLegend) {
      case emptyCell:
        return null;

      case blockCell:
        return Block();

      case ballCall1:
        return Ball(pallete.cellColor1, id);

      case ballCell2:
        return Ball(pallete.cellColor2, id);

      case ballCell3:
        return Ball(pallete.cellColor3, id);

      case ballCell4:
        return Ball(pallete.cellColor4, id);

      case ballCell5:
        return Ball(pallete.cellColor5, id);

      case ballCell6:
        return Ball(pallete.cellColor6, id);

      case holeCell1:
        return Hole(pallete.cellColor1);

      case holeCell2:
        return Hole(pallete.cellColor2);

      case holeCell3:
        return Hole(pallete.cellColor3);

      case holeCell4:
        return Hole(pallete.cellColor4);

      case holeCell5:
        return Hole(pallete.cellColor5);

      case holeCell6:
        return Hole(pallete.cellColor6);
    }

    return null;
  }

  Future<Map<int, Level>> openLevels() async {
    String levelsFile = await rootBundle.loadString('assets/classic.txt');
    levels = <int, Level>{};
    int rowNum = 0;
    int elementId = 0;

    List<String> rows = levelsFile.split('\n');

    int level = 0;
    while (level != 25) {
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
      levels![level] = Level(
        l,
        level,
      )..size = Size(h + .0, w + .0);
    }

    return Future.value(levels);
  }
}
