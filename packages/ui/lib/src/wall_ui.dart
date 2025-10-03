import 'package:flutter/material.dart';
import 'package:ui/src/wall_painter.dart';

const double sizeWall = 120;

class PlayGround extends StatelessWidget {
  const PlayGround({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ColoredBox(
        color: Colors.white,
        child: SizedBox(
          height: 5 * sizeWall,
          width: 5 * sizeWall,
          child: Container(
            color: const Color(0xFF50427D),
            child: const WallWidget(),
          ),
        ),
      ),
    );
  }
}

class WallWidget extends StatelessWidget {
  const WallWidget({
    super.key, // ignore: unused_element
  });

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      DrawWallWidget(wall: LeftTopInAngleCustomPainter(), x: 0, y: 1),
      DrawWallWidget(wall: TopWallCustomPainter(), x: 1, y: 1),
      DrawWallWidget(wall: TopWallCustomPainter(), x: 2, y: 1),
      DrawWallWidget(wall: TopWallCustomPainter(), x: 3, y: 1),
      DrawWallWidget(
        wall: LeftTopInAngleCustomPainter(),
        x: 4,
        y: 1,
        flipX: true,
      ),
      DrawWallWidget(wall: LeftWallCustomPainter(), x: 0, y: 2),
      DrawWallWidget(wall: LeftWallCustomPainter(), x: 4, y: 2, flipX: true),
      DrawWallWidget(wall: LeftWallCustomPainter(), x: 0, y: 3),
      DrawWallWidget(wall: LeftWallCustomPainter(), x: 4, y: 3, flipX: true),
      DrawWallWidget(wall: LeftWallCustomPainter(), x: 0, y: 4),
      DrawWallWidget(wall: LeftWallCustomPainter(), x: 4, y: 4, flipX: true),

      DrawWallWidget(wall: BottomInAngleCustomPainter(), x: 0, y: 5),
      DrawWallWidget(wall: LeftWallCustomPainter(), x: 1, y: 5, rotate: 3),
      DrawWallWidget(wall: LeftWallCustomPainter(), x: 2, y: 5, rotate: 3),
      DrawWallWidget(wall: LeftWallCustomPainter(), x: 3, y: 5, rotate: 3),
      DrawWallWidget(
        wall: BottomInAngleCustomPainter(),
        x: 4,
        y: 5,
        flipX: true,
      ),
    ],
  );
}

class DrawWallWidget extends StatelessWidget {
  const DrawWallWidget({
    required this.wall,
    required this.x,
    required this.y,
    super.key,
    this.flipX = false,
    this.rotate = 0,
  });
  final CustomPainter wall;
  final int x;
  final int y;
  final bool flipX;
  final int rotate;

  @override
  Widget build(BuildContext context) => Positioned(
    top: y * sizeWall,
    left: x * sizeWall,
    child: Transform.flip(
      flipX: flipX,
      child: RotatedBox(
        quarterTurns: rotate,
        child: SizedBox(
          height: sizeWall,
          width: sizeWall,
          child: CustomPaint(
            size: Size(sizeWall, (sizeWall * 1).toDouble()),
            painter: wall,
          ),
        ),
      ),
    ),
  );
}
