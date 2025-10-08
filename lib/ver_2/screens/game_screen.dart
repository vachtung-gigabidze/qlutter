// screens/game_screen.dart
import 'package:flutter/material.dart';
import 'package:qlutter/ver_2/game/level_manager.dart';
import 'package:qlutter/ver_2/models/level.dart';
import 'package:qlutter/ver_2/screens/level_select_screen.dart';
import 'package:qlutter/ver_2/services/storage_service.dart';
import 'package:qlutter/ver_2/widgets/field_widget.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key, required this.levelNumber});
  final int levelNumber;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late Future<Level> _levelFuture;
  final LevelManager _levelManager = LevelManager();
  bool _isFieldChanged = false;

  @override
  void initState() {
    super.initState();
    _levelFuture = _levelManager.loadLevel(widget.levelNumber);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final isSmallScreen = mediaQuery.size.shortestSide < 600;

    return Scaffold(
      appBar: _buildAdaptiveAppBar(isLandscape, isSmallScreen),
      body: _buildAdaptiveBody(isLandscape, isSmallScreen),
      bottomNavigationBar: isSmallScreen ? _buildMobileBottomBar() : null,
    );
  }

  PreferredSizeWidget _buildAdaptiveAppBar(
    bool isLandscape,
    bool isSmallScreen,
  ) {
    final fontSize = isSmallScreen ? 18.0 : 22.0;

    return AppBar(
      title: Text(
        'Уровень ${widget.levelNumber}',
        style: TextStyle(fontSize: fontSize),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: _onBackPressed,
      ),
      actions: [
        if (!isSmallScreen) // На десктопе кнопки в appBar
          _buildDesktopControls(),
      ],
    );
  }

  Widget _buildDesktopControls() => Row(
    children: [
      IconButton(
        icon: const Icon(Icons.skip_previous),
        onPressed: widget.levelNumber > 1 ? _loadPreviousLevel : null,
        tooltip: 'Предыдущий уровень',
      ),
      IconButton(
        icon: const Icon(Icons.skip_next),
        onPressed: _loadNextLevel,
        tooltip: 'Следующий уровень',
      ),
      const SizedBox(width: 8),
    ],
  );

  Widget _buildAdaptiveBody(bool isLandscape, bool isSmallScreen) => SafeArea(
    child: Padding(
      padding: _getBodyPadding(isLandscape, isSmallScreen),
      child: FutureBuilder<Level>(
        future: _levelFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Загрузка уровня...'),
                ],
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Ошибка загрузки уровня: ${snapshot.error}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _restartLevel,
                    child: const Text('Попробовать снова'),
                  ),
                ],
              ),
            );
          }

          final level = snapshot.data!;
          return Column(
            children: [
              if (isLandscape && !isSmallScreen) _buildLandscapeHeader(),

              Expanded(
                child: FieldWidget(
                  level: level,
                  onLevelComplete: _onLevelComplete,
                  onStateChanged: _onFieldStateChanged,
                ),
              ),

              if (!isSmallScreen && !isLandscape) _buildDesktopBottomBar(),
            ],
          );
        },
      ),
    ),
  );

  EdgeInsets _getBodyPadding(bool isLandscape, bool isSmallScreen) {
    if (isSmallScreen) {
      return const EdgeInsets.all(8);
    } else if (isLandscape) {
      return const EdgeInsets.symmetric(horizontal: 20, vertical: 10);
    } else {
      return const EdgeInsets.all(16);
    }
  }

  Widget _buildLandscapeHeader() => Container(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.arrow_back),
          label: const Text('Назад'),
          onPressed: () => _onBackPressed(),
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.skip_previous),
          label: const Text('Предыдущий'),
          onPressed: widget.levelNumber > 1 ? _loadPreviousLevel : null,
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.skip_next),
          label: const Text('Следующий'),
          onPressed: _loadNextLevel,
        ),
      ],
    ),
  );

  Widget _buildMobileBottomBar() => SafeArea(
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton.icon(
            icon: const Icon(Icons.skip_previous),
            label: const Text('Пред.'),
            onPressed: widget.levelNumber > 1 ? _loadPreviousLevel : null,
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.home),
            label: const Text('Меню'),
            onPressed: _onBackPressed,
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.skip_next),
            label: const Text('След.'),
            onPressed: _loadNextLevel,
          ),
        ],
      ),
    ),
  );

  Widget _buildDesktopBottomBar() => Container(
    padding: const EdgeInsets.all(16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.arrow_back),
          label: const Text('В меню'),
          onPressed: () => _onBackPressed(),
        ),
        const SizedBox(width: 20),
        ElevatedButton.icon(
          icon: const Icon(Icons.list),
          label: const Text('Выбор уровней'),
          onPressed: _openLevelSelect,
        ),
      ],
    ),
  );

  void _onFieldStateChanged() {
    setState(() {
      _isFieldChanged = true;
    });
  }

  void _onLevelComplete() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Уровень пройден!'),
        content: const Text('Поздравляем! Переходим к следующему уровню.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _loadNextLevel();
            },
            child: const Text('Далее'),
          ),
        ],
      ),
    );
  }

  Future<void> _loadNextLevel() async {
    try {
      final nextLevel = widget.levelNumber + 1;
      final level = await _levelManager.loadLevel(nextLevel);

      setState(() {
        _levelFuture = Future.value(level);
        _isFieldChanged = false;
      });

      // Сохраняем прогресс
      await StorageService.setCurrentLevel(nextLevel);
    } catch (e) {
      _showErrorDialog('Это последний уровень!');
    }
  }

  Future<void> _loadPreviousLevel() async {
    if (widget.levelNumber <= 1) return;

    try {
      final prevLevel = widget.levelNumber - 1;
      final level = await _levelManager.loadLevel(prevLevel);

      setState(() {
        _levelFuture = Future.value(level);
        _isFieldChanged = false;
      });
    } catch (e) {
      _showErrorDialog('Ошибка загрузки уровня');
    }
  }

  void _restartLevel() {
    setState(() {
      _levelFuture = _levelManager.loadLevel(widget.levelNumber);
      _isFieldChanged = false;
    });
  }

  void _onBackPressed() {
    Navigator.of(context).pop();
  }

  void _openLevelSelect() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LevelSelectScreen()),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ошибка'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
