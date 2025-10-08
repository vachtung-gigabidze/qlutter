// game/field_engine.dart
import 'package:qlutter/ver_2/models/coordinates.dart';
import 'package:qlutter/ver_2/models/item.dart';
import 'package:qlutter/ver_2/models/level.dart';

class FieldEngine {
  FieldEngine(this._level) : _ballsCount = _level.ballsCount;
  Level _level;
  int _ballsCount;
  final List<Level> _undoStack = [];

  Level get level => _level;
  int get ballsCount => _ballsCount;
  bool get isLevelComplete => _ballsCount == 0;
  bool get canUndo => _undoStack.isNotEmpty;

  // Основной метод хода
  bool makeTurn(Coordinates coordinates, Direction direction) {
    if (direction == Direction.nowhere) return false;

    final item = _level.field[coordinates.y][coordinates.x];
    if (item is! Ball) return false;

    // Сохраняем состояние для отмены
    _saveState();

    final newCoordinates = _moveItem(coordinates, direction);
    if (newCoordinates == null) return false;

    final holeAccepted = _acceptHole(newCoordinates, direction);

    if (holeAccepted && isLevelComplete) {
      return true;
    }

    return holeAccepted;
  }

  void _saveState() {
    // Создаем глубокую копию поля
    final copiedField = _level.field.map(List<Item?>.from).toList();
    _undoStack.add(Level(copiedField));

    // Ограничиваем размер стека отмены
    if (_undoStack.length > 10) {
      _undoStack.removeAt(0);
    }
  }

  bool undo() {
    if (_undoStack.isEmpty) return false;

    final previousState = _undoStack.removeLast();
    _level = previousState;
    _ballsCount = _countBalls();
    return true;
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

  bool _acceptHole(Coordinates coords, Direction direction) {
    var isAccepted = false;

    switch (direction) {
      case Direction.right:
        isAccepted = _acceptRight(coords);
        break;
      case Direction.left:
        isAccepted = _acceptLeft(coords);
        break;
      case Direction.up:
        isAccepted = _acceptUp(coords);
        break;
      case Direction.down:
        isAccepted = _acceptDown(coords);
        break;
      case Direction.nowhere:
        return false;
    }

    if (isAccepted) {
      _catchBall();
    }

    return isAccepted;
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
      return true;
    }

    return false;
  }

  void _catchBall() {
    _ballsCount--;
  }

  void resetLevel(Level newLevel) {
    _level = newLevel;
    _ballsCount = newLevel.ballsCount;
    _undoStack.clear();
  }
}
