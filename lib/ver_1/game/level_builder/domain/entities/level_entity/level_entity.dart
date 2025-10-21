import 'package:flutter/material.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qlutter/ver_1/game/game_core/game_core.dart';

// @freezed
class Level {
  Level(this.field, this.levelId) {
    ballsCount = _countBallOnLevel();
  }
  int levelId;
  late List<List<Item?>> field;
  late int ballsCount;
  late Map<Color, int> colorsBall;
  late Size size;

  int elements() => (size.width * size.height).round();

  int _countBallOnLevel() {
    colorsBall = <Color, int>{};
    ballsCount = field.fold(
      0,
      (sum, el) =>
          sum +
          el.fold(0, (pre, item) {
            if (item != null && item is Ball) {
              colorsBall[item.color] = (colorsBall[item.color] ?? 0) + 1;
            }
            return (item is Ball) ? pre + 1 : pre;
          }),
    );

    return ballsCount;
  }
}
