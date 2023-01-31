import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qlutter/game/core.dart';
import 'package:qlutter/game/level_manager.dart';

import 'dart:html';

class FieldView extends StatefulWidget {
  const FieldView({super.key});

  @override
  State<FieldView> createState() => _FieldViewState();
}

class _FieldViewState extends State<FieldView> {
  // final double ROUND_RECT_SIZE = 0.15;

  // final int PADDING_DIVIDER = 4;

  int paddingSize = 0;

  late double elementSize;

  Field? field;

  late Size fieldSize;

  late Size maxViewSize;
  late Future<Level?> level;
  Ball? selectedItem;
  bool showHover = false;
  late LevelManager lm;
  List<Widget> walls = [];
  List<Widget> holes = [];
  List<Widget> balls = [];

  @override
  void initState() {
    elementSize = 45;
    maxViewSize = const Size(0, 0);
    fieldSize = Size(elementSize, elementSize);
    lm = LevelManager();
    super.initState();
  }

  Widget _buildBall(Item item, double t, double r, Key? key) {
    return AnimatedPositioned(
      key: key,
      top: (t * fieldSize.height),
      right: (r * fieldSize.height),
      duration: const Duration(seconds: 1),
      curve: Curves.bounceOut,
      onEnd: () {
        if ((field!.acceptHole(Coordinates(t.toInt(), r.toInt())))) {
          setState(() {
            //selectedItem = null;
            //field!.level.field[t.toInt()][r.toInt()] = null;
          });
        }
      },
      child: BlockItem(
        item: item,
        elementSize: elementSize,
        selected: false,
        //onHover: (bool value) {},
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
        field!.canMove(Coordinates(c.horizontal, c.vertical));
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
                        field?.moveItem(c, Direction.right);
                        selectedItem = null;
                      });
                    },
                    child: Icon(
                      Icons.arrow_back_outlined,
                      color: Colors.black,
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
                        field?.moveItem(c, Direction.left);
                        selectedItem = null;
                      });
                    },
                    child: Icon(
                      Icons.arrow_forward_outlined,
                      color: Colors.black,
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
                        field?.moveItem(c, Direction.down);
                        selectedItem = null;
                      });
                    },
                    child: Icon(
                      Icons.arrow_downward,
                      color: Colors.black,
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
                        field?.moveItem(c, Direction.up);
                        selectedItem = null;
                        // showHover = false;
                      });
                    },
                    child: Icon(
                      Icons.arrow_upward,
                      color: Colors.black,
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

  Future<Field?> _getField(int level) async {
    field ??= await lm.getFiled(level);
    return Future.value(field);
  }

  void setSize(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double m = min<double>(width, height);
    double i = max<double>(field!.level.size.height, field!.level.size.width);

    elementSize = m / i;
    fieldSize = Size(elementSize, elementSize);
    maxViewSize = Size(field!.level.size.height * elementSize,
        field!.level.size.width * elementSize);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Field?>(
        future: _getField(7),
        builder: (BuildContext context, AsyncSnapshot<Field?> snapshot) {
          if (snapshot.hasData) {
            field = snapshot.data!;
            setSize(context);
            return Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Шаров: ${field?.ballsCount ?? 0}"),
                    Text("Уровень: 1"),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: maxViewSize.height,
                  width: maxViewSize.width,
                  child: Stack(
                    children: generateFieldItem(snapshot.data!.level.field),
                  ),
                ),
              ],
            );
          } else {
            return const Text('No data');
          }
        });
  }
}

class BlockItem extends StatelessWidget {
  const BlockItem({
    super.key,
    this.onTap,
    this.onHover,
    this.selected = false,
    this.removing = false,
    required this.item,
    required this.elementSize,
  });

  final void Function()? onTap;
  final void Function(bool)? onHover;
  final Item? item;
  final bool selected;
  final bool removing;
  final double elementSize;

  @override
  Widget build(BuildContext context) {
    return (item is Ball)
        ? Material(
            child: InkWell(
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              onHover: onHover,
              onTap: onTap,
              child: Container(
                  height: elementSize,
                  width: elementSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: item?.color,
                  )),
            ),
          )
        : Container(
            height: elementSize,
            width: elementSize,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: item?.color,
            ));
  }
}
