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
        // Прогресс по шарам
        _buildBallsProgress(),
        const SizedBox(height: 8),
        // Детали по цветам шаров
        _buildBallsDetails(),
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
        '${AppConstants.ballsText}${stats.totalBallsCaptured}/$initialBallsCount',
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

  Widget _buildBallsProgress() {
    final progress = initialBallsCount > 0
        ? stats.totalBallsCaptured / initialBallsCount
        : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Прогресс: ${stats.totalBallsCaptured}/$initialBallsCount',
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey.shade300,
          valueColor: AlwaysStoppedAnimation<Color>(
            progress == 1.0
                ? AppConstants.successColor
                : AppConstants.primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildBallsDetails() {
    final capturedBalls = stats.ballsCaptured.entries
        .where((e) => e.value > 0)
        .toList();

    if (capturedBalls.isEmpty) {
      return const Text(
        'Шары еще не закатаны',
        style: TextStyle(fontSize: 11, color: Colors.grey),
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: capturedBalls
          .map((entry) => _buildBallColorItem(entry.key, entry.value))
          .toList(),
    );
  }

  Widget _buildBallColorItem(ItemColor color, int count) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: _getColorForItemColor(color),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black.withOpacity(0.3)),
        ),
      ),
      const SizedBox(width: 4),
      Text(
        '$count',
        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
      ),
    ],
  );

  Color _getColorForItemColor(ItemColor color) {
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
