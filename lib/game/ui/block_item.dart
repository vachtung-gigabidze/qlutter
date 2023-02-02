import 'package:flutter/material.dart';
import 'package:qlutter/game/core.dart';

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
            color: Colors.transparent,
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