// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
// import 'package:injectable/injectable.dart';
import 'package:qlutter/feature/level_records/domain/entities/level_record.dart';
import 'package:qlutter/feature/level_records/domain/level_record_repository.dart';
// import 'package:json_annotation/json_annotation.dart';

part 'level_progress_state.dart';
part 'level_progress_cubit.freezed.dart';
part 'level_progress_cubit.g.dart';

// @Singleton()
class LevelProgressCubit extends HydratedCubit<LevelProgressState> {
  LevelProgressCubit(this.levelRecordRepository)
      : super(LevelProgressState.empty());

  final LevelRecordRepository levelRecordRepository;

  Future<void> getRecords() async {
    try {
      final List<LevelRecord> recordsEntity =
          await levelRecordRepository.getRecords();

      Map<int, LevelRecord> m = <int, LevelRecord>{};

      recordsEntity.sort((a, b) => a.levelId.compareTo(b.levelId));

      for (LevelRecord e in recordsEntity) {
        if (m[e.levelId] == null) {
          m[e.levelId] = e;
        } else {
          final p = m[e.levelId];
          if (p != null) {
            if (e.seconds < p.seconds) {
              m[e.levelId] = e;
            }
          }
        }
      }

      //  (value, element) => null) sort((a, b) => a.levelId!.compareTo(b.levelId!));

      emit(LevelProgressState.loaded(m.values.toList()));
    } catch (error, st) {
      addError(error, st);
    }
  }

  Future<void> getBestRecords() async {
    try {
      final List<LevelRecord> recordsEntity =
          await levelRecordRepository.getBestRecords();

      emit(LevelProgressState.loaded(recordsEntity));
    } catch (error, st) {
      addError(error, st);
    }
  }

  @override
  LevelProgressState? fromJson(Map<String, dynamic> json) {
    final state = LevelProgressState.fromJson(json);
    return state.whenOrNull(
      loaded: (recordList) => LevelProgressState.loaded(recordList),
    );
  }

  @override
  Map<String, dynamic>? toJson(LevelProgressState state) {
    return state
            .whenOrNull(
              loaded: (recordList) => LevelProgressState.loaded(recordList),
            )
            ?.toJson() ??
        LevelProgressState.empty().toJson();
  }
}
