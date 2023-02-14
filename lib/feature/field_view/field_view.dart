// import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
// import 'package:provider/provider.dart';
import 'package:qlutter/feature/game_core/game_core.dart';
// import 'package:qlutter/game/core/level_manager.dart';
// import 'package:qlutter/game/core/styles.dart';
// import 'package:qlutter/game/core/ui/alerts/alerts.dart';
import 'package:qlutter/feature/field_view/components/block_item.dart';
import 'package:qlutter/feature/style/palette.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'dart:html';

class FieldView extends StatefulWidget {
  //final Level level;
  final Field field;
  final Function(bool) onChanged;
  final VoidCallback onWin;

  FieldView(
      {super.key,
      required this.field,
      required this.onChanged,
      required this.onWin});

  @override
  State<FieldView> createState() => FieldViewState();
}

class FieldViewState extends State<FieldView> {
  // int paddingSize = 0;
  late double elementSize;
  late Field field;
  // late Field fieldCopy;
  late Size fieldSize;
  late Size maxViewSize;
  Ball? selectedItem;
  // int? selectedLevel;
  bool showHover = false;
  List<Widget> walls = [];
  List<Widget> holes = [];
  List<Widget> balls = [];
  late bool refresh;
  Palette? palette;

  @override
  void initState() {
    super.initState();

    field = widget.field;

    refresh = false;
    elementSize = 45;
    maxViewSize = const Size(0, 0);
    fieldSize = Size(elementSize, elementSize);
  }

  Widget _buildBall(Item item, double t, double r, Key? key) {
    return AnimatedPositioned(
      key: key,
      top: (t * fieldSize.height),
      right: (r * fieldSize.height),
      duration: const Duration(seconds: 1),
      curve: Curves.bounceOut,
      onEnd: () {
        if ((field.acceptHole(Coordinates(t.toInt(), r.toInt())))) {
          if (field.checkWin()) {
            widget.onChanged(true);
            widget.onWin();
          } else {
            widget.onChanged(false);
          }
        }
      },
      child: GestureDetector(
        onPanUpdate: (details) {
          if (details.delta.dx > 0) {
            field.moveItem(Coordinates(t.toInt(), r.toInt()), Direction.right);
          }
          if (details.delta.dx < 0) {
            field.moveItem(Coordinates(t.toInt(), r.toInt()), Direction.left);
          }
        },
        child: BlockItem(
          item: item,
          elementSize: elementSize,
          selected: false,
          onPanUpdate: (DragUpdateDetails details) {
            if (!kIsWeb) {
              if (details.delta.dx > 0) {
                setState(() {
                  field.moveItem(
                      Coordinates(t.toInt(), r.toInt()), Direction.right);
                });
              }
              if (details.delta.dx < 0) {
                setState(() {
                  field.moveItem(
                      Coordinates(t.toInt(), r.toInt()), Direction.left);
                });
              }
            }
          },
          onTap: () {
            if (kIsWeb) {
              if (item is Ball) {
                setState(() {
                  selectedItem = item;
                });
              }
            }
          },
        ),
      ),
    );
  }

  Widget _buildItem(Item item, double t, double r) {
    return Positioned(
      top: (t * fieldSize.height),
      right: (r * fieldSize.height),
      child: BlockItem(
        item: item,
        elementSize: elementSize,
        selected: false,
        onHover: null,
        onTap: null,
      ),
    );
  }

  Widget _buildHover(Coordinates c) {
    List<bool> directionMask =
        field.canMove(Coordinates(c.horizontal, c.vertical));
    return Positioned(
      top: (c.horizontal - 1) * fieldSize.height,
      right: (c.vertical - 1) * fieldSize.height,
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
                  children: [
                Positioned(
                  top: elementSize,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        field.moveItem(c, Direction.right);
                        selectedItem = null;
                      });
                    },
                    child: Icon(
                      Icons.arrow_back_outlined,
                      color: palette?.ink,
                      size: elementSize,
                    ),
                  ),
                ),
                Positioned(
                  top: elementSize,
                  right: 0,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        field.moveItem(c, Direction.left);
                        selectedItem = null;
                      });
                    },
                    child: Icon(
                      Icons.arrow_forward_outlined,
                      color: palette?.ink,
                      size: elementSize,
                    ),
                  ),
                ),
                Positioned(
                  top: elementSize * 2,
                  right: elementSize,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        field.moveItem(c, Direction.down);
                        selectedItem = null;
                      });
                    },
                    child: Icon(
                      Icons.arrow_downward,
                      color: palette?.ink,
                      size: elementSize,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: elementSize,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        field.moveItem(c, Direction.up);
                        selectedItem = null;
                        // showHover = false;
                      });
                    },
                    child: Icon(
                      Icons.arrow_upward,
                      color: palette?.ink,
                      size: elementSize,
                    ),
                  ),
                ),
              ]
                      .asMap()
                      .entries
                      .where((e) => directionMask[e.key])
                      .map((e) => e.value)
                      .toList()),
            )),
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
              hover = _buildHover(
                Coordinates(t.toInt(), r.toInt()),
              );
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double m = min<double>(width, height);
    m *= .8;
    double i = max<double>(field.level.size.height, field.level.size.width);

    elementSize = m / i;
    fieldSize = Size(elementSize, elementSize);
    maxViewSize = Size(field.level.size.height * elementSize,
        field.level.size.width * elementSize);
  }

  @override
  Widget build(BuildContext context) {
    palette ??= context.watch<Palette>();
    setSize(context);
    return Container(
      color: Colors.white,
      height: maxViewSize.height,
      width: maxViewSize.width,
      child: Stack(
        children: generateFieldItem(field.level.field),
      ),
    );
  }
}
