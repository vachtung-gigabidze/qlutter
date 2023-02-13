import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qlutter/feature/level_manager/data/dto/level_dto.dart';
import 'package:qlutter/feature/level_manager/domain/level_repository.dart';

class LevelCubit extends Cubit<LevelState> {
  final LevelRepository levelRepository;

  LevelCubit(this.levelRepository) : super(LevelState.empty());
}

@freezed
class LevelState with _$LevelState {
  factory LevelState.empty() = _LevelStateEmpty;
  factory LevelState.loaded(List<LevelDto> recipeList) = _LevelStateLoaded;
  factory LevelState.waiting() = _LevelStateWaiting;
  factory LevelState.error(dynamic error) = _LevelStateError;

  factory LevelState.fromJson(Map<String, dynamic> json) =>
      _$LevelStateFromJson(json);
}
