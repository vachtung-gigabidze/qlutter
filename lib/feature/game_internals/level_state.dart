import 'package:flutter/foundation.dart';

/// An extremely silly example of a game state.
///
/// Tracks only a single variable, [progress], and calls [onWin] when
/// the value of [progress] reaches [goal].
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

  void evaluate() {
    if (_progress == goal) {
      onWin(_steps);
    }
  }
}
