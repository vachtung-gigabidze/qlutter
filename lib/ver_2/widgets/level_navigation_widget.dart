// widgets/level_navigation_widget.dart
import 'package:flutter/material.dart';
import 'package:qlutter/ver_2/constants/app_constants.dart';

class LevelNavigationWidget extends StatelessWidget {
  const LevelNavigationWidget({
    required this.currentLevel,
    required this.totalLevels,
    required this.onPreviousLevel,
    required this.onNextLevel,
    required this.isNextLevelUnlocked,
    required this.fieldGame,
    super.key,
  });
  final int currentLevel;
  final int totalLevels;
  final VoidCallback onPreviousLevel;
  final VoidCallback onNextLevel;
  final bool isNextLevelUnlocked;
  final Widget fieldGame;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      // Кнопка предыдущего уровня
      _buildNavButton(
        icon: Icons.arrow_back_ios,
        isEnabled: currentLevel > 1,
        tooltip: AppConstants.previousLevelTooltip,
        onPressed: onPreviousLevel,
      ),

      SizedBox(
        height: MediaQuery.of(context).size.height - 100,
        width: MediaQuery.of(context).size.width - 130,
        child: fieldGame,
      ),
      // Expanded(child: fieldGame),
      // Информация о текущем уровне
      //_buildLevelInfo(),

      // Кнопка следующего уровня
      _buildNavButton(
        icon: isNextLevelUnlocked ? Icons.arrow_forward_ios : Icons.lock,
        isEnabled: true, //isNextLevelUnlocked && currentLevel < totalLevels,
        tooltip: isNextLevelUnlocked
            ? AppConstants.nextLevelTooltip
            : AppConstants.levelLockedTooltip,
        onPressed: onNextLevel,
      ),
    ],
  );

  Widget _buildNavButton({
    required IconData icon,
    required bool isEnabled,
    required String tooltip,
    required VoidCallback onPressed,
  }) => SizedBox(
    width: AppConstants.navButtonSize,
    height: AppConstants.navButtonSize,
    child: IconButton(
      icon: Icon(
        icon,
        size: AppConstants.navIconSize,
        color: isEnabled ? AppConstants.primaryColor : Colors.grey.shade400,
      ),
      onPressed: isEnabled ? onPressed : null,
      tooltip: tooltip,
      style: IconButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: isEnabled
            ? const Color.fromARGB(255, 237, 239, 241).withOpacity(0.1)
            : Colors.grey.shade100,
      ),
    ),
  );

  Widget _buildLevelInfo() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: AppConstants.primaryColor.withOpacity(0.1),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      '$currentLevel/$totalLevels',
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppConstants.primaryColor,
      ),
    ),
  );
}
