import 'package:qlutter/feature/level_records/domain/entities/level_record.dart';

abstract class LevelRecordRepository {
  Future<dynamic> getRecords();
}
