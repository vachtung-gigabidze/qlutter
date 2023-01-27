import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qlutter/game/core.dart';
import 'package:qlutter/game/level_manager.dart';

import 'package:qlutter/main.dart';

void main() {
  test('LevelManager Test', () async {
    WidgetsFlutterBinding.ensureInitialized();

    LevelManager lm = LevelManager();

    Map<int, Level> levels = await lm.openLevels();

    expect(levels.length, equals(61));
  });
}
