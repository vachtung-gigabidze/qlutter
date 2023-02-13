import 'package:injectable/injectable.dart';
import 'package:qlutter/app/domain/app_api.dart';
import 'package:qlutter/feature/game_core/game_core.dart';
import 'package:qlutter/feature/level_manager/data/dto/level_dto.dart';
import 'package:qlutter/feature/level_manager/domain/level_repository.dart';

@Injectable(as: LevelRepository)
// @prod
class NetworkLevelRepository implements LevelRepository {
  final AppApi api;

  NetworkLevelRepository(this.api);

  @override
  Future<LevelDto> getLevels() async {
    try {
      final response = await api.getLevel();
      return LevelDto.fromJson(response.data["data"]);
    } catch (_) {
      rethrow;
    }
  }
}
