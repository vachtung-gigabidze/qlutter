import 'package:freezed_annotation/freezed_annotation.dart'
    show JsonSerializable;
import 'package:qlutter/game/game_core/game_core.dart';
import 'package:qlutter/feature/level_builder/level_builder.dart';
import 'package:flutter/services.dart';

part 'level_dto.g.dart';

@JsonSerializable()
class ItemDto {
  ItemDto({required this.code});
  int? code;

  factory ItemDto.fromJson(Map<String, dynamic> json) =>
      _$ItemDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ItemDtoToJson(this);

  Item? toItem(int id) {
    return LevelBuilder.convertLegendToItem(code!, id);
  }
}

@JsonSerializable()
class SizeDto {
  SizeDto(this.h, this.w);
  final int h;
  final int w;

  factory SizeDto.fromJson(Map<String, dynamic> json) =>
      _$SizeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SizeDtoToJson(this);
}

@JsonSerializable()
class LevelDto {
  LevelDto({required this.field, required this.levelId});

  int levelId;
  late List<List<ItemDto?>> field;
  late SizeDto size;

  factory LevelDto.fromJson(Map<String, dynamic> json) =>
      _$LevelDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LevelDtoToJson(this);

  Level toLevel() {
    int i = 0;
    return Level(
      field.map((r) => r.map((e) => e!.toItem(i++)).toList()).toList(),
      levelId,
    )..size = Size(size.w + .0, size.h + .0);
  }

  static Future<Map<int, LevelDto>> openLevels(String levelsFile) async {
    final levels = <int, LevelDto>{};
    int rowNum = 0;
    final rows = levelsFile.split('\n');
    List<List<ItemDto?>> field;
    List<ItemDto?> fieldRow;

    int levelId = 0;
    while (levelId != 60) {
      levelId = int.parse(rows[rowNum]);
      rowNum++;
      final w = int.parse(rows[rowNum].split(' ')[0]);
      final h = int.parse(rows[rowNum].split(' ')[1]);
      rowNum++;
      field = [];
      for (var i = 0; i < h; i++) {
        fieldRow = [];
        for (int element in rows[rowNum].split(' ').map(int.parse)) {
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
