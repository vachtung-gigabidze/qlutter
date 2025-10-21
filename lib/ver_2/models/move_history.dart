// models/move_history.dart
import 'package:qlutter/ver_2/models/level.dart';
import 'package:qlutter/ver_2/models/level_stats.dart';

class MoveHistory {
  // Описание хода для отладки

  const MoveHistory({
    required this.levelState,
    required this.ballsCount,
    required this.stats,
    this.description,
  });
  final Level levelState;
  final int ballsCount;
  final LevelStats stats;
  final String? description;

  MoveHistory copyWith({
    Level? levelState,
    int? ballsCount,
    LevelStats? stats,
    String? description,
  }) => MoveHistory(
    levelState: levelState ?? this.levelState,
    ballsCount: ballsCount ?? this.ballsCount,
    stats: stats ?? this.stats,
    description: description ?? this.description,
  );
}
