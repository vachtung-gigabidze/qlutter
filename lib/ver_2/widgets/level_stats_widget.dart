import 'package:flutter/material.dart';
import 'package:qlutter/ver_2/constants/app_constants.dart';
import 'package:qlutter/ver_2/models/item.dart';
import 'package:qlutter/ver_2/models/level_stats.dart';

class LevelStatsWidget extends StatelessWidget {
  const LevelStatsWidget({
    required this.stats,
    required this.initialBallsCount,
    required this.currentBallsCount,
    super.key,
  });
  final LevelStats stats;
  final int initialBallsCount;
  final int currentBallsCount;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(AppConstants.smallPadding),
    decoration: BoxDecoration(
      color: AppConstants.statsBackgroundColor,
      border: Border.all(color: AppConstants.statsBorderColor),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Основная статистика
        _buildMainStats(),
        const SizedBox(height: 8),
        // Визуальная статистика шаров
        _buildBallsVisualStats(),
      ],
    ),
  );

  Widget _buildMainStats() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      _buildStatItem(
        Icons.directions_walk,
        '${AppConstants.stepsText}${stats.steps}',
      ),
      _buildStatItem(
        Icons.timer,
        '${AppConstants.timeText}${stats.formattedTime}',
      ),
      _buildStatItem(
        Icons.sports_baseball,
        '${stats.totalBallsCaptured}/$initialBallsCount',
      ),
    ],
  );

  Widget _buildStatItem(IconData icon, String text) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, size: 16, color: AppConstants.primaryColor),
      const SizedBox(width: 4),
      Text(
        text,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      ),
    ],
  );

  Widget _buildBallsVisualStats() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Заголовок
      const Row(
        children: [
          Icon(
            Icons.sports_baseball,
            size: 16,
            color: AppConstants.primaryColor,
          ),
          SizedBox(width: 4),
          Text(
            AppConstants.ballsProgressText,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
      const SizedBox(height: 6),

      // Визуальное отображение шаров
      _buildBallsIcons(),

      // Текстовый прогресс
      const SizedBox(height: 4),
      Text(
        '${stats.totalBallsCaptured}/$initialBallsCount',
        style: const TextStyle(fontSize: 11, color: Colors.grey),
      ),
    ],
  );

  Widget _buildBallsIcons() {
    // Создаем список всех шаров на уровне
    final ballColors = <ItemColor?>[];

    // Сначала добавляем закатанные шары
    for (final entry in stats.ballsCaptured.entries) {
      for (var i = 0; i < entry.value; i++) {
        ballColors.add(entry.key);
      }
    }

    // Затем добавляем незакатанные шары (серые)
    final remainingBalls = initialBallsCount - stats.totalBallsCaptured;
    for (var i = 0; i < remainingBalls; i++) {
      ballColors.add(null); // null означает незакатанный шар
    }

    return Wrap(
      spacing: AppConstants.ballIconSpacing,
      runSpacing: AppConstants.ballIconSpacing,
      children: ballColors.map(_buildBallIcon).toList(),
    );
  }

  Widget _buildBallIcon(ItemColor? color) => Container(
    width: AppConstants.ballIconSize,
    height: AppConstants.ballIconSize,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: _getBallColor(color),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 2,
          offset: const Offset(1, 1),
        ),
      ],
    ),
    child: color != null ? _buildColoredBallContent() : _buildGrayBallContent(),
  );

  Widget _buildColoredBallContent() => Container(
    margin: const EdgeInsets.all(3),
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      gradient: RadialGradient(
        center: Alignment.center,
        radius: 0.7,
        colors: [Colors.white, Colors.transparent],
        stops: [0.3, 1.0],
      ),
    ),
  );

  Widget _buildGrayBallContent() => Container(
    margin: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.grey.shade400,
    ),
  );

  Color _getBallColor(ItemColor? color) {
    if (color == null) {
      return Colors.grey.shade300; // Незакатанный шар
    }

    switch (color) {
      case ItemColor.green:
        return AppConstants.ballGreen;
      case ItemColor.red:
        return AppConstants.ballRed;
      case ItemColor.blue:
        return AppConstants.ballBlue;
      case ItemColor.yellow:
        return AppConstants.ballYellow;
      case ItemColor.purple:
        return AppConstants.ballPurple;
      case ItemColor.cyan:
        return AppConstants.ballCyan;
      case ItemColor.gray:
        return AppConstants.blockGray;
    }
  }
}
