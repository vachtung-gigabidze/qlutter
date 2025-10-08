// screens/level_select_screen.dart
import 'package:flutter/material.dart';
import 'package:qlutter/ver_2/screens/game_screen.dart';

class LevelSelectScreen extends StatelessWidget {
  const LevelSelectScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Qook')),
    body: GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: 50, // Всего уровней
      itemBuilder: (context, index) {
        final levelNumber = index + 1;
        final isUnlocked = levelNumber <= 20; // Пример логики разблокировки

        return LevelButton(
          levelNumber: levelNumber,
          isUnlocked: isUnlocked,
          onPressed: isUnlocked ? () => _openLevel(context, levelNumber) : null,
        );
      },
    ),
  );

  void _openLevel(BuildContext context, int levelNumber) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameScreen(levelNumber: levelNumber),
      ),
    );
  }
}

class LevelButton extends StatelessWidget {
  const LevelButton({
    super.key,
    required this.levelNumber,
    required this.isUnlocked,
    this.onPressed,
  });
  final int levelNumber;
  final bool isUnlocked;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => AspectRatio(
    aspectRatio: 1,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isUnlocked ? Colors.blue : Colors.grey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        '$levelNumber',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
