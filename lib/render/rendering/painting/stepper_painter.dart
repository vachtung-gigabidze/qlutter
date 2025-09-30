import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:qlutter/render/models/step_data.dart' show StepData;

class StepperPainter {
  static const _iconSize = 32.0;
  static const _padding = 16.0;
  static const _lineWidth = 2.0;

  final List<Rect> _stepRects = [];
  Size _size = Size.zero;
  final _textPainter = TextPainter(
    textDirection: TextDirection.ltr,
    textAlign: TextAlign.left,
    ellipsis: '...',
    maxLines: 2,
  );
  Picture? _picture;

  Size layout({
    required List<StepData> steps,
    required BoxConstraints constraints,
    required TextStyle textStyle,
    required TextDirection textDirection,
  }) {
    _stepRects.clear();
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);

    double maxWidth = 0;
    double totalHeight = 0;

    for (int i = 0; i < steps.length; i++) {
      final step = steps[i];

      // Добавляем отступ между шагами (кроме первого)
      if (i > 0) {
        totalHeight += _padding;
      }

      // Измеряем заголовок
      _textPainter
        ..text = TextSpan(text: step.title, style: textStyle)
        ..layout(maxWidth: constraints.maxWidth - _iconSize - _padding * 2);

      final titleHeight = _textPainter.height;

      _textPainter.paint(canvas, Offset(50, totalHeight));
      // Измеряем подзаголовок
      _textPainter
        ..text = TextSpan(
          text: step.subtitle,
          style: textStyle.copyWith(color: Colors.grey),
        )
        ..layout(maxWidth: constraints.maxWidth - _iconSize - _padding * 2);

      _textPainter.paint(canvas, Offset(50, totalHeight + _textPainter.height));
      final subtitleHeight = _textPainter.height;
      final stepHeight = titleHeight + subtitleHeight + _padding;

      // Сохраняем прямоугольник шага для хит-теста
      _stepRects.add(
        Rect.fromLTWH(0, totalHeight, constraints.maxWidth, stepHeight),
      );

      // Обновляем максимальную ширину и общую высоту
      maxWidth = constraints.maxWidth;
      totalHeight += stepHeight;
    }

    final linePaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = _lineWidth;

    final circlePaint = Paint()..color = Colors.blue;

    for (int i = 0; i < _stepRects.length; i++) {
      final rect = _stepRects[i];
      final centerY = rect.top + _iconSize / 2;

      // Рисуем линию между шагами (кроме последнего)
      if (i < _stepRects.length - 1) {
        final nextRect = _stepRects[i + 1];
        final lineEndY = nextRect.top;

        canvas.drawLine(
          Offset(_iconSize / 2, centerY),
          Offset(_iconSize / 2, lineEndY),
          linePaint,
        );
      }
      // canvas.drawRawPoints(PointMode.points, points, paint)

      // Рисуем кружок
      canvas.drawCircle(
        Offset(_iconSize / 2, centerY),
        _iconSize / 4,
        circlePaint,
      );
    }
    _picture = recorder.endRecording();

    _size = Size(maxWidth, totalHeight);
    return _size;
  }

  void paint(Canvas canvas, Size size) {
    if (_picture == null) return;

    canvas.drawPicture(_picture!);
  }

  Rect getStepRect(int index) {
    if (index < 0 || index >= _stepRects.length) {
      return Rect.zero;
    }
    return _stepRects[index];
  }
}
