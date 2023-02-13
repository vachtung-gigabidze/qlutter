import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qlutter/feature/level_manager/data/dto/level_dto.dart';
import 'package:qlutter/feature/level_manager/domain/level_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'level_cubit.freezed.dart';
part 'level_state.dart';

class LevelCubit extends Cubit<LevelState> {
  final LevelRepository levelRepository;

  LevelCubit(this.levelRepository) : super(LevelState.empty());
}
