import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class StepperRenderObject extends RenderBox {
  StepperRenderObject({required this.steps});

  final List<StepData> steps;

  @override
  void performLayout() {
    // super.performLayout();
    size = const Size(200, 200);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;
    canvas
      ..save()
      ..clipRect(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawColor(Colors.red, BlendMode.src);
    canvas.restore();
    // super.paint(context, offset);
  }
}

typedef StepData = ({String title, String subtitle});
final List<StepData> data = <StepData>[
  (title: "1", subtitle: "2"),
  (title: "1", subtitle: "2"),
  (title: "1", subtitle: "2"),
  (title: "1", subtitle: "2"),
  (title: "1", subtitle: "2"),
  (title: "1", subtitle: "2"),
  (title: "1", subtitle: "2"),
  (title: "1", subtitle: "2"),
];
