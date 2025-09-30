import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:qlutter/render/models/step_data.dart';
import 'package:qlutter/render/rendering/painting/stepper_painter.dart';

class RenderCustomStepper extends RenderBox with WidgetsBindingObserver {
  List<StepData> _steps;
  List<StepData> get steps => _steps;
  set steps(List<StepData> value) {
    if (_steps == value) return;
    _steps = value;
    markNeedsLayout();
  }

  void Function(StepData)? _onStepTap;
  void Function(StepData)? get onStepTap => _onStepTap;
  set onStepTap(void Function(StepData)? value) {
    _onStepTap = value;
  }

  TextDirection _textDirection;
  TextDirection get textDirection => _textDirection;
  set textDirection(TextDirection value) {
    if (_textDirection == value) return;
    _textDirection = value;
    markNeedsLayout();
  }

  Ticker? _animationTicker;

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    WidgetsBinding.instance.addObserver(this);
    _animationTicker = Ticker((elapsed) {
      markNeedsPaint();
    })..start();
  }

  @override
  void detach() {
    super.detach();
    _animationTicker?.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  TextStyle _textStyle;
  TextStyle get textStyle => _textStyle;
  set textStyle(TextStyle value) {
    if (_textStyle == value) return;
    _textStyle = value;
    markNeedsLayout();
  }

  final _stepperPainter = StepperPainter();
  final _targets = <_StepTarget>[];

  RenderCustomStepper({
    required List<StepData> steps,
    void Function(StepData)? onStepTap,
    required TextDirection textDirection,
    required TextStyle textStyle,
  }) : _steps = steps,
       _onStepTap = onStepTap,
       _textDirection = textDirection,
       _textStyle = textStyle;

  @override
  bool get isRepaintBoundary => true;

  @override
  void performLayout() {
    final constraints = this.constraints;

    // Вычисляем желаемый размер
    final desiredSize = _stepperPainter.layout(
      steps: steps,
      constraints: constraints,
      textStyle: textStyle,
      textDirection: textDirection,
    );

    // Устанавливаем финальный размер с учетом ограничений
    size = constraints.constrain(desiredSize);

    // Обновляем цели для тапов
    _updateHitTestTargets();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;

    canvas.save();
    canvas.translate(offset.dx, offset.dy);

    _stepperPainter.paint(canvas, size);

    canvas.restore();
  }

  void _updateHitTestTargets() {
    _targets.clear();

    for (int i = 0; i < steps.length; i++) {
      final step = steps[i];
      final rect = _stepperPainter.getStepRect(i);

      _targets.add(_StepTarget(step: step, rect: rect));
    }
  }

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    if (event is PointerDownEvent) {
      final localPosition = globalToLocal(event.position);

      for (final target in _targets) {
        if (target.rect.contains(localPosition)) {
          _onStepTap?.call(target.step);
          break;
        }
      }
    }
  }
}

class _StepTarget {
  final StepData step;
  final Rect rect;

  _StepTarget({required this.step, required this.rect});
}
