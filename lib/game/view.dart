import 'package:flutter/material.dart';
import 'package:qlutter/game/core.dart';

class FieldView extends Widget {
  final double ROUND_RECT_SIZE = 0.15;
  final int PADDING_DIVIDER = 4;
  int paddingSize = 0;
  late int elementSize;
  late Field field;
  late Size fieldSize;
  late Size maxViewSize;
  BuildContext context;

  FieldView(this.context, {super.key});

  @override
  Element createElement() {
    // TODO: implement createElement
    throw UnimplementedError();
  }

  Size countFieldSize() {
    maxViewSize ??= Size(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);

    int horizontalElementsNum = field.level.field[0].length;
    int verticalElementsNum = field.level.field.length;

    int maxHorizontalElSize = maxViewSize.width ~/ horizontalElementsNum;
    int maxVerticalElSize = maxViewSize.height ~/ verticalElementsNum;

    elementSize = (maxHorizontalElSize < maxVerticalElSize)
        ? maxHorizontalElSize
        : maxVerticalElSize;

    int newWidth = elementSize * horizontalElementsNum;
    int newHeight = elementSize * verticalElementsNum;

    return Size(newWidth as double, newHeight as double);
  }
}
