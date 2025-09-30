import 'package:flutter/material.dart';
import 'package:qlutter/fox_render_box/models/step_data.dart';
import 'package:qlutter/fox_render_box/rendering/render_custom_stepper.dart';

class CustomStepper extends LeafRenderObjectWidget {
  final List<StepData> steps;
  final void Function(StepData)? onStepTap;

  const CustomStepper({super.key, required this.steps, this.onStepTap});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCustomStepper(
      steps: steps,
      onStepTap: onStepTap,
      textDirection: Directionality.of(context),
      textStyle: Theme.of(context).textTheme.titleLarge!,
    );
  }

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
