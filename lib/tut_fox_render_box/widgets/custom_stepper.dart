import 'package:flutter/material.dart';
import 'package:qlutter/tut_fox_render_box/models/step_data.dart';
import 'package:qlutter/tut_fox_render_box/rendering/render_custom_stepper.dart';

class CustomStepper extends LeafRenderObjectWidget {
  const CustomStepper({required this.steps, super.key, this.onStepTap});
  final List<StepData> steps;
  final void Function(StepData)? onStepTap;

  @override
  RenderObject createRenderObject(BuildContext context) => RenderCustomStepper(
    steps: steps,
    onStepTap: onStepTap,
    textDirection: Directionality.of(context),
    textStyle: Theme.of(context).textTheme.titleLarge!,
  );

  @override
  void updateRenderObject(
    BuildContext context,
    RenderCustomStepper renderObject,
  ) {
    renderObject
      ..steps = steps
      ..onStepTap = onStepTap
      ..textDirection = Directionality.of(context)
      ..textStyle = Theme.of(context).textTheme.titleLarge!;
  }
}
