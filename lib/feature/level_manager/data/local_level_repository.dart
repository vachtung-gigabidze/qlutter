import 'dart:convert';
import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:qlutter/feature/level_manager/data/dto/level_dto.dart';
import 'package:qlutter/feature/level_manager/domain/entities/level_entity/level_entity.dart';
import 'package:qlutter/feature/level_manager/domain/level_repository.dart';

@Injectable(as: LevelRepository)
// @prod
class LocalLevelRepository implements LevelRepository {
  LocalLevelRepository();

  @override
  Future<List<Level>> getLevels() async {
    try {
      final levelTxt = await File('./assets/data/classic.txt').readAsString();
      final levelDTOs = await LevelDto.openLevels(levelTxt);

      List<Level> levels =
          levelDTOs.values.map((value) => value.toLevel()).toList();

      return levels;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future sendProcess(
      {int? levelId, int? steps, int? seconds, DateTime? dateTime}) {
    return Future(() => null);
  }
}
