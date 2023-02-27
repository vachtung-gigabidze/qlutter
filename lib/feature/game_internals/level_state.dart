import 'package:flutter/foundation.dart';
import 'package:qlutter/app/di/init_di.dart';
import 'package:qlutter/feature/level_manager/domain/level_repository.dart';

class LevelState extends ChangeNotifier {
  final Function(int) onWin;

  final int goal;

  LevelState({required this.onWin, this.goal = 0});

  int _progress = 0;
  int _steps = 0;

  int get progress => _progress;

  void setProgress(int value, int step) {
    _progress = value;
    _steps = step;
    notifyListeners();
  }

  void evaluate(int levelId) {
    if (_progress == goal) {
      onWin(_steps);
    }
  }
}
