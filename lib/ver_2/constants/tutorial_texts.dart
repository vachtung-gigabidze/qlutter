// constants/tutorial_texts.dart
class TutorialTexts {
  static const String title = 'Как играть в Qook';

  static const List<Map<String, String>> instructions = [
    {
      'number': '1',
      'title': 'Цель игры',
      'description':
          'Закатите все цветные шары в лунки соответствующего цвета.',
    },
    {
      'number': '2',
      'title': 'Движение шаров',
      'description':
          'Шары движутся по прямой до первого препятствия (блока или другого шара).',
    },
    {
      'number': '3',
      'title': 'Управление',
      'description':
          'Свайпайте в нужном направлении или используйте кнопки на десктопе.',
    },
    {
      'number': '4',
      'title': 'Стратегия',
      'description':
          'Планируйте ходы заранее - некоторые шары могут блокировать путь другим.',
    },
  ];

  static const String tip =
      '💡 Подсказка: Используйте кнопку "Отмена", чтобы вернуться на ход назад!';
}
