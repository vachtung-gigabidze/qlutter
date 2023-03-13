import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:qlutter/feature/level_records/domain/entities/level_record.dart';
import 'package:qlutter/feature/level_records/domain/level_record_repository.dart';
import 'package:json_annotation/json_annotation.dart';

part 'level_progress_state.dart';
part 'level_progress_cubit.freezed.dart';
part 'level_progress_cubit.g.dart';

@Singleton()
class LevelProgressCubit extends Cubit<LevelProgressState> {
  LevelProgressCubit(this.levelRecordRepository)
      : super(LevelProgressState.empty());

  final LevelRecordRepository levelRecordRepository;

  Future<void> getRecords() async {
    try {
      final List<LevelRecord> recordsEntity =
          await levelRecordRepository.getRecords();

      Map<int, LevelRecord> m = <int, LevelRecord>{};

      for (LevelRecord e in recordsEntity) {
        if (e.levelId != null && e.seconds != null) {
          if (m[e.levelId!] == null) {
            m[e.levelId!] = e;
          } else {
            if (m[e.levelId]!.seconds >= e.seconds) {}
          }
        }
      }

      //  (value, element) => null) sort((a, b) => a.levelId!.compareTo(b.levelId!));

      emit(LevelProgressState.loaded(recordsEntity));
    } catch (error, st) {
      addError(error, st);
    }
  }

  LevelProgressState? fromJson(Map<String, dynamic> json) {
    final state = LevelProgressState.fromJson(json);
    return state.whenOrNull(
      loaded: (recordList) => LevelProgressState.loaded(recordList),
    );
  }

  Map<String, dynamic>? toJson(LevelProgressState state) {
    return state
            .whenOrNull(
              loaded: (recordList) => LevelProgressState.loaded(recordList),
            )
            ?.toJson() ??
        LevelProgressState.empty().toJson();
  }
}
