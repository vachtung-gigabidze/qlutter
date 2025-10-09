import 'package:qlutter/ver_2/constants/app_constants.dart';
import 'package:qlutter/ver_2/models/coordinates.dart';
import 'package:qlutter/ver_2/models/item.dart';
import 'package:qlutter/ver_2/models/level.dart';
import 'package:qlutter/ver_2/models/level_stats.dart';
import 'package:qlutter/ver_2/models/move_history.dart';

// Класс для хранения результата хода
class TurnResult {
  // Завершен ли уровень

  const TurnResult({
    required this.moved,
    required this.holeAccepted,
    required this.levelComplete,
  });
  final bool moved; // Был ли совершен ход
  final bool holeAccepted; // Был ли шар закатан в лунку
  final bool levelComplete;
}

class FieldEngine {
  FieldEngine(this._level)
    : _ballsCount = _level.ballsCount,
      _initialBallsCount = _level.ballsCount,
      _stats = LevelStats.start() {
    // Сохраняем начальное состояние
    _saveInitialState();
  }
  Level _level;
  int _ballsCount;
  final List<MoveHistory> _undoStack = [];
  final List<MoveHistory> _redoStack = []; // Стек для возврата отмененных ходов
  LevelStats _stats;
  int _initialBallsCount;

  Level get level => _level;
  int get ballsCount => _ballsCount;
  bool get isLevelComplete => _ballsCount == 0;
  bool get canUndo => _undoStack.isNotEmpty;
  bool get canRedo => _redoStack.isNotEmpty; // Можно вернуть отмененный ход
  bool get canReset => _undoStack.isNotEmpty; // Можно сбросить к началу
  LevelStats get stats =>
      _stats.copyWith(time: DateTime.now().difference(_stats.levelStartTime));
  int get initialBallsCount => _initialBallsCount;
  int get historySize => _undoStack.length; // Размер истории

  void _saveInitialState() {
    final initialHistory = MoveHistory(
      levelState: _createLevelCopy(_level),
      ballsCount: _ballsCount,
      stats: _stats.copyWith(),
      description: 'Начальное состояние',
    );
    _undoStack.add(initialHistory);
  }

  TurnResult makeTurn(Coordinates coordinates, Direction direction) {
    if (direction == Direction.nowhere) {
      return const TurnResult(
        moved: false,
        holeAccepted: false,
        levelComplete: false,
      );
    }

    final item = _level.field[coordinates.y][coordinates.x];
    if (item is! Ball) {
      return const TurnResult(
        moved: false,
        holeAccepted: false,
        levelComplete: false,
      );
    }

    // Очищаем стек возврата при новом ходе
    _redoStack.clear();

    _saveState('Ход: ($coordinates) -> $direction');

    final newCoordinates = _moveItem(coordinates, direction);
    if (newCoordinates == null) {
      return const TurnResult(
        moved: false,
        holeAccepted: false,
        levelComplete: false,
      );
    }

    // Сначала выполняем закатывание и обновляем счетчики
    final holeAccepted = _acceptHole(newCoordinates, direction);

    // Затем проверяем завершение уровня
    final levelComplete = isLevelComplete;

    // Обновляем статистику шагов
    _stats = _stats.copyWith(steps: _stats.steps + 1);

    return TurnResult(
      moved: true,
      holeAccepted: holeAccepted,
      levelComplete: levelComplete,
    );
  }

  void _saveState(String description) {
    final history = MoveHistory(
      levelState: _createLevelCopy(_level),
      ballsCount: _ballsCount,
      stats: _stats.copyWith(),
      description: description,
    );

    _undoStack.add(history);

    // Ограничиваем размер истории
    if (_undoStack.length > AppConstants.maxHistorySize) {
      _undoStack.removeAt(0); // Удаляем самый старый ход
    }
  }

  Level _createLevelCopy(Level original) {
    final copiedField = original.field.map(List<Item?>.from).toList();
    return Level(copiedField);
  }

  bool undo() {
    if (_undoStack.length < 2) return false; // Нужно как минимум 2 состояния

    // Сохраняем текущее состояние в стек возврата
    final currentState = MoveHistory(
      levelState: _createLevelCopy(_level),
      ballsCount: _ballsCount,
      stats: _stats.copyWith(),
      description: 'Текущее состояние перед отменой',
    );
    _redoStack.add(currentState);

    // Восстанавливаем предыдущее состояние
    _undoStack.removeLast(); // Удаляем текущее состояние
    final previousState = _undoStack.last;

    _restoreState(previousState);

    return true;
  }

  bool redo() {
    if (_redoStack.isEmpty) return false;

    // Сохраняем текущее состояние
    _saveState('Состояние перед возвратом');

    // Восстанавливаем состояние из стека возврата
    final nextState = _redoStack.removeLast();
    _restoreState(nextState);

    // Добавляем восстановленное состояние в историю
    _undoStack.add(
      MoveHistory(
        levelState: _createLevelCopy(_level),
        ballsCount: _ballsCount,
        stats: _stats.copyWith(),
        description: 'Возврат хода',
      ),
    );

    return true;
  }

  void _restoreState(MoveHistory history) {
    _level = _createLevelCopy(history.levelState);
    _ballsCount = history.ballsCount;
    _stats = history.stats.copyWith();
  }

  bool resetToBeginning() {
    if (_undoStack.isEmpty) return false;

    // Сохраняем текущее состояние в стек возврата
    final currentState = MoveHistory(
      levelState: _createLevelCopy(_level),
      ballsCount: _ballsCount,
      stats: _stats.copyWith(),
      description: 'Состояние перед сбросом',
    );
    _redoStack.add(currentState);

    // Восстанавливаем начальное состояние
    final initialState = _undoStack.first;
    _restoreState(initialState);

    // Очищаем историю кроме начального состояния
    _undoStack.clear();
    _undoStack.add(initialState);

    return true;
  }

  // Получить историю ходов (для отладки)
  List<String> getMoveHistory() => _undoStack
      .map((history) => history.description ?? 'Без описания')
      .toList();

  bool _acceptHole(Coordinates coords, Direction direction) {
    var isAccepted = false;
    ItemColor? capturedColor;

    switch (direction) {
      case Direction.right:
        isAccepted = _acceptRight(coords);
        if (isAccepted) capturedColor = _getBallColor(coords);
        break;
      case Direction.left:
        isAccepted = _acceptLeft(coords);
        if (isAccepted) capturedColor = _getBallColor(coords);
        break;
      case Direction.up:
        isAccepted = _acceptUp(coords);
        if (isAccepted) capturedColor = _getBallColor(coords);
        break;
      case Direction.down:
        isAccepted = _acceptDown(coords);
        if (isAccepted) capturedColor = _getBallColor(coords);
        break;
      case Direction.nowhere:
        return false;
    }

    if (isAccepted && capturedColor != null) {
      // Увеличиваем счетчик для этого цвета
      final updatedBalls = Map<ItemColor, int>.from(_stats.ballsCaptured);
      updatedBalls[capturedColor] = (updatedBalls[capturedColor] ?? 0) + 1;
      _stats = _stats.copyWith(ballsCaptured: updatedBalls);
    }

    return isAccepted;
  }

  ItemColor? _getBallColor(Coordinates coords) {
    final item = _level.field[coords.y][coords.x];
    return item is Ball ? item.color : null;
  }

  bool _acceptRight(Coordinates coords) {
    final x = coords.x;
    final y = coords.y;

    if (x + 1 >= _level.width) return false;

    final nextItem = _level.field[y][x + 1];
    final currentItem = _level.field[y][x];

    if (nextItem is Hole &&
        currentItem is Ball &&
        nextItem.color == currentItem.color) {
      _level.field[y][x] = null;
      _catchBall(); // Уменьшаем счетчик шаров
      return true;
    }

    return false;
  }

  bool _acceptLeft(Coordinates coords) {
    final x = coords.x;
    final y = coords.y;

    if (x - 1 < 0) return false;

    final nextItem = _level.field[y][x - 1];
    final currentItem = _level.field[y][x];

    if (nextItem is Hole &&
        currentItem is Ball &&
        nextItem.color == currentItem.color) {
      _level.field[y][x] = null;
      _catchBall(); // Уменьшаем счетчик шаров
      return true;
    }

    return false;
  }

  bool _acceptUp(Coordinates coords) {
    final x = coords.x;
    final y = coords.y;

    if (y - 1 < 0) return false;

    final nextItem = _level.field[y - 1][x];
    final currentItem = _level.field[y][x];

    if (nextItem is Hole &&
        currentItem is Ball &&
        nextItem.color == currentItem.color) {
      _level.field[y][x] = null;
      _catchBall(); // Уменьшаем счетчик шаров
      return true;
    }

    return false;
  }

  bool _acceptDown(Coordinates coords) {
    final x = coords.x;
    final y = coords.y;

    if (y + 1 >= _level.height) return false;

    final nextItem = _level.field[y + 1][x];
    final currentItem = _level.field[y][x];

    if (nextItem is Hole &&
        currentItem is Ball &&
        nextItem.color == currentItem.color) {
      _level.field[y][x] = null;
      _catchBall(); // Уменьшаем счетчик шаров
      return true;
    }

    return false;
  }

  void _catchBall() {
    _ballsCount--;
    print('Шар закатан! Осталось шаров: $_ballsCount'); // Для отладки
  }

  Coordinates? _moveItem(Coordinates coords, Direction direction) {
    switch (direction) {
      case Direction.right:
        return _moveRight(coords);
      case Direction.left:
        return _moveLeft(coords);
      case Direction.up:
        return _moveUp(coords);
      case Direction.down:
        return _moveDown(coords);
      case Direction.nowhere:
        return null;
    }
  }

  Coordinates _moveRight(Coordinates coords) {
    var x = coords.x;
    var y = coords.y;
    final field = _level.field;

    while (x + 1 < _level.width && field[y][x + 1] == null) {
      field[y][x + 1] = field[y][x];
      field[y][x] = null;
      x++;
    }

    return Coordinates(x, y);
  }

  Coordinates _moveLeft(Coordinates coords) {
    var x = coords.x;
    var y = coords.y;
    final field = _level.field;

    while (x - 1 >= 0 && field[y][x - 1] == null) {
      field[y][x - 1] = field[y][x];
      field[y][x] = null;
      x--;
    }

    return Coordinates(x, y);
  }

  Coordinates _moveUp(Coordinates coords) {
    var x = coords.x;
    var y = coords.y;
    final field = _level.field;

    while (y - 1 >= 0 && field[y - 1][x] == null) {
      field[y - 1][x] = field[y][x];
      field[y][x] = null;
      y--;
    }

    return Coordinates(x, y);
  }

  Coordinates _moveDown(Coordinates coords) {
    var x = coords.x;
    var y = coords.y;
    final field = _level.field;

    while (y + 1 < _level.height && field[y + 1][x] == null) {
      field[y + 1][x] = field[y][x];
      field[y][x] = null;
      y++;
    }

    return Coordinates(x, y);
  }

  int _countBalls() {
    var count = 0;
    for (final row in _level.field) {
      for (final item in row) {
        if (item is Ball) count++;
      }
    }
    return count;
  }

  // bool undo() {
  //   if (_undoStack.isEmpty) return false;

  //   final previousState = _undoStack.removeLast();
  //   _level = previousState;
  //   _ballsCount = _countBalls();

  //   // При отмене уменьшаем счетчик шагов
  //   _stats = _stats.copyWith(steps: _stats.steps - 1);

  //   return true;
  // }

  // void _saveState() {
  //   final copiedField = _level.field.map(List<Item?>.from).toList();
  //   _undoStack.add(Level(copiedField));

  //   if (_undoStack.length > 10) {
  //     _undoStack.removeAt(0);
  //   }
  // }

  void resetLevel(Level newLevel) {
    _level = newLevel;
    _ballsCount = newLevel.ballsCount;
    _initialBallsCount = newLevel.ballsCount;
    _undoStack.clear();
    _redoStack.clear();
    _stats = LevelStats.start();
    _saveInitialState();
  }
}
