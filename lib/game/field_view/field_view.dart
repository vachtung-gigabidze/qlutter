import 'dart:math';
import 'package:flutter/material.dart';
import 'package:qlutter/game/game_core/game_core.dart';
import 'package:qlutter/game/field_view/components/block_item.dart';
import 'package:qlutter/app/ui/components/app_palette.dart';

class FieldView extends StatefulWidget {
  //final Level level;
  final Field field;
  final VoidCallback onRefresh;
  final Function(int, int) onChanged;
  final VoidCallback onWin;
  final Size? parentSize;
  final Color backgroundColor;
  final bool isView;

  const FieldView({
    super.key,
    required this.field,
    required this.onChanged,
    required this.onWin,
    this.parentSize,
    this.backgroundColor = Colors.white,
    required this.onRefresh,
    this.isView = false,
  });

  @override
  State<FieldView> createState() => FieldViewState();
}

class FieldViewState extends State<FieldView> {
  late double elementSize;
  late Field field;
  late Size fieldSize;
  late Size maxViewSize;
  Ball? selectedItem;
  bool showHover = false;
  List<Widget> walls = [];
  List<Widget> holes = [];
  List<Widget> balls = [];
  late bool refresh;
  Palette? palette;
  late int steps;

  @override
  void initState() {
    super.initState();

    field = widget.field;
    steps = 0;
    refresh = false;
    elementSize = 45;

    maxViewSize = const Size(0, 0);

    fieldSize = Size(elementSize, elementSize);
  }

  Widget _buildBall(Item item, double t, double r, Key? key) {
    return AnimatedPositioned(
      key: key,
      top: (t * fieldSize.height),
      left: (r * fieldSize.height),
      duration: const Duration(milliseconds: 500),
      curve: Curves.bounceOut,
      onEnd: () {
        if ((field.acceptHole(Coordinates(t.toInt(), r.toInt())))) {
          if (field.checkWin()) {
            widget.onChanged(field.ballsCount, steps);
            widget.onWin();
          }
          setState(() {});
        }
      },
      child: InkWell(
        child: BlockItem(
          item: item,
          elementSize: elementSize,
          selected: false,
          onTap: () {
            if (item is Ball && !widget.isView) {
              setState(() {
                selectedItem = item;
              });
            }
          },
        ),
      ),
    );
  }

  Widget _buildItem(Item item, double t, double r) {
    return Positioned(
      top: (t * fieldSize.height),
      left: (r * fieldSize.height),
      child: BlockItem(
        item: item,
        elementSize: elementSize,
        selected: false,
        onHover: null,
        onTap: null,
      ),
    );
  }

  void moveBall(Coordinates c, Direction d) {
    field.moveItem(c, d);
    widget.onChanged(field.ballsCount, steps++);
    selectedItem = null;
    setState(() {});
  }

  Widget _buildHover(Coordinates c) {
    List<bool> directionMask = field.canMove(
      Coordinates(c.horizontal, c.vertical),
    );
    return Positioned(
      top: (c.horizontal - 1) * fieldSize.height,
      left: (c.vertical - 1) * fieldSize.height,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          onHover: (bool value) {},
          onTap: () {},
          child: SizedBox(
            height: elementSize * 3,
            width: elementSize * 3,
            child: Stack(
              children:
                  [
                        Positioned(
                          top: elementSize,
                          right: 0,
                          child: InkWell(
                            onTap: () => moveBall(c, Direction.right),
                            child: Icon(
                              Icons.arrow_forward_outlined,
                              color:
                                  Theme.of(
                                    context,
                                  ).colorScheme.primary, //palette?.ink,
                              size: elementSize,
                            ),
                          ),
                        ),
                        Positioned(
                          top: elementSize,
                          left: 0,
                          child: InkWell(
                            onTap: () => moveBall(c, Direction.left),
                            child: Icon(
                              Icons.arrow_back_outlined,
                              color:
                                  Theme.of(
                                    context,
                                  ).colorScheme.primary, // palette?.ink,
                              size: elementSize,
                            ),
                          ),
                        ),
                        Positioned(
                          top: elementSize * 2,
                          left: elementSize,
                          child: InkWell(
                            onTap: () => moveBall(c, Direction.down),
                            child: Icon(
                              Icons.arrow_downward,
                              color:
                                  Theme.of(
                                    context,
                                  ).colorScheme.primary, //palette?.ink,
                              size: elementSize,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: elementSize,
                          child: InkWell(
                            onTap: () => moveBall(c, Direction.up),
                            child: Icon(
                              Icons.arrow_upward,
                              color:
                                  Theme.of(
                                    context,
                                  ).colorScheme.primary, //palette?.ink,
                              size: elementSize,
                            ),
                          ),
                        ),
                      ]
                      .asMap()
                      .entries
                      .where((e) => directionMask[e.key])
                      .map((e) => e.value)
                      .toList(),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> generateFieldItem(List<List<Item?>> fields) {
    balls = [];
    holes = [];
    walls = [];
    Widget? hover;

    double t = 0, r = 0;
    for (var row in fields) {
      for (Item? i in row) {
        if (i != null) {
          if (i is Ball) {
            balls.add(_buildBall(i, t, r, Key('Ball${i.id}')));
            if (i.id == selectedItem?.id) {
              hover = _buildHover(Coordinates(t.toInt(), r.toInt()));
            }
          } else if (i is Hole) {
            holes.add(_buildItem(i, t, r));
          } else {
            walls.add(_buildItem(i, t, r));
          }
        }
        r++;
      }
      t++;
      r = 0;
    }
    if (hover != null && selectedItem != null) {
      walls.add(hover);
    }
    walls.addAll(holes);
    if (balls.isNotEmpty) {
      walls.addAll(balls);
    }
    return walls;
  }

  void setSize(BuildContext context) {
    double width = 0;
    double height = 0;
    if (widget.parentSize != null) {
      width = widget.parentSize!.width;
      height = widget.parentSize!.height;
    } else {
      width = MediaQuery.of(context).size.width;
      height = MediaQuery.of(context).size.height;
      if (width > height) {
        width -= 400;
        height -= ((field.level.levelId == 0) ? 250 : 100);
      } else {
        height -= ((field.level.levelId == 0) ? 450 : 300);
      }
    }
    double m = min<double>(
      width / field.level.size.width,
      height / field.level.size.height,
    );
    m *= .95;
    //double i = max<double>(field.level.size.height, field.level.size.width);

    elementSize = m; //m / i;
    fieldSize = Size(elementSize, elementSize);
    maxViewSize = Size(
      field.level.size.width * elementSize,
      field.level.size.height * elementSize,
    );
  }

  @override
  Widget build(BuildContext context) {
    palette = Palette();
    setSize(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: SizedBox(
        height: maxViewSize.height,
        width: maxViewSize.width,
        child: Stack(children: generateFieldItem(field.level.field)),
      ),
    );
  }
}
