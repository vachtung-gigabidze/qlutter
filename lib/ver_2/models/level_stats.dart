import 'package:qlutter/ver_2/models/item.dart';

class LevelStats {
  LevelStats({
    required this.steps,
    required this.time,
    required this.ballsCaptured,
    required this.levelStartTime,
  });

  factory LevelStats.start() => LevelStats(
    steps: 0,
    time: Duration.zero,
    ballsCaptured: {
      ItemColor.green: 0,
      ItemColor.red: 0,
      ItemColor.blue: 0,
      ItemColor.yellow: 0,
      ItemColor.purple: 0,
      ItemColor.cyan: 0,
    },
    levelStartTime: DateTime.now(),
  );
  final int steps;
  final Duration time;
  final Map<ItemColor, int> ballsCaptured; // Захваченные шары по цветам
  final DateTime levelStartTime;

  LevelStats copyWith({
    int? steps,
    Duration? time,
    Map<ItemColor, int>? ballsCaptured,
  }) => LevelStats(
    steps: steps ?? this.steps,
    time: time ?? this.time,
    ballsCaptured: ballsCaptured ?? Map.from(this.ballsCaptured),
    levelStartTime: levelStartTime,
  );

  // Форматирование времени в читаемый вид
  String get formattedTime {
    final minutes = time.inMinutes;
    final seconds = time.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  // Общее количество захваченных шаров
  int get totalBallsCaptured =>
      ballsCaptured.values.fold(0, (sum, count) => sum + count);
}
