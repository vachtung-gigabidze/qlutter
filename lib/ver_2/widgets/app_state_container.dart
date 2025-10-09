// widgets/app_state_container.dart
import 'package:flutter/material.dart';
import 'package:qlutter/ver_2/models/app_state.dart';

class AppStateContainer extends StatefulWidget {
  const AppStateContainer({
    required this.child,
    required this.initialState,
    super.key,
  });
  final Widget child;
  final AppState initialState;

  @override
  State<AppStateContainer> createState() => AppStateContainerState();

  static AppStateContainerState of(BuildContext context) =>
      context.findAncestorStateOfType<AppStateContainerState>()!;
}

class AppStateContainerState extends State<AppStateContainer> {
  late AppState _state;

  @override
  void initState() {
    super.initState();
    _state = widget.initialState;
  }

  void update(AppState newState) {
    setState(() {
      _state = newState;
    });
  }

  void updateCurrentLevel(int level) {
    setState(() {
      _state = _state.copyWith(currentLevel: level);
    });
  }

  void markLevelCompleted(int level) {
    final newCompletedLevels = Set<int>.from(_state.completedLevels)
      ..add(level);
    setState(() {
      _state = _state.copyWith(completedLevels: newCompletedLevels);
    });
  }

  void setLoading(bool loading) {
    setState(() {
      _state = _state.copyWith(isLoading: loading);
    });
  }

  void setError(String? error) {
    setState(() {
      _state = _state.copyWith(error: error);
    });
  }

  void resetProgress() {
    setState(() {
      _state = _state.copyWith(
        currentLevel: 1,
        completedLevels: {},
        error: null,
      );
    });
  }

  @override
  Widget build(BuildContext context) => InheritedAppState(
    state: _state,
    containerState: this,
    child: widget.child,
  );
}

class InheritedAppState extends InheritedWidget {
  const InheritedAppState({
    required this.state,
    required this.containerState,
    required super.child,
    super.key,
  });
  final AppState state;
  final AppStateContainerState containerState;

  @override
  bool updateShouldNotify(InheritedAppState oldWidget) =>
      oldWidget.state != state;
}
