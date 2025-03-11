import 'dart:math';
// import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:qlutter/game/game_core/game_core.dart';
import 'package:qlutter/game/field_view/components/block_item.dart';
import 'package:qlutter/app/ui/components/app_palette.dart';

class FieldViewPreview extends StatefulWidget {
  final Field field;
  final Size? parentSize;
  final Color backgroundColor;
  final bool enable;

  const FieldViewPreview({
    super.key,
    required this.field,
    this.parentSize,
    this.backgroundColor = Colors.white,
    this.enable = false,
  });

  @override
  State<FieldViewPreview> createState() => FieldViewPreviewState();
}

class FieldViewPreviewState extends State<FieldViewPreview> {
  late double elementSize;
  late Field field;
  late Size fieldSize;
  late Size maxViewSize;
  List<Widget> walls = [];
  List<Widget> holes = [];
  List<Widget> balls = [];
  Palette? palette;

  @override
  void initState() {
    super.initState();

    field = widget.field;
    elementSize = 45;
    maxViewSize = const Size(0, 0);
    fieldSize = Size(elementSize, elementSize);
  }

  Widget _buildBall(Item item, double t, double r, Key? key) {
    return Positioned(
      key: key,
      top: (t * fieldSize.height),
      left: (r * fieldSize.height),
      child: BlockItem(
        item: item,
        elementSize: elementSize,
        selected: false,
        onTap: null,
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

  List<Widget> generateFieldItem(List<List<Item?>> fields) {
    balls = [];
    holes = [];
    walls = [];

    double t = 0, r = 0;
    for (var row in fields) {
      for (Item? i in row) {
        if (i != null) {
          if (i is Ball) {
            balls.add(_buildBall(i, t, r, Key('Ball${i.id}')));
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
    walls.addAll(holes);
    if (balls.isNotEmpty) {
      walls.addAll(balls);
    }
    // if (widget.enable == false) {
    //   walls.add(_blur());
    // }
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
      height =
          MediaQuery.of(context).size.height -
          ((field.level.levelId == 0) ? 400 : 200);
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

  Widget _blur(Widget child, Color color) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Opacity(opacity: widget.enable ? 0.9 : 0.2, child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    palette ??= Palette();
    setSize(context);
    return _blur(
      SizedBox(
        height: maxViewSize.height,
        width: maxViewSize.width,
        child: Stack(children: generateFieldItem(field.level.field)),
      ),
      palette?.backgroundMain ?? Colors.white,
    );
  }
}
