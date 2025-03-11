// import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:qlutter/game/level_builder/data/dto/level_dto.dart';
import 'package:qlutter/game/level_builder/domain/entities/level_entity/level_entity.dart';
import 'package:qlutter/game/level_builder/domain/level_repository.dart';

class LocalLevelRepository implements LevelRepository {
  LocalLevelRepository();

  @override
  Future<List<Level>> getLevels() async {
    try {
      final levelTxt = await rootBundle.loadString('assets/data/classic.txt');
      final levelDTOs = await LevelDto.openLevels(levelTxt);

      List<Level> levels =
          levelDTOs.values.map((value) => value.toLevel()).toList();

      return levels;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future sendProcess({
    int? levelId,
    int? steps,
    int? seconds,
    DateTime? dateTime,
  }) {
    return Future(() => null);
  }
}
