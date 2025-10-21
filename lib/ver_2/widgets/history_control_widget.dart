// widgets/history_control_widget.dart
import 'package:flutter/material.dart';
import 'package:qlutter/ver_2/constants/app_constants.dart';

class HistoryControlWidget extends StatelessWidget {
  const HistoryControlWidget({
    required this.canUndo,
    required this.canRedo,
    required this.canReset,
    required this.historySize,
    required this.onUndo,
    required this.onRedo,
    required this.onReset,
    super.key,
  });
  final bool canUndo;
  final bool canRedo;
  final bool canReset;
  final int historySize;
  final VoidCallback onUndo;
  final VoidCallback onRedo;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: AppConstants.statsBackgroundColor,
      border: Border.all(color: AppConstants.statsBorderColor),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // Кнопка сброса к началу
        _buildControlButton(
          icon: Icons.restart_alt,
          isEnabled: canReset,
          tooltip: AppConstants.resetLevelTooltip,
          onPressed: onReset,
        ),

        // Кнопка отмены
        _buildControlButton(
          icon: Icons.undo,
          isEnabled: canUndo,
          tooltip: AppConstants.undoTooltip,
          onPressed: onUndo,
        ),

        // Индикатор истории
        _buildHistoryIndicator(),

        // Кнопка возврата
        _buildControlButton(
          icon: Icons.redo,
          isEnabled: canRedo,
          tooltip: AppConstants.redoTooltip,
          onPressed: onRedo,
        ),

        // Кнопка отмены всех ходов
        _buildControlButton(
          icon: Icons.clear_all,
          isEnabled: canReset,
          tooltip: AppConstants.undoAllTooltip,
          onPressed: onReset,
        ),
      ],
    ),
  );

  Widget _buildControlButton({
    required IconData icon,
    required bool isEnabled,
    required String tooltip,
    required VoidCallback onPressed,
  }) => IconButton(
    icon: Icon(
      icon,
      color: isEnabled ? AppConstants.primaryColor : Colors.grey.shade400,
      size: 20,
    ),
    onPressed: isEnabled ? onPressed : null,
    tooltip: tooltip,
    style: IconButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: isEnabled
          ? AppConstants.primaryColor.withOpacity(0.1)
          : Colors.grey.shade100,
    ),
  );

  Widget _buildHistoryIndicator() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    decoration: BoxDecoration(
      color: AppConstants.primaryColor.withOpacity(0.1),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Text(
      '$historySize',
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: AppConstants.primaryColor,
      ),
    ),
  );
}
