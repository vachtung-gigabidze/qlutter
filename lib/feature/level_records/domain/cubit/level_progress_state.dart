part of 'level_progress_cubit.dart';

@freezed
class LevelProgressState with _$LevelProgressState {
  factory LevelProgressState.empty() = _LevelProgressStateEmpty;
  factory LevelProgressState.loaded(List<LevelRecord> records) =
      _LevelProgressStateLoaded;
  factory LevelProgressState.error(dynamic error) = _LevelProgressStateError;

  factory LevelProgressState.fromJson(Map<String, dynamic> json) =>
      _$LevelProgressStateFromJson(json);
}
