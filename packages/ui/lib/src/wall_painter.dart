import 'package:flutter/material.dart';

class TopWallCP extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint0Fill = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xffF8F4FF);
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height * 0.5000000),
      paint0Fill,
    );

    var path_1 = Path()
      ..moveTo(0, size.height * 0.5000000)
      ..lineTo(size.width, size.height * 0.5000000)
      ..lineTo(size.width, size.height * 0.6700000)
      ..lineTo(0, size.height * 0.6700000)
      ..lineTo(0, size.height * 0.5000000)
      ..close();

    var paint1Fill = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xff8889B6).withOpacity(1);
    canvas.drawPath(path_1, paint1Fill);

    var paint2Fill = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xff060606).withOpacity(0.2);
    canvas.drawRect(
      Rect.fromLTWH(
        0,
        size.height * 0.6700000,
        size.width,
        size.height * 0.1500000,
      ),
      paint2Fill,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Left по умолчанию
class LeftWallCP extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint0Fill = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xffF8F4FF);
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width * 0.500000, size.height),
      paint0Fill,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class TopLeftOutAngleCP extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var path_0 = Path()
      ..moveTo(0, size.height * 0.6500000)
      ..lineTo(size.width * 0.3200000, size.height * 0.6500000)
      ..cubicTo(
        size.width * 0.4194110,
        size.height * 0.6500000,
        size.width * 0.5000000,
        size.height * 0.5694110,
        size.width * 0.5000000,
        size.height * 0.4700000,
      )
      ..lineTo(size.width * 0.5000000, size.height * 0.6400000)
      ..cubicTo(
        size.width * 0.4999990,
        size.height * 0.7394100,
        size.width * 0.4194100,
        size.height * 0.8200000,
        size.width * 0.3200000,
        size.height * 0.8200000,
      )
      ..lineTo(0, size.height * 0.8200000)
      ..lineTo(0, size.height * 0.6500000)
      ..close();

    var paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = Colors.black.withOpacity(0.2);
    canvas.drawPath(path_0, paint0Fill);

    var path_1 = Path()
      ..moveTo(0, size.height * 0.5000000)
      ..lineTo(size.width * 0.3200000, size.height * 0.5000000)
      ..cubicTo(
        size.width * 0.4194110,
        size.height * 0.5000000,
        size.width * 0.5000000,
        size.height * 0.4194110,
        size.width * 0.5000000,
        size.height * 0.3200000,
      )
      ..lineTo(size.width * 0.5000000, size.height * 0.4900000)
      ..cubicTo(
        size.width * 0.5000000,
        size.height * 0.5894110,
        size.width * 0.4194110,
        size.height * 0.6700000,
        size.width * 0.3200000,
        size.height * 0.6700000,
      )
      ..lineTo(0, size.height * 0.6700000)
      ..lineTo(0, size.height * 0.5000000)
      ..close();

    var paint1Fill = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xff8889B6).withOpacity(1);
    canvas.drawPath(path_1, paint1Fill);

    var path_2 = Path()
      ..moveTo(size.width * 0.5000000, 0)
      ..lineTo(size.width * 0.5000000, size.height * 0.3200000)
      ..cubicTo(
        size.width * 0.5000000,
        size.height * 0.4194110,
        size.width * 0.4194110,
        size.height * 0.5000000,
        size.width * 0.3200000,
        size.height * 0.5000000,
      )
      ..lineTo(0, size.height * 0.5000000)
      ..lineTo(0, 0)
      ..lineTo(size.width * 0.5000000, 0)
      ..close();

    var paint2Fill = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xffF8F4FF).withOpacity(1);
    canvas.drawPath(path_2, paint2Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class TopLeftInAngleCP extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var path_0 = Path()
      ..moveTo(size.width, size.height * 0.8200000)
      ..lineTo(size.width * 0.6800000, size.height * 0.8200000)
      ..cubicTo(
        size.width * 0.5805890,
        size.height * 0.8200000,
        size.width * 0.5000000,
        size.height * 0.9005890,
        size.width * 0.5000000,
        size.height,
      )
      ..lineTo(size.width * 0.5000000, size.height * 0.8300000)
      ..cubicTo(
        size.width * 0.5000010,
        size.height * 0.7305900,
        size.width * 0.5805900,
        size.height * 0.6500000,
        size.width * 0.6800000,
        size.height * 0.6500000,
      )
      ..lineTo(size.width, size.height * 0.6500000)
      ..lineTo(size.width, size.height * 0.8200000)
      ..close();

    var paint0Fill = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.black.withOpacity(0.2);
    canvas.drawPath(path_0, paint0Fill);

    var path_1 = Path()
      ..moveTo(size.width, size.height * 0.6700000)
      ..lineTo(size.width * 0.6800000, size.height * 0.6700000)
      ..cubicTo(
        size.width * 0.5805890,
        size.height * 0.6700000,
        size.width * 0.5000000,
        size.height * 0.7505890,
        size.width * 0.5000000,
        size.height * 0.8500000,
      )
      ..lineTo(size.width * 0.5000000, size.height * 0.6800000)
      ..cubicTo(
        size.width * 0.5000000,
        size.height * 0.5805890,
        size.width * 0.5805890,
        size.height * 0.5000000,
        size.width * 0.6800000,
        size.height * 0.5000000,
      )
      ..lineTo(size.width, size.height * 0.5000000)
      ..lineTo(size.width, size.height * 0.6700000)
      ..close();

    var paint1Fill = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xff8889B6).withOpacity(1);
    canvas.drawPath(path_1, paint1Fill);

    var path_2 = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height * 0.5000000)
      ..lineTo(size.width * 0.6800000, size.height * 0.5000000)
      ..cubicTo(
        size.width * 0.5805890,
        size.height * 0.5000000,
        size.width * 0.5000000,
        size.height * 0.5805890,
        size.width * 0.5000000,
        size.height * 0.6800000,
      )
      ..lineTo(size.width * 0.5000000, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, 0)
      ..close();

    var paint2Fill = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xffF8F4FF).withOpacity(1);
    canvas.drawPath(path_2, paint2Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class DownWallCP extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint0Fill = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xffF8F4FF);
    canvas.drawRect(
      Rect.fromLTWH(
        0,
        size.height * 0.5000000,
        size.width,
        size.height * 0.5000000,
      ),
      paint0Fill,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class DownLeftInAngleCP extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var path_0 = Path()
      ..moveTo(0, size.height)
      ..lineTo(0, 0)
      ..lineTo(size.width * 0.5000000, 0)
      ..lineTo(size.width * 0.5000000, size.height * 0.3200000)
      ..cubicTo(
        size.width * 0.5000000,
        size.height * 0.4194110,
        size.width * 0.5805890,
        size.height * 0.5000000,
        size.width * 0.6800000,
        size.height * 0.5000000,
      )
      ..lineTo(size.width, size.height * 0.5000000)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    var paint0Fill = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xffF8F4FF).withOpacity(1);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class DownRightOutAngleCP extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.5000000, size.height);
    path_0.lineTo(size.width * 0.5000000, size.height * 0.6800000);
    path_0.cubicTo(
      size.width * 0.5000000,
      size.height * 0.5805890,
      size.width * 0.5805890,
      size.height * 0.5000000,
      size.width * 0.6800000,
      size.height * 0.5000000,
    );
    path_0.lineTo(size.width, size.height * 0.5000000);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(size.width * 0.5000000, size.height);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = Color(0xffF8F4FF).withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class BlockCP extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = Color(0xffF8F4FF);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

@Deprecated('Use class LeftBridgeWotShadow + LeftBridgesShadow')
class LeftBridgeCP extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width, size.height * 0.8200000);
    path_0.lineTo(size.width * 0.6800000, size.height * 0.8200000);
    path_0.cubicTo(
      size.width * 0.5805890,
      size.height * 0.8200000,
      size.width * 0.5000000,
      size.height * 0.9005890,
      size.width * 0.5000000,
      size.height,
    );
    path_0.lineTo(size.width * 0.5000000, size.height * 0.8300000);
    path_0.cubicTo(
      size.width * 0.5000010,
      size.height * 0.7305900,
      size.width * 0.5805900,
      size.height * 0.6500000,
      size.width * 0.6800000,
      size.height * 0.6500000,
    );
    path_0.lineTo(size.width, size.height * 0.6500000);
    path_0.lineTo(size.width, size.height * 0.8200000);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = Colors.black.withOpacity(0.2);
    canvas.drawPath(path_0, paint0Fill);

    Path path_1 = Path();
    path_1.moveTo(size.width, size.height * 0.6700000);
    path_1.lineTo(size.width * 0.6800000, size.height * 0.6700000);
    path_1.cubicTo(
      size.width * 0.5805890,
      size.height * 0.6700000,
      size.width * 0.5000000,
      size.height * 0.7505890,
      size.width * 0.5000000,
      size.height * 0.8500000,
    );
    path_1.lineTo(size.width * 0.5000000, size.height * 0.6800000);
    path_1.cubicTo(
      size.width * 0.5000000,
      size.height * 0.5805890,
      size.width * 0.5805890,
      size.height * 0.5000000,
      size.width * 0.6800000,
      size.height * 0.5000000,
    );
    path_1.lineTo(size.width, size.height * 0.5000000);
    path_1.lineTo(size.width, size.height * 0.6700000);
    path_1.close();

    Paint paint1Fill = Paint()..style = PaintingStyle.fill;
    paint1Fill.color = Color(0xff8889B6).withOpacity(1.0);
    canvas.drawPath(path_1, paint1Fill);

    Path path_2 = Path();
    path_2.moveTo(size.width, size.height * 0.5000000);
    path_2.lineTo(size.width * 0.6800000, size.height * 0.5000000);
    path_2.cubicTo(
      size.width * 0.5805890,
      size.height * 0.5000000,
      size.width * 0.5000000,
      size.height * 0.5805890,
      size.width * 0.5000000,
      size.height * 0.6800000,
    );
    path_2.lineTo(size.width * 0.5000000, size.height);
    path_2.lineTo(0, size.height);
    path_2.lineTo(0, size.height * 0.5000000);
    path_2.lineTo(size.width * 0.3200000, size.height * 0.5000000);
    path_2.cubicTo(
      size.width * 0.4194110,
      size.height * 0.5000000,
      size.width * 0.5000000,
      size.height * 0.4194110,
      size.width * 0.5000000,
      size.height * 0.3200000,
    );
    path_2.lineTo(size.width * 0.5000000, 0);
    path_2.lineTo(size.width, 0);
    path_2.lineTo(size.width, size.height * 0.5000000);
    path_2.close();

    Paint paint2Fill = Paint()..style = PaintingStyle.fill;
    paint2Fill.color = Color(0xffF8F4FF).withOpacity(1.0);
    canvas.drawPath(path_2, paint2Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class LeftBridgeWOTShadowCP extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width, size.height * 0.6700000);
    path_0.lineTo(size.width * 0.6800000, size.height * 0.6700000);
    path_0.cubicTo(
      size.width * 0.5805890,
      size.height * 0.6700000,
      size.width * 0.5000000,
      size.height * 0.7505890,
      size.width * 0.5000000,
      size.height * 0.8500000,
    );
    path_0.lineTo(size.width * 0.5000000, size.height * 0.6800000);
    path_0.cubicTo(
      size.width * 0.5000000,
      size.height * 0.5805890,
      size.width * 0.5805890,
      size.height * 0.5000000,
      size.width * 0.6800000,
      size.height * 0.5000000,
    );
    path_0.lineTo(size.width, size.height * 0.5000000);
    path_0.lineTo(size.width, size.height * 0.6700000);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = Color(0xff8889B6).withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);

    Path path_1 = Path();
    path_1.moveTo(size.width, size.height * 0.5000000);
    path_1.lineTo(size.width * 0.6800000, size.height * 0.5000000);
    path_1.cubicTo(
      size.width * 0.5805890,
      size.height * 0.5000000,
      size.width * 0.5000000,
      size.height * 0.5805890,
      size.width * 0.5000000,
      size.height * 0.6800000,
    );
    path_1.lineTo(size.width * 0.5000000, size.height);
    path_1.lineTo(0, size.height);
    path_1.lineTo(0, size.height * 0.5000000);
    path_1.lineTo(size.width * 0.3200000, size.height * 0.5000000);
    path_1.cubicTo(
      size.width * 0.4194110,
      size.height * 0.5000000,
      size.width * 0.5000000,
      size.height * 0.4194110,
      size.width * 0.5000000,
      size.height * 0.3200000,
    );
    path_1.lineTo(size.width * 0.5000000, 0);
    path_1.lineTo(size.width, 0);
    path_1.lineTo(size.width, size.height * 0.5000000);
    path_1.close();

    Paint paint1Fill = Paint()..style = PaintingStyle.fill;
    paint1Fill.color = Color(0xffF8F4FF).withOpacity(1.0);
    canvas.drawPath(path_1, paint1Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class LeftBridgesShadow extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width, size.height * 0.8200000);
    path_0.lineTo(size.width * 0.6800000, size.height * 0.8200000);
    path_0.cubicTo(
      size.width * 0.5805890,
      size.height * 0.8200000,
      size.width * 0.5000000,
      size.height * 0.9005890,
      size.width * 0.5000000,
      size.height,
    );
    path_0.lineTo(size.width * 0.5000000, size.height * 0.8300000);
    path_0.cubicTo(
      size.width * 0.5000010,
      size.height * 0.7305900,
      size.width * 0.5805900,
      size.height * 0.6500000,
      size.width * 0.6800000,
      size.height * 0.6500000,
    );
    path_0.lineTo(size.width, size.height * 0.6500000);
    path_0.lineTo(size.width, size.height * 0.8200000);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = Colors.black.withOpacity(0.2);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

// Painter для сетки
class GridPainter extends CustomPainter {
  final int gridWidth;
  final int gridHeight;
  final double cellSize;

  const GridPainter({
    required this.gridWidth,
    required this.gridHeight,
    required this.cellSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xff3D2F6B)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Вертикальные линии
    for (int i = 0; i <= gridWidth; i++) {
      final x = i * cellSize;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Горизонтальные линии
    for (int i = 0; i <= gridHeight; i++) {
      final y = i * cellSize;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
