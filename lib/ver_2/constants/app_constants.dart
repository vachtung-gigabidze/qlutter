// constants/app_constants.dart
import 'package:flutter/material.dart';

class AppConstants {
  // Тексты
  static const String appName = 'QOOX';
  static const String appDescription = 'Закати все шары в лунки';
  static const String ballCountText = 'Шары: ';
  static const String levelText = 'Уровень ';
  static const String victoryTitle = 'Уровень пройден!';
  static const String victoryMessage =
      'Все шары закатаны! Следующий уровень через 3 секунды...';
  static const String howToPlayTitle = 'Как играть';
  static const String settingsTitle = 'Настройки';
  static const String resetProgress = 'Сбросить прогресс';
  static const String resetConfirm =
      'Вы уверены, что хотите сбросить прогресс?';
  static const String resetSuccess = 'Прогресс успешно сброшен!';

  static const String stepsText = 'Шаги: ';
  static const String timeText = 'Время: ';
  static const String ballsText = 'Шары: ';
  static const String statsTitle = 'Статистика уровня';
  // Навигация по уровням
  static const String previousLevelTooltip = 'Предыдущий уровень';
  static const String nextLevelTooltip = 'Следующий уровень';
  static const String levelLockedTooltip = 'Уровень заблокирован';
  static const String completeCurrentLevel = 'Сначала пройдите текущий уровень';

  // Система отмены
  static const String undoAllTooltip = 'Отменить все ходы';
  static const String redoTooltip = 'Вернуть ход';
  static const String undoTooltip = 'Отменить ход';
  static const String resetLevelTooltip = 'Сбросить уровень';

  // Цвета
  static const primaryColor = Color(0xFF50427D);
  static const secondaryColor = Color(0xFF4CAF50);
  static const backgroundColor = Color(0xffF8F4FF);
  static const surfaceColor = Color(0xffF8F4FF);
  static const errorColor = Color(0xFFF44336);
  static const successColor = Color(0xFF4CAF50);
  static const warningColor = Color(0xFFFF9800);
  static const infoColor = Color(0xFF2196F3);

  // Цвета элементов игры
  static const ballGreen = Color(0xFF4CAF50);
  static const ballRed = Color(0xFFF44336);
  static const ballBlue = Color(0xFF2196F3);
  static const ballYellow = Color(0xFFFFEB3B);
  static const ballPurple = Color(0xFF9C27B0);
  static const ballCyan = Color(0xFF00BCD4);
  static const blockGray = Color(0xFF607D8B);

  // Цвета для статистики
  static const statsBackgroundColor = Color(0xffF8F4FF);
  static const statsBorderColor = Color(0xffF8F4FF);

  // Размеры
  static const double defaultPadding = 8;
  static const double smallPadding = 8;
  static const double elementMinSizeMobile = 28;
  static const double elementMaxSizeMobile = 55;
  static const double elementMinSizeTablet = 35;
  static const double elementMaxSizeTablet = 70;
  static const double elementMinSizeDesktop = 40;
  static const double elementMaxSizeDesktop = 80;
  static const double statusBarHeight = 60;
  static const double iconSize = 24;

  // Время
  static const victoryDelaySeconds = 3;
  static const animationDuration = Duration(milliseconds: 300);

  // Прочее
  static const swipeSensitivity = 0.8;
  static const elementPaddingRatio = 0.04;
  static const elementBorderRadius = 0.15;

  // Размеры и отступы для навигации
  static const double navButtonSize = 48;
  static const double navIconSize = 32;

  // Максимальная глубина истории
  static const int maxHistorySize = 50;

  // Статистика шаров
  static const String ballsProgressText = 'Шары';
  static const double ballIconSize = 20;
  static const double ballIconSpacing = 4;

  // Анимации
  static const Duration ballMoveDuration = Duration(milliseconds: 300);
  static const Curve ballMoveCurve = Curves.easeOut;
  static const Duration ballCaptureDuration = Duration(milliseconds: 200);
  static const Curve ballCaptureCurve = Curves.easeIn;
}
