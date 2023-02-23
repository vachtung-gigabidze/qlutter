import 'package:injectable/injectable.dart';
import 'package:qlutter/app/domain/app_api.dart';
import 'package:qlutter/feature/level_manager/data/dto/level_dto.dart';
import 'package:qlutter/feature/level_manager/domain/entities/level_entity/level_entity.dart';
import 'package:qlutter/feature/level_manager/domain/level_repository.dart';

@Injectable(as: LevelRepository)
// @prod
class NetworkLevelRepository implements LevelRepository {
  final AppApi api;

  NetworkLevelRepository(this.api);

  @override
  Future<List<Level>> getLevels() async {
    try {
      final response = await api.getLevel();
      List responseJson = response.data;
      List<Level> levels =
          responseJson.map((v) => LevelDto.fromJson(v).toLevel()).toList();

      return levels;
    } catch (e) {
      rethrow;
    }
  }
}
