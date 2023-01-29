import 'package:flutter/material.dart';
import 'package:qlutter/game/core.dart';
import 'package:qlutter/game/level_manager.dart';

class FieldView extends StatefulWidget {
  late LevelManager lm;

  FieldView({super.key}) {
    lm = LevelManager();
  }

  @override
  State<FieldView> createState() => _FieldViewState();
}

class _FieldViewState extends State<FieldView> {
  final double ROUND_RECT_SIZE = 0.15;

  final int PADDING_DIVIDER = 4;

  int paddingSize = 0;

  late int elementSize;

  late Field field;

  late Size fieldSize;

  late Size maxViewSize;
  late Future<Level?> level;
  bool selected = false;

  @override
  void initState() {
    maxViewSize = const Size(600, 600);
    fieldSize = const Size(100, 100);
    super.initState();
  }

  Widget _buildItem(Item item, double? t, double? r) {
    return AnimatedPositioned(
      top: (t! * fieldSize.height),
      right: (r! * fieldSize.height),
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
      child: BlockItem(
        item: item,
        selected: false,
        onTap: () {
          if (item is Ball) {
            setState(() {
              field.moveItem(
                  Coordinates(r.round(), t.round()), Direction.right);
              // selected = !selected;
            });
          }
        },
      ),
    );
  }

  List<Widget> ch(List<List<Item?>> fields) {
    List<Widget> children = [];
    double t = 0, r = 0;
    for (var row in fields) {
      for (Item? i in row) {
        if (i != null) {
          children.add(_buildItem(i, t, r));
        }
        r++;
      }
      t++;
      r = 0;
    }
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Field?>(
        future: widget.lm.getFiled(0),
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
    this.selected = false,
    this.removing = false,
    required this.item,
  });

  final VoidCallback? onTap;
  final Item? item;
  final bool selected;
  final bool removing;

  @override
  Widget build(BuildContext context) {
    return (item is Ball)
        ? GestureDetector(
            // behavior: HitTestBehavior.,
            onTap: onTap,
            child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: item?.color,
                )),
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
