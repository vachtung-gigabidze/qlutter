import 'package:injectable/injectable.dart';
import 'package:qlutter/app/domain/app_api.dart';
import 'package:qlutter/feature/level_records/domain/entities/level_record.dart';
import 'package:qlutter/feature/level_records/domain/level_record_repository.dart';

@Injectable(as: LevelRecordRepository)
class NetworkLevelRecordsRepository implements LevelRecordRepository {
  final AppApi api;

  NetworkLevelRecordsRepository(this.api);

  @override
  Future getRecords() async {
    try {
      final response = await api.getProgress();
      List responseJson = response.data;
      List<LevelRecord> levelRecords =
          responseJson.map((v) => LevelRecord.fromJson(v)).toList();
      return levelRecords;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future getBestRecords() async {
    try {
      final response = await api.getBestRecords();
      List responseJson = response.data;
      List<LevelRecord> levelRecords =
          responseJson.map((v) => LevelRecord.fromJson(v)).toList();
      return levelRecords;
    } catch (_) {
      rethrow;
    }
  }
}
