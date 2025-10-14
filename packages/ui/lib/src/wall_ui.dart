// import 'package:flutter/material.dart';
// import 'package:ui/src/wall_painter.dart';

// const double sizeWall = 60;

// class PlayGround extends StatelessWidget {
//   const PlayGround({super.key, this.elementSize = sizeWall});

//   final double elementSize;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 5 * elementSize,
//       width: 5 * elementSize,
//       child: Container(
//         color: const Color(0xFF50427D),
//         child: WallWidget(elementSize: elementSize),
//       ),
//     );
//   }
// }

// class WallWidget extends StatelessWidget {
//   const WallWidget({
//     super.key, // ignore: unused_element
//     required this.elementSize,
//   });
//   final double elementSize;
//   @override
//   Widget build(BuildContext context) => Stack(
//     children: [
//       DrawWallWidget(
//         wall: LeftTopInAngleCustomPainter(),
//         x: 0,
//         y: 0,
//         elementSize: elementSize,
//       ),
//       DrawWallWidget(
//         wall: TopWallCustomPainter(),
//         x: 1,
//         y: 0,
//         elementSize: elementSize,
//       ),
//       DrawWallWidget(
//         wall: TopWallCustomPainter(),
//         x: 2,
//         y: 0,
//         elementSize: elementSize,
//       ),
//       DrawWallWidget(
//         wall: TopWallCustomPainter(),
//         x: 3,
//         y: 0,
//         elementSize: elementSize,
//       ),
//       DrawWallWidget(
//         wall: LeftTopInAngleCustomPainter(),
//         x: 4,
//         y: 0,
//         flipX: true,
//         elementSize: elementSize,
//       ),
//       DrawWallWidget(
//         wall: LeftWallCustomPainter(),
//         x: 0,
//         y: 1,
//         elementSize: elementSize,
//       ),
//       DrawWallWidget(
//         wall: LeftWallCustomPainter(),
//         x: 4,
//         y: 1,
//         flipX: true,
//         elementSize: elementSize,
//       ),
//       DrawWallWidget(
//         wall: LeftWallCustomPainter(),
//         x: 0,
//         y: 2,
//         elementSize: elementSize,
//       ),
//       DrawWallWidget(
//         wall: LeftWallCustomPainter(),
//         x: 4,
//         y: 2,
//         flipX: true,
//         elementSize: elementSize,
//       ),
//       DrawWallWidget(
//         wall: LeftWallCustomPainter(),
//         x: 0,
//         y: 3,
//         elementSize: elementSize,
//       ),
//       DrawWallWidget(
//         wall: LeftWallCustomPainter(),
//         x: 4,
//         y: 3,
//         flipX: true,
//         elementSize: elementSize,
//       ),

//       DrawWallWidget(
//         wall: BottomInAngleCustomPainter(),
//         x: 0,
//         y: 4,
//         elementSize: elementSize,
//       ),
//       DrawWallWidget(
//         wall: LeftWallCustomPainter(),
//         x: 1,
//         y: 4,
//         rotate: 3,
//         elementSize: elementSize,
//       ),
//       DrawWallWidget(
//         wall: LeftWallCustomPainter(),
//         x: 2,
//         y: 4,
//         rotate: 3,
//         elementSize: elementSize,
//       ),
//       DrawWallWidget(
//         wall: LeftWallCustomPainter(),
//         x: 3,
//         y: 4,
//         rotate: 3,
//         elementSize: elementSize,
//       ),
//       DrawWallWidget(
//         wall: BottomInAngleCustomPainter(),
//         x: 4,
//         y: 4,
//         flipX: true,
//         elementSize: elementSize,
//       ),
//     ],
//   );
// }

// class DrawWallWidget extends StatelessWidget {
//   const DrawWallWidget({
//     required this.wall,
//     required this.x,
//     required this.y,
//     super.key,
//     this.flipX = false,
//     this.rotate = 0,
//     required this.elementSize,
//   });
//   final CustomPainter wall;
//   final int x;
//   final int y;
//   final bool flipX;
//   final int rotate;
//   final double elementSize;

//   @override
//   Widget build(BuildContext context) => Positioned(
//     top: y * elementSize,
//     left: x * elementSize,
//     child: Transform.flip(
//       flipX: flipX,
//       child: RotatedBox(
//         quarterTurns: rotate,
//         child: SizedBox(
//           height: elementSize,
//           width: elementSize,
//           child: CustomPaint(
//             size: Size(elementSize, (elementSize * 1).toDouble()),
//             painter: wall,
//           ),
//         ),
//       ),
//     ),
//   );
// }
