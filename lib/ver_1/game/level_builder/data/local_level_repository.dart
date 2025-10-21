// import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:qlutter/ver_1/game/level_builder/data/dto/level_dto.dart';
import 'package:qlutter/ver_1/game/level_builder/domain/entities/level_entity/level_entity.dart';
import 'package:qlutter/ver_1/game/level_builder/domain/level_repository.dart';

class LocalLevelRepository implements LevelRepository {
  LocalLevelRepository();

  @override
  Future<List<Level>> getLevels() async {
    try {
      final levelTxt = await rootBundle.loadString('assets/data/classic.txt');
      final levelDTO = await LevelDto.openLevels(levelTxt);

      var levels = levelDTO.values.map((value) => value.toLevel()).toList();

      return levels;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> sendProcess({
    int? levelId,
    int? steps,
    int? seconds,
    DateTime? dateTime,
  }) => Future(() => null);
}
