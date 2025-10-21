import 'package:flutter/material.dart';
import 'package:qlutter/ver_1/game/game_core/game_core.dart';

class BlockItem extends StatelessWidget {
  const BlockItem({
    required this.item,
    required this.elementSize,
    super.key,
    this.onTap,
    this.onHover,
    this.selected = false,
    this.removing = false,
    this.onPanUpdate,
  });

  final void Function()? onTap;
  final void Function(bool)? onHover;
  final void Function(DragUpdateDetails)? onPanUpdate;
  final Item? item;
  final bool selected;
  final bool removing;
  final double elementSize;

  @override
  Widget build(BuildContext context) => (item is Ball)
      ? Material(
          color: Colors.transparent,
          child: GestureDetector(
            onPanUpdate: onPanUpdate,
            //hoverColor: Colors.transparent,
            //splashColor: Colors.transparent,
            //onHover: onHover,
            onTap: onTap,
            child: Container(
              height: elementSize,
              width: elementSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: item?.color,
              ),
            ),
          ),
        )
      : Container(
          height: elementSize,
          width: elementSize,
          padding: EdgeInsets.all(elementSize / 20),
          decoration: BoxDecoration(
            //borderRadius: BorderRadius.all(Radius.circular(elementSize / 20)),
            shape: BoxShape.rectangle,
            color: item?.color,
          ),
        );
}
