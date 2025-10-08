import 'package:qlutter/ver_1/game/game_core/game_core.dart';
import 'package:qlutter/ver_1/game/level_builder/level_builder.dart';
import 'package:flutter/services.dart';

part 'level_dto.g.dart';

class ItemDto {
  ItemDto({required this.code});

  factory ItemDto.fromJson(Map<String, dynamic> json) =>
      _$ItemDtoFromJson(json);
  int? code;

  Map<String, dynamic> toJson() => _$ItemDtoToJson(this);

  Item? toItem(int id) => LevelBuilder.convertLegendToItem(code!, id);
}

class SizeDto {
  SizeDto(this.h, this.w);

  factory SizeDto.fromJson(Map<String, dynamic> json) =>
      _$SizeDtoFromJson(json);
  final int h;
  final int w;

  Map<String, dynamic> toJson() => _$SizeDtoToJson(this);
}

class LevelDto {
  LevelDto({required this.field, required this.levelId});

  factory LevelDto.fromJson(Map<String, dynamic> json) =>
      _$LevelDtoFromJson(json);

  int levelId;
  late List<List<ItemDto?>> field;
  late SizeDto size;

  Map<String, dynamic> toJson() => _$LevelDtoToJson(this);

  Level toLevel() {
    var i = 0;
    return Level(
      field.map((r) => r.map((e) => e!.toItem(i++)).toList()).toList(),
      levelId,
    )..size = Size(size.w + .0, size.h + .0);
  }

  static Future<Map<int, LevelDto>> openLevels(String levelsFile) async {
    final levels = <int, LevelDto>{};
    var rowNum = 0;
    final rows = levelsFile.split('\n');
    List<List<ItemDto?>> field;
    List<ItemDto?> fieldRow;

    var levelId = 0;
    while (levelId != 60) {
      levelId = int.parse(rows[rowNum]);
      rowNum++;
      final w = int.parse(rows[rowNum].split(' ')[0]);
      final h = int.parse(rows[rowNum].split(' ')[1]);
      rowNum++;
      field = [];
      for (var i = 0; i < h; i++) {
        fieldRow = [];
        for (final element in rows[rowNum].split(' ').map(int.parse)) {
          fieldRow.add(ItemDto(code: element));
        }
        field.add(fieldRow);
        rowNum++;
      }
      levels[levelId] = LevelDto(field: field, levelId: levelId)
        ..size = SizeDto(h, w);
    }
    return Future.value(levels);
  }
}
