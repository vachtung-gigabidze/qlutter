import 'package:flutter/material.dart';
import 'package:qlutter/game/core.dart';
import 'package:qlutter/game/level_manager.dart';

class FieldView extends StatelessWidget {
  final double ROUND_RECT_SIZE = 0.15;
  final int PADDING_DIVIDER = 4;
  int paddingSize = 0;
  late int elementSize;
  late Field field;
  late Size fieldSize;
  late Size maxViewSize;
  BuildContext context;
  late LevelManager lm;

  FieldView(this.context, {super.key}) {
    lm = LevelManager();
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

  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    return BlockItem(
      animation: animation,
      item: 1,
      selected: false,
      onTap: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    // Level level = lm.openLevels()
    return FutureBuilder<Map<int, Level>>(
      future: lm.openLevels(),
      builder: (context, snapshot) => AnimatedGrid(
        initialItemCount: snapshot.data![0]!.field.length,
        itemBuilder: _buildItem,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 100.0,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
      ),
    );
  }
}

class BlockItem extends StatelessWidget {
  const BlockItem({
    super.key,
    this.onTap,
    this.selected = false,
    this.removing = false,
    required this.animation,
    required this.item,
  }) : assert(item >= 0);

  final Animation<double> animation;
  final VoidCallback? onTap;
  final int item;
  final bool selected;
  final bool removing;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headlineMedium!;
    if (selected) {
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
    }
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ScaleTransition(
        scale: CurvedAnimation(
            parent: animation,
            curve: removing ? Curves.easeInOut : Curves.bounceOut),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: SizedBox(
            height: 80.0,
            child: Card(
              color: Colors.primaries[item % Colors.primaries.length],
              child: Center(
                child: Text('${item + 1}', style: textStyle),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
