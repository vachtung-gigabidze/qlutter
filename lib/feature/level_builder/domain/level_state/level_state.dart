part of 'level_cubit.dart';

@freezed
class LevelState with _$LevelState {
  factory LevelState.empty() = _LevelStateEmpty;
  factory LevelState.loaded(List<LevelDto> levels) = _LevelStateLoaded;

  factory LevelState.fromJson(Map<String, dynamic> json) =>
      _$LevelStateFromJson(json);

  // Map<String, dynamic> toJson() => _$LevelStateToJson(this);
}
