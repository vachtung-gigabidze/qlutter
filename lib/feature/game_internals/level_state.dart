import 'package:flutter/foundation.dart';

/// An extremely silly example of a game state.
///
/// Tracks only a single variable, [progress], and calls [onWin] when
/// the value of [progress] reaches [goal].
class LevelState extends ChangeNotifier {
  final VoidCallback onWin;

  final int goal;

  LevelState({required this.onWin, this.goal = 0});

  int _progress = 0;
  int steps = 0;

  int get progress => progress;

  void setProgress(int value) {
    _progress = value;
    steps++;
    notifyListeners();
  }

  void evaluate() {
    if (_progress == goal) {
      onWin();
    }
  }
}
