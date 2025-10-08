import 'package:qlutter/ver_1/app/ui/components/app_palette.dart';
import 'package:qlutter/ver_1/game/game_core/game_core.dart';
import 'package:qlutter/ver_1/game/level_builder/data/local_level_repository.dart';
import 'package:qlutter/ver_1/game/level_builder/domain/entities/level_entity/level_entity.dart';
import 'package:qlutter/ver_1/game/level_builder/domain/level_repository.dart';

export 'package:qlutter/ver_1/game/level_builder/domain/entities/level_entity/level_entity.dart';

class LevelBuilder {
  LevelBuilder() {
    readLevels();
  }
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

  Map<int, Level>? levels;
  Field? field;

  Future<Map<int, Level>> readLevels() async {
    LevelRepository repo = LocalLevelRepository();
    if (levels == null) {
      final levelList = await repo.getLevels() as List<Level>;
      levels = levelList.asMap();
    }
    // await Future.delayed(const Duration(seconds: 5));
    return Future.value(levels);
  }

  Field copyField(Field field) {
    var newField = Field(
      Level(
        field.level.field.map((row) => [...row]).toList(),
        field.level.levelId,
      )..size = field.level.size,
    );
    return newField;
  }

  static Item? convertLegendToItem(int itemLegend, int id) {
    final pallete = Palette();
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
}
