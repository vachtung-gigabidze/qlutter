// providers/app_state_provider.dart
import 'package:flutter/material.dart';
import 'package:qlutter/ver_2/models/app_state.dart';
import 'package:qlutter/ver_2/widgets/app_state_container.dart';

class AppStateProvider {
  static AppState of(BuildContext context) {
    final inherited = context
        .dependOnInheritedWidgetOfExactType<InheritedAppState>();
    return inherited!.state;
  }

  static AppStateContainerState containerOf(BuildContext context) =>
      AppStateContainer.of(context);

  // Методы для обновления состояния
  static void updateCurrentLevel(BuildContext context, int level) {
    containerOf(context).updateCurrentLevel(level);
  }

  static void markLevelCompleted(BuildContext context, int level) {
    containerOf(context).markLevelCompleted(level);
  }

  static void setLoading(BuildContext context, bool loading) {
    containerOf(context).setLoading(loading);
  }

  static void setError(BuildContext context, String? error) {
    containerOf(context).setError(error);
  }

  static void resetProgress(BuildContext context) {
    containerOf(context).resetProgress();
  }

  // Вспомогательные методы
  static bool isLevelCompleted(BuildContext context, int level) =>
      of(context).isLevelCompleted(level);

  static bool isLevelUnlocked(BuildContext context, int level) =>
      of(context).isLevelUnlocked(level);

  static int getCurrentLevel(BuildContext context) => of(context).currentLevel;

  static int getTotalLevels(BuildContext context) => of(context).totalLevels;
}
