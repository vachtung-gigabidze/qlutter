import 'dart:async';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:qlutter/feature/level_manager/data/dto/level_dto.dart';
import 'package:qlutter/feature/level_manager/domain/level_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'level_state.dart';
part 'level_cubit.freezed.dart';
part 'level_cubit.g.dart';

class LevelCubit extends HydratedCubit<LevelState> {
  LevelCubit(this.levelRepository) : super(LevelState.empty());

  final LevelRepository levelRepository;

  Future<void> getLevelList({bool refresh = false}) async {
    if (state is _LevelStateLoaded && !refresh) {
      return;
    }

    try {
      final List<LevelDto>? levelList = await levelRepository.getLevels();
      emit(LevelState.loaded(levelList!));
    } catch (error) {
      emit(LevelState.loaded([]));
    }
  }

  @override
  LevelState? fromJson(Map<String, dynamic> json) {
    final state = LevelState.fromJson(json);
    return state.whenOrNull(
      loaded: (levelList) => LevelState.loaded(levelList),
    );
  }

  @override
  Map<String, dynamic>? toJson(LevelState state) {
    return state
            .whenOrNull(
              loaded: (levelList) => LevelState.loaded(levelList),
            )
            ?.toJson() ??
        LevelState.empty().toJson();
  }
}
