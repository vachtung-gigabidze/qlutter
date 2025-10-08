// game/level_manager.dart
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:qlutter/ver_2/models/item.dart';
import 'package:qlutter/ver_2/models/level.dart';

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

    for (final line in lines) {
      if (line.trim().isEmpty) continue;

      if (line.startsWith(RegExp(r'^\d+'))) {
        if (readingLevel) {
          levels.add(currentLevel.toString());
          currentLevel.clear();
        }
        readingLevel = true;
      }

      if (readingLevel) {
        currentLevel.writeln(line);
      }
    }

    // Добавляем последний уровень
    if (currentLevel.isNotEmpty) {
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
      throw Exception('Level $levelNumber not found');
    }

    final levelData = _levelData[levelNumber - 1];
    final level = _parseLevelData(levelData);

    _levelCache[levelNumber] = level;
    return level;
  }

  Level _parseLevelData(String data) {
    final lines = data.split('\n');
    // Пропускаем первую строку с номером уровня
    final dimensions = lines[1].split(' ');
    final width = int.parse(dimensions[0]);
    final height = int.parse(dimensions[1]);

    final field = List<List<Item?>>.generate(
      height,
      (y) => List<Item?>.filled(width, null),
    );

    for (var y = 0; y < height; y++) {
      final rowData = lines[y + 2].split(' ');
      for (var x = 0; x < width; x++) {
        final itemCode = int.parse(rowData[x]);
        field[y][x] = _parseItemCode(itemCode);
      }
    }

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
        return null;
    }
  }

  int get totalLevels => _levelData.length;
}
