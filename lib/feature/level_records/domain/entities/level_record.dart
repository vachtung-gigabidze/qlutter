import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'level_record.freezed.dart';
part 'level_record.g.dart';

@freezed
class LevelRecord with _$LevelRecord {
  const factory LevelRecord({
    required int? id,
    required int? levelId,
    required int? steps,
    required String? datetime,
    required int? seconds,
    int? user,
  }) = _LevelRecord;

  factory LevelRecord.fromJson(Map<String, dynamic> json) =>
      _$LevelRecordFromJson(json);
}
