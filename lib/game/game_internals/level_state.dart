import 'package:flutter/foundation.dart';

/// An extremely silly example of a game state.
///
/// Tracks only a single variable, [progress], and calls [onWin] when
/// the value of [progress] reaches [goal].
class LevelState extends ChangeNotifier {
  final VoidCallback onWin;

  final bool goal;

  LevelState({required this.onWin, this.goal = false});

  bool _progress = false;

  bool get progress => _progress;

  void setProgress(bool value) {
    _progress = value;
    notifyListeners();
  }

  void evaluate() {
    //if (_progress != goal) {
    onWin();
    // }
  }
}
