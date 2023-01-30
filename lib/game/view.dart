import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qlutter/game/core.dart';
import 'package:qlutter/game/level_manager.dart';

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

  Field? field = null;

  late Size fieldSize;

  late Size maxViewSize;
  late Future<Level?> level;
  Item? selectedItem = null;
  bool showHover = false;
  late LevelManager lm;

  @override
  void initState() {
    elementSize = 45;
    maxViewSize = Size(elementSize * 6, elementSize * 6);
    fieldSize = Size(elementSize, elementSize);
    lm = LevelManager();
    super.initState();
  }

  Widget _buildItem(Item item, double t, double r) {
    return AnimatedPositioned(
      top: (t * fieldSize.height),
      right: (r * fieldSize.height),
      duration: const Duration(seconds: 1),
      curve: Curves.bounceOut,
      child: BlockItem(
        item: item,
        elementSize: elementSize,
        selected: false,
        onHover: (bool value) {
          // setState(() {
          //   showHover = value;
          // });
        },
        onTap: () {
          if (kIsWeb) {
            if (item is Ball) {
              setState(() {
                //  field.moveItem(
                //      Coordinates(r.round(), t.round()), Direction.right);
                selectedItem = item;
                //showHover = !showHover;
              });
            }
          }
        },
      ),
    );
  }

  Widget _buildHover(double t, double r, double h, double w, Coordinates c,
      List<bool> directionMask) {
    // List<bool> directionMask = [true, false, false, false];

    return Positioned(
      top: t * fieldSize.height,
      right: r * fieldSize.height,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            splashFactory: NoSplash.splashFactory,
            onHover: (bool value) {
              // setState(() {
              //     showHover = value;
              // });
            },
            onTap: () {},
            // onTap: () {
            //   setState(() {
            //     //  field.moveItem(c, Direction.right);
            //     showHover = !showHover;
            //   });
            // },
            child: Container(
              height: h,
              width: w,

              child: Stack(
                  children: [
                Positioned(
                  top: elementSize,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        field?.moveItem(c, Direction.right);
                        selectedItem = null;
                        // showHover = false;
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
                        //showHover = false;
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
                        // showHover = false;
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
              // decoration: BoxDecoration(
              //     color: Colors.transparent,
              //     border: Border.all(
              //       color: Colors.black,
              //       width: 5,
              //     )),
            )),
      ),
    );
  }

  List<Widget> generateFieldItem(List<List<Item?>> fields) {
    List<Widget> children = [];
    List<Widget> balls = [];
    Widget? hover;

    double t = 0, r = 0;
    for (var row in fields) {
      for (Item? i in row) {
        if (i != null) {
          if (i is Ball) {
            balls.add(_buildItem(i, t, r));
            if (i.color == selectedItem?.color) {
              hover = _buildHover(
                  t - 1,
                  r - 1,
                  elementSize * 3,
                  elementSize * 3,
                  Coordinates(t.toInt(), r.toInt()),
                  field!.canMove(Coordinates(t.toInt(), r.toInt())));
            }
          } else {
            children.add(_buildItem(i, t, r));
          }
        }
        r++;
      }
      t++;
      r = 0;
    }
    if (balls.isNotEmpty) {
      children.addAll(balls);
    }
    if (hover != null && selectedItem != null) {
      children.add(hover);
    }
    return children;
  }

  Future<Field?> _getField(int level) async {
    if (field == null) {
      field = await lm.getFiled(level);
    }
    return Future.value(field);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Field?>(
        future: _getField(0),
        builder: (BuildContext context, AsyncSnapshot<Field?> snapshot) {
          if (snapshot.hasData) {
            field = snapshot.data!;
            maxViewSize = Size(field!.level.size.height * fieldSize.height,
                field!.level.size.width * fieldSize.width);
            return Center(
              child: SizedBox(
                height: maxViewSize.height,
                width: maxViewSize.width,
                child: Stack(
                  children: generateFieldItem(snapshot.data!.level.field),
                ),
              ),
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

  final VoidCallback? onTap;
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
