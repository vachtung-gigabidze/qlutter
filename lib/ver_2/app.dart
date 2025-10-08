// main.dart
import 'package:flutter/material.dart';
import 'package:qlutter/ver_2/game/level_manager.dart';

// Импортируем все наши классы
// import 'package:qlutter/ver_2/models/item.dart';
// import 'package:qlutter/ver_2/models/coordinates.dart';
// import 'package:qlutter/ver_2/models/level.dart';
// import 'package:qlutter/ver_2/game/field_engine.dart';
import 'package:qlutter/ver_2/screens/game_screen.dart';
import 'package:qlutter/ver_2/screens/level_select_screen.dart';
import 'package:qlutter/ver_2/services/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:qlutter/ver_2/widgets/field_widget.dart';

class QookApp extends StatelessWidget {
  const QookApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Qook',
    theme: _buildTheme(),
    darkTheme: _buildDarkTheme(),
    themeMode: ThemeMode.system,
    home: const SplashScreen(),
    routes: {
      '/level_select': (context) => const LevelSelectScreen(),
      '/game': (context) => const GameScreen(levelNumber: 1),
    },
    debugShowCheckedModeBanner: false,
  );

  ThemeData _buildTheme() => ThemeData(
    primarySwatch: Colors.blue,
    primaryColor: Colors.blue.shade800,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
    ),
    useMaterial3: true,
    fontFamily: 'Roboto',
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 2,
      shadowColor: Colors.black26,
    ),
    cardTheme: CardThemeData(
      elevation: 4,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );

  ThemeData _buildDarkTheme() => ThemeData(
    primarySwatch: Colors.blue,
    primaryColor: Colors.blue.shade300,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
    fontFamily: 'Roboto',
    appBarTheme: const AppBarTheme(centerTitle: true, elevation: 2),
    cardTheme: CardThemeData(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _controller.forward();

    // Загружаем начальные данные и переходим к главному экрану
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Имитация загрузки начальных данных
    await Future.delayed(const Duration(milliseconds: 2000));

    // Переходим к выбору уровней
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainMenuScreen()),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Theme.of(context).colorScheme.primary,
    body: Center(
      child: ScaleTransition(
        scale: _animation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Логотип игры
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.sports_baseball,
                size: 60,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 30),
            // Название игры
            Text(
              'QOOK',
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 4,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Логическая игра',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
            const SizedBox(height: 50),
            // Индикатор загрузки
            SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.white.withOpacity(0.8),
                ),
                strokeWidth: 3,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  int _currentLevel = 1;
  int _maxLevel = 1;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final currentLevel = await StorageService.getCurrentLevel();
    final maxLevel = await StorageService.getMaxLevel();

    setState(() {
      _currentLevel = currentLevel;
      _maxLevel = maxLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.shortestSide < 600;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primary.withOpacity(0.8),
              Theme.of(context).colorScheme.surface,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Заголовок
                _buildHeader(isSmallScreen),

                const Spacer(),

                // Основные кнопки меню
                _buildMenuButtons(isSmallScreen),

                const Spacer(flex: 2),

                // Прогресс
                _buildProgressSection(),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isSmallScreen) => Column(
    children: [
      Container(
        width: isSmallScreen ? 80 : 100,
        height: isSmallScreen ? 80 : 100,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(
          Icons.sports_baseball,
          size: isSmallScreen ? 40 : 50,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      const SizedBox(height: 20),
      Text(
        'QOOK',
        style: TextStyle(
          fontSize: isSmallScreen ? 36 : 48,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 3,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        'Закати все шары в лунки',
        style: TextStyle(
          fontSize: isSmallScreen ? 14 : 16,
          color: Colors.white.withOpacity(0.9),
        ),
        textAlign: TextAlign.center,
      ),
    ],
  );

  Widget _buildMenuButtons(bool isSmallScreen) {
    final buttonStyle = ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 20 : 30,
        vertical: isSmallScreen ? 15 : 20,
      ),
      textStyle: TextStyle(
        fontSize: isSmallScreen ? 16 : 18,
        fontWeight: FontWeight.w600,
      ),
    );

    return Column(
      children: [
        // Кнопка продолжения
        if (_currentLevel > 1) ...[
          ElevatedButton.icon(
            style: buttonStyle.copyWith(
              backgroundColor: WidgetStateProperty.all(Colors.green),
            ),
            onPressed: () => _startGame(_currentLevel),
            icon: const Icon(Icons.play_arrow),
            label: const Text('ПРОДОЛЖИТЬ ИГРУ'),
          ),
          const SizedBox(height: 16),
        ],

        // Кнопка новой игры
        ElevatedButton.icon(
          style: buttonStyle,
          onPressed: _openLevelSelect,
          icon: const Icon(Icons.games),
          label: const Text('ВЫБОР УРОВНЯ'),
        ),
        const SizedBox(height: 16),

        // Кнопка правил
        ElevatedButton.icon(
          style: buttonStyle.copyWith(
            backgroundColor: WidgetStateProperty.all(Colors.orange),
          ),
          onPressed: _showHowToPlay,
          icon: const Icon(Icons.help_outline),
          label: const Text('КАК ИГРАТЬ'),
        ),
        const SizedBox(height: 16),

        // Кнопка настроек
        ElevatedButton.icon(
          style: buttonStyle.copyWith(
            backgroundColor: WidgetStateProperty.all(Colors.grey),
          ),
          onPressed: _showSettings,
          icon: const Icon(Icons.settings),
          label: const Text('НАСТРОЙКИ'),
        ),
      ],
    );
  }

  Widget _buildProgressSection() => Card(
    elevation: 4,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            'ВАШ ПРОГРЕСС',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: _maxLevel / LevelManager().totalLevels,
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Уровень $_maxLevel из ${LevelManager().totalLevels}',
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    ),
  );

  void _startGame(int levelNumber) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => GameScreen(levelNumber: levelNumber),
      ),
    );
  }

  void _openLevelSelect() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const LevelSelectScreen()));
  }

  void _showHowToPlay() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Как играть в Qook'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildInstructionStep(
                '1',
                'Цель игры',
                'Закатите все цветные шары в лунки соответствующего цвета.',
              ),
              _buildInstructionStep(
                '2',
                'Движение шаров',
                'Шары движутся по прямой до первого препятствия (блока или другого шара).',
              ),
              _buildInstructionStep(
                '3',
                'Управление',
                'Свайпайте в нужном направлении или используйте кнопки на десктопе.',
              ),
              _buildInstructionStep(
                '4',
                'Стратегия',
                'Планируйте ходы заранее - некоторые шары могут блокировать путь другим.',
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '💡 Подсказка: Используйте кнопку "Отмена", чтобы вернуться на ход назад!',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('ПОНЯТНО'),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionStep(
    String number,
    String title,
    String description,
  ) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              Text(description, style: const TextStyle(fontSize: 13)),
            ],
          ),
        ),
      ],
    ),
  );

  void _showSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Настройки'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Здесь будут настройки игры...'),
            SizedBox(height: 16),
            Text('• Звуки и музыка'),
            Text('• Виброотклик'),
            Text('• Сложность'),
            Text('• Сброс прогресса'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('ЗАКРЫТЬ'),
          ),
          TextButton(
            onPressed: _resetProgress,
            child: const Text(
              'СБРОСИТЬ ПРОГРЕСС',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _resetProgress() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Сброс прогресса'),
        content: const Text(
          'Вы уверены, что хотите сбросить весь прогресс? Это действие нельзя отменить.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('ОТМЕНА'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop(); // Закрываем диалог подтверждения
              Navigator.of(context).pop(); // Закрываем диалог настроек

              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();

              setState(() {
                _currentLevel = 1;
                _maxLevel = 1;
              });

              // Показываем сообщение об успехе
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Прогресс успешно сброшен!'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            child: const Text('СБРОСИТЬ', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
