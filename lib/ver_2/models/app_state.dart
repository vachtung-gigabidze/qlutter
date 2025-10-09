// models/app_state.dart

import 'package:qlutter/ver_2/game/level_manager.dart';

class AppState {
  const AppState({
    required this.currentLevel,
    required this.completedLevels,
    required this.isLoading,
    required this.levelManager,
    this.error,
  });
  final int currentLevel;
  final Set<int> completedLevels;
  final bool isLoading;
  final String? error;
  final LevelManager levelManager;

  AppState copyWith({
    int? currentLevel,
    Set<int>? completedLevels,
    bool? isLoading,
    String? error,
    LevelManager? levelManager,
  }) => AppState(
    currentLevel: currentLevel ?? this.currentLevel,
    completedLevels: completedLevels ?? this.completedLevels,
    isLoading: isLoading ?? this.isLoading,
    error: error ?? this.error,
    levelManager: levelManager ?? this.levelManager,
  );

  bool isLevelCompleted(int level) => completedLevels.contains(level);
  bool isLevelUnlocked(int level) =>
      level == 1 || completedLevels.contains(level - 1);
  int get totalLevels => levelManager.totalLevels;
}
