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

  late int elementSize;

  Field? field = null;

  late Size fieldSize;

  late Size maxViewSize;
  late Future<Level?> level;
  bool selected = false;
  bool showHover = false;
  late LevelManager lm;

  @override
  void initState() {
    maxViewSize = const Size(600, 600);
    fieldSize = const Size(100, 100);
    lm = LevelManager();
    super.initState();
  }

  Widget _buildItem(Item item, double t, double r) {
    return AnimatedPositioned(
      top: (t * fieldSize.height),
      right: (r * fieldSize.height),
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
      child: BlockItem(
        item: item,
        selected: false,
        onHover: (bool value) {
          setState(() {
            showHover = value;
          });
        },
        onTap: () {
          // if (!kIsWeb) {
          //   if (item is Ball) {
          //     setState(() {
          //       field.moveItem(
          //           Coordinates(r.round(), t.round()), Direction.right);
          //       // selected = !selected;
          //     });
          //   }
          // }
        },
      ),
    );
  }

  Widget _buildHover(double t, double r, double h, double w, Coordinates c) {
    return Positioned(
      top: t * fieldSize.height,
      right: r * fieldSize.height,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            splashFactory: NoSplash.splashFactory,
            onHover: (bool value) {
              setState(() {
                showHover = value;
              });
            },
            onTap: () {},
            // onTap: () {
            //   setState(() {
            //     field.moveItem(c, Direction.right);
            //     showHover = false;
            //   });
            // },
            child: Container(
              height: h,
              width: w,

              child: Stack(children: [
                Positioned(
                  top: 100,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        field?.moveItem(c, Direction.right);
                        showHover = false;
                      });
                    },
                    child: const Icon(
                      Icons.arrow_back_outlined,
                      color: Colors.black,
                      size: 100,
                    ),
                  ),
                ),
                Positioned(
                  top: 100,
                  right: 0,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        field?.moveItem(c, Direction.left);
                        showHover = false;
                      });
                    },
                    child: const Icon(
                      Icons.arrow_forward_outlined,
                      color: Colors.black,
                      size: 100,
                    ),
                  ),
                ),
                Positioned(
                  top: 200,
                  right: 100,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        field?.moveItem(c, Direction.down);
                        showHover = false;
                      });
                    },
                    child: const Icon(
                      Icons.arrow_downward,
                      color: Colors.black,
                      size: 100,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 100,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        field?.moveItem(c, Direction.up);
                        showHover = false;
                      });
                    },
                    child: const Icon(
                      Icons.arrow_upward,
                      color: Colors.black,
                      size: 100,
                    ),
                  ),
                ),
              ]),
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

  List<Widget> ch(List<List<Item?>> fields) {
    List<Widget> children = [];
    List<Widget> balls = [];
    Widget? hover;

    double t = 0, r = 0;
    for (var row in fields) {
      for (Item? i in row) {
        if (i != null) {
          if (i is Ball) {
            balls.add(_buildItem(i, t, r));
            hover = _buildHover(
                t - 1, r - 1, 300, 300, Coordinates(t.toInt(), r.toInt()));
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
    if (hover != null && showHover) {
      children.add(hover);
    }
    return children;
  }

  Future<Field?> _getField(int level) async {
    if (field == null) {
      field = await lm.getFiled(0);
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
            return Center(
              child: SizedBox(
                height: maxViewSize.height,
                width: maxViewSize.width,
                child: Stack(
                  children: ch(snapshot.data!.level.field),
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
  });

  final VoidCallback? onTap;
  final void Function(bool)? onHover;
  final Item? item;
  final bool selected;
  final bool removing;

  @override
  Widget build(BuildContext context) {
    return (item is Ball)
        ? Material(
            child: InkWell(
              onHover: onHover,
              onTap: onTap,
              child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: item?.color,
                  )),
            ),
          )
        : Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: item?.color,
            ));
  }
}
