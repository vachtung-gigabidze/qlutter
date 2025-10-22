// game/level_manager.dart
import 'package:flutter/services.dart';
import 'package:qlutter/ver_2/models/item.dart';
import 'package:qlutter/ver_2/models/level.dart';
// game/level_manager.dart

class LevelManager {
  factory LevelManager() => _instance;
  LevelManager._internal();
  static final LevelManager _instance = LevelManager._internal();

  static const String _levelsAsset = 'assets/data/classic.txt';

  final Map<int, Level> _levelCache = {};
  List<String> _levelData = [];

  Future<void> initialize() async {
    if (_levelData.isNotEmpty) return;

    final data = await rootBundle.loadString(_levelsAsset);
    _levelData = _splitLevels(data);
  }

  List<String> _splitLevels(String data) {
    final lines = data.split('\n');
    final levels = <String>[];
    var currentLevel = StringBuffer();
    var readingLevel = false;
    var expectedLines = 0;
    var linesRead = 0;

    for (final line in lines) {
      final trimmedLine = line.trim();
      if (trimmedLine.isEmpty) continue;

      // Если строка содержит только цифры (номер уровня)
      if (RegExp(r'^\d+$').hasMatch(trimmedLine)) {
        if (readingLevel && currentLevel.isNotEmpty) {
          levels.add(currentLevel.toString());
        }

        // Начинаем новый уровень
        currentLevel.clear();
        currentLevel.writeln(trimmedLine); // Номер уровня
        readingLevel = true;
        linesRead = 1;
        expectedLines = 0;
        continue;
      }

      if (readingLevel) {
        // Первая строка после номера уровня - размеры
        if (linesRead == 1) {
          final dimensions = trimmedLine.split(' ');
          if (dimensions.length == 2) {
            final height = int.tryParse(dimensions[1]);
            if (height != null) {
              expectedLines = height;
            }
          }
        }

        currentLevel.writeln(trimmedLine);
        linesRead++;

        // Если прочитали все строки уровня (номер + размеры + данные)
        if (expectedLines > 0 && linesRead >= expectedLines + 2) {
          levels.add(currentLevel.toString());
          readingLevel = false;
        }
      }
    }

    // Добавляем последний уровень, если он не был добавлен
    if (readingLevel && currentLevel.isNotEmpty) {
      levels.add(currentLevel.toString());
    }

    return levels;
  }

  Future<Level> loadLevel(int levelNumber) async {
    if (_levelCache.containsKey(levelNumber)) {
      return _levelCache[levelNumber]!;
    }

    await initialize();

    if (levelNumber < 1 || levelNumber > _levelData.length) {
      throw Exception(
        'Level $levelNumber not found. Available: 1-${_levelData.length}',
      );
    }

    final levelData = _levelData[levelNumber - 1];
    final level = _parseLevelData(levelData);

    _levelCache[levelNumber] = level;
    return level;
  }

  Level _parseLevelData(String data) {
    final lines = data
        .split('\n')
        .where((line) => line.trim().isNotEmpty)
        .toList();

    if (lines.length < 3) {
      throw Exception('Invalid level data: not enough lines');
    }

    // Первая строка - номер уровня (игнорируем)
    final levelNumber = int.parse(lines[0].trim());

    // Вторая строка - размеры
    final dimensions = lines[1].trim().split(' ');
    if (dimensions.length != 2) {
      throw Exception('Invalid level dimensions: ${lines[1]}');
    }

    final width = int.parse(dimensions[0]);
    final height = int.parse(dimensions[1]);

    // Проверяем, что данных достаточно
    if (lines.length - 2 != height) {
      throw Exception(
        'Level data mismatch: expected $height rows, got ${lines.length - 2}',
      );
    }

    final field = List<List<Item?>>.generate(
      height,
      (y) => List<Item?>.filled(width, null),
    );

    for (var y = 0; y < height; y++) {
      final rowData = lines[y + 2].trim().split(' ');

      // Проверяем ширину строки
      if (rowData.length != width) {
        throw Exception(
          'Row $y width mismatch: expected $width, got ${rowData.length}',
        );
      }

      for (var x = 0; x < width; x++) {
        final itemCode = int.parse(rowData[x]);
        field[y][x] = _parseItemCode(itemCode);
      }
    }

    print('Loaded level $levelNumber: $width x $height');
    return Level(field);
  }

  Item? _parseItemCode(int code) {
    switch (code) {
      case 0:
        return null; // Empty
      case 1:
        return Block();
      case 2:
        return Ball(ItemColor.green);
      case 3:
        return Ball(ItemColor.red);
      case 4:
        return Ball(ItemColor.blue);
      case 5:
        return Ball(ItemColor.yellow);
      case 6:
        return Ball(ItemColor.purple);
      case 7:
        return Ball(ItemColor.cyan);
      case 22:
        return Hole(ItemColor.green);
      case 33:
        return Hole(ItemColor.red);
      case 44:
        return Hole(ItemColor.blue);
      case 55:
        return Hole(ItemColor.yellow);
      case 66:
        return Hole(ItemColor.purple);
      case 77:
        return Hole(ItemColor.cyan);
      default:
        print('Warning: Unknown item code: $code');
        return null;
    }
  }

  int get totalLevels => _levelData.length;

  // Метод для отладки - посмотреть информацию о всех уровнях
  void printLevelsInfo() {
    print('Total levels: $totalLevels');
    for (var i = 0; i < _levelData.length; i++) {
      final data = _levelData[i];
      final lines = data
          .split('\n')
          .where((line) => line.trim().isNotEmpty)
          .toList();
      if (lines.length >= 2) {
        final levelNumber = lines[0].trim();
        final dimensions = lines[1].trim().split(' ');
        if (dimensions.length == 2) {
          print(
            'Level ${i + 1}: $levelNumber, size: ${dimensions[0]}x${dimensions[1]}',
          );
        }
      }
    }
  }
}
