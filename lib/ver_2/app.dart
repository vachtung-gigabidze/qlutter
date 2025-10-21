// main.dart
import 'package:flutter/material.dart';
// import 'package:qlutter/ver_2/game/level_manager.dart';
import 'package:qlutter/ver_2/constants/app_constants.dart';
import 'package:qlutter/ver_2/constants/tutorial_texts.dart';
import 'package:qlutter/ver_2/models/app_state.dart';
import 'package:qlutter/ver_2/models/level.dart';
import 'package:qlutter/ver_2/providers/app_state_provider.dart';

// Импортируем все наши классы
// import 'package:qlutter/ver_2/models/item.dart';
// import 'package:qlutter/ver_2/models/coordinates.dart';
// import 'package:qlutter/ver_2/models/level.dart';
// import 'package:qlutter/ver_2/game/field_engine.dart';
import 'package:qlutter/ver_2/services/storage_service.dart';
import 'package:qlutter/ver_2/widgets/app_state_container.dart';
import 'package:qlutter/ver_2/widgets/field_widget.dart';
import 'package:qlutter/ver_2/widgets/level_navigation_widget.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:qlutter/ver_2/widgets/field_widget.dart';

// main.dart
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class QOOXApp extends StatelessWidget {
  const QOOXApp({required this.initialState, super.key});
  final AppState initialState;

  @override
  Widget build(BuildContext context) => AppStateContainer(
    initialState: initialState,
    child: MaterialApp(
      title: AppConstants.appName,
      theme: _buildTheme(),
      darkTheme: _buildDarkTheme(),
      themeMode: ThemeMode.system,
      home: const GameWrapper(),
      debugShowCheckedModeBanner: false,
    ),
  );

  ThemeData _buildTheme() => ThemeData(
    primaryColor: AppConstants.primaryColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppConstants.primaryColor,
      brightness: Brightness.light,
    ),
    useMaterial3: true,
    fontFamily: 'Roboto',
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 2,
      backgroundColor: AppConstants.surfaceColor,
    ),
  );

  ThemeData _buildDarkTheme() => ThemeData(
    primaryColor: AppConstants.primaryColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppConstants.primaryColor,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
    fontFamily: 'Roboto',
    appBarTheme: const AppBarTheme(centerTitle: true, elevation: 2),
  );
}

class GameWrapper extends StatefulWidget {
  const GameWrapper({super.key});

  @override
  State<GameWrapper> createState() => _GameWrapperState();
}

class _GameWrapperState extends State<GameWrapper> {
  Future<Level>? _levelFuture;
  late int _currentLevel;
  late Set<int> _completedLevels;
  late int _totalLevels;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    // Получаем начальные данные асинхронно
    final currentLevel = await StorageService.getCurrentLevel();
    final completedLevels = await StorageService.getCompletedLevels();

    setState(() {
      _currentLevel = currentLevel;
      _completedLevels = completedLevels;
      _isInitialized = true;
    });

    _loadCurrentLevel();
  }

  void _loadCurrentLevel() {
    if (!_isInitialized) return;

    final levelManager = AppStateProvider.of(context).levelManager;

    setState(() {
      _levelFuture = levelManager.loadLevel(_currentLevel);
    });
  }

  Future<void> _onLevelComplete() async {
    // Сохраняем в хранилище
    await StorageService.markLevelCompleted(_currentLevel);

    final nextLevel = _currentLevel + 1;
    await StorageService.setCurrentLevel(nextLevel);

    // Обновляем состояние приложения
    AppStateProvider.markLevelCompleted(context, _currentLevel);
    AppStateProvider.updateCurrentLevel(context, nextLevel);

    // Обновляем локальное состояние
    setState(() {
      _completedLevels.add(_currentLevel);
      _currentLevel = nextLevel;
    });

    // Показываем сообщение о победе
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppConstants.victoryMessage),
          backgroundColor: AppConstants.successColor,
          duration: Duration(seconds: AppConstants.victoryDelaySeconds),
        ),
      );

      // Через 3 секунды переходим на следующий уровень
      Future.delayed(
        const Duration(seconds: AppConstants.victoryDelaySeconds),
        () {
          if (mounted) {
            _loadCurrentLevel();
          }
        },
      );
    }
  }

  void _goToPreviousLevel() {
    if (_currentLevel > 1) {
      setState(() {
        _currentLevel--;
      });
      _loadCurrentLevel();
    }
  }

  Future<void> _goToNextLevel() async {
    final nextLevel = _currentLevel + 1;

    // Проверяем доступен ли следующий уровень
    final isUnlocked = _isLevelUnlocked(nextLevel);
    final levelExists = nextLevel <= AppStateProvider.getTotalLevels(context);

    if (isUnlocked && levelExists) {
      setState(() {
        _currentLevel = nextLevel;
      });
      await StorageService.setCurrentLevel(nextLevel);
      _loadCurrentLevel();
    } else if (!levelExists) {
      _showLastLevelMessage();
    } else {
      _showLevelLockedMessage();
    }
  }

  bool _isLevelUnlocked(int level) =>
      level == 1 || _completedLevels.contains(level - 1);

  void _showLevelLockedMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(AppConstants.completeCurrentLevel),
        backgroundColor: AppConstants.warningColor,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showLastLevelMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Это последний уровень!'),
        backgroundColor: AppConstants.infoColor,
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> _resetProgress() async {
    await StorageService.clearProgress();
    AppStateProvider.resetProgress(context);

    setState(() {
      _currentLevel = 1;
      _completedLevels.clear();
    });

    _loadCurrentLevel();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppConstants.resetSuccess),
          backgroundColor: AppConstants.successColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return _buildLoadingScreen();
    }

    final appState = AppStateProvider.of(context);

    if (appState.isLoading) {
      return _buildLoadingScreen();
    }

    if (appState.error != null) {
      return _buildErrorScreen(appState.error!);
    }

    return FutureBuilder<Level>(
      future: _levelFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingScreen();
        }

        if (snapshot.hasError) {
          return _buildErrorScreen(snapshot.error.toString());
        }

        final level = snapshot.data!;
        return GameScreen(
          level: level,
          levelNumber: _currentLevel,
          totalLevels: appState.totalLevels,
          onLevelComplete: _onLevelComplete,
          onResetProgress: _resetProgress,
          onPreviousLevel: _goToPreviousLevel,
          onNextLevel: _goToNextLevel,
        );
      },
    );
  }

  Widget _buildLoadingScreen() => Scaffold(
    backgroundColor: AppConstants.primaryColor,
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          Text(
            _isInitialized ? 'Загрузка уровня...' : 'Инициализация...',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    ),
  );

  Widget _buildErrorScreen(String error) => Scaffold(
    appBar: AppBar(title: const Text('Ошибка')),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: AppConstants.errorColor,
            ),
            const SizedBox(height: AppConstants.defaultPadding),
            const Text(
              'Ошибка загрузки уровня',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppConstants.smallPadding),
            Text(
              error,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: AppConstants.defaultPadding),
            ElevatedButton(
              onPressed: _loadCurrentLevel,
              child: const Text('Попробовать снова'),
            ),
          ],
        ),
      ),
    ),
  );
}

class GameScreen extends StatefulWidget {
  const GameScreen({
    required this.level,
    required this.levelNumber,
    required this.totalLevels,
    required this.onLevelComplete,
    required this.onResetProgress,
    required this.onPreviousLevel,
    required this.onNextLevel,
    super.key,
  });
  final Level level;
  final int levelNumber;
  final int totalLevels;
  final VoidCallback onLevelComplete;
  final VoidCallback onResetProgress;
  final VoidCallback onPreviousLevel;
  final VoidCallback onNextLevel;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool _isNextLevelUnlocked = false;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    // Откладываем проверку до следующего кадра
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkNextLevelUnlock();
      setState(() {
        _isInitialized = true;
      });
    });
  }

  void _checkNextLevelUnlock() {
    final isUnlocked = AppStateProvider.isLevelUnlocked(
      context,
      widget.levelNumber + 1,
    );
    setState(() {
      _isNextLevelUnlocked = isUnlocked;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Перепроверяем разблокировку при изменении зависимостей
    _checkNextLevelUnlock();
  }

  Widget wrap_level_navigation(Widget child) => LevelNavigationWidget(
    currentLevel: widget.levelNumber,
    totalLevels: widget.totalLevels,
    onPreviousLevel: widget.onPreviousLevel,
    onNextLevel: widget.onNextLevel,
    isNextLevelUnlocked: _isNextLevelUnlocked,
    // Игровое поле
    fieldGame: child,
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppConstants.surfaceColor,
    // appBar: AppBar(
    //   title: Text('${AppConstants.levelText}${widget.levelNumber}'),
    //   centerTitle: true,
    //   actions: [
    //     IconButton(
    //       icon: const Icon(Icons.help_outline),
    //       onPressed: _showHowToPlay,
    //       tooltip: AppConstants.howToPlayTitle,
    //     ),
    //     IconButton(
    //       icon: const Icon(Icons.settings),
    //       onPressed: _showSettings,
    //       tooltip: AppConstants.settingsTitle,
    //     ),
    //   ],
    // ),
    body: Column(
      children: [
        // Навигация по уровням (показываем только после инициализации)
        if (_isInitialized)
          // Padding(
          //   padding: const EdgeInsets.all(AppConstants.defaultPadding),
          //   child: LevelNavigationWidget(
          //     currentLevel: widget.levelNumber,
          //     totalLevels: widget.totalLevels,
          //     onPreviousLevel: widget.onPreviousLevel,
          //     onNextLevel: widget.onNextLevel,
          //     isNextLevelUnlocked: _isNextLevelUnlocked,
          //     // Игровое поле
          //     fieldGame:
          //   ),
          // )
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: FieldWidget(
              level: widget.level,
              levelNumber: widget.levelNumber,
              onLevelComplete: widget.onLevelComplete,
              wrap_level_navigation: wrap_level_navigation,
            ),
          )
        else
          const SizedBox(height: AppConstants.defaultPadding),
      ],
    ),
  );
  void _showHowToPlay() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(TutorialTexts.title),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final instruction in TutorialTexts.instructions)
                _buildInstructionStep(
                  instruction['number']!,
                  instruction['title']!,
                  instruction['description']!,
                ),
              const SizedBox(height: AppConstants.defaultPadding),
              Container(
                padding: const EdgeInsets.all(AppConstants.smallPadding),
                decoration: BoxDecoration(
                  color: AppConstants.infoColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  TutorialTexts.tip,
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
    padding: const EdgeInsets.symmetric(vertical: AppConstants.smallPadding),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            color: AppConstants.primaryColor,
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
        title: const Text(AppConstants.settingsTitle),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Настройки игры:'),
            SizedBox(height: AppConstants.smallPadding),
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
            onPressed: () {
              Navigator.of(context).pop();
              _showResetConfirmation();
            },
            child: const Text(
              AppConstants.resetProgress,
              style: TextStyle(color: AppConstants.errorColor),
            ),
          ),
        ],
      ),
    );
  }

  void _showResetConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(AppConstants.resetProgress),
        content: const Text(AppConstants.resetConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('ОТМЕНА'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              widget.onResetProgress();
            },
            child: const Text(
              'СБРОСИТЬ',
              style: TextStyle(color: AppConstants.errorColor),
            ),
          ),
        ],
      ),
    );
  }
}
