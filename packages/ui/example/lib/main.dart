library;

import 'package:flutter/material.dart';

import 'package:ui/ui.dart';

void main() {
  runApp(
    MaterialApp(
      home: ColoredBox(
        color: Color(0xffF8F4FF),
        child: Center(
          child: Row(
            children: [
              Container(
                color: Colors.blue,
                child: Column(
                  children: [
                    Row(
                      children: [
                        CustomPaint(
                          size: Size(50, (50 * 1).toDouble()),
                          painter: TopWallCustomPainter(),
                        ),
                        Text(
                          "TopWallCustomPainter",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CustomPaint(
                          size: Size(50, (50 * 1).toDouble()),
                          painter: WallCustomPainter(),
                        ),
                        Text(
                          "WallCustomPainter",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CustomPaint(
                          size: Size(50, (50 * 1).toDouble()),
                          painter: TopLeftOutAngleCustomPainter(),
                        ),
                        Text(
                          "TopLeftOutAngleCustomPainter",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CustomPaint(
                          size: Size(50, (50 * 1).toDouble()),
                          painter: TopLeftInAngleCustomPainter(),
                        ),
                        Text(
                          "TopLeftInAngleCustomPainter",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        CustomPaint(
                          size: Size(50, (50 * 1).toDouble()),
                          painter: BottomLeftInAngleCustomPainter(),
                        ),
                        Text(
                          "BottomLeftInAngleCustomPainter",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CustomPaint(
                          size: Size(50, (50 * 1).toDouble()),
                          painter: BottomRightOutAngleCustomPainter(),
                        ),
                        Text(
                          "BottomRightOutAngleCustomPainter",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CustomPaint(
                          size: Size(50, (50 * 1).toDouble()),
                          painter: BottomWallCustomPainter(),
                        ),
                        Text(
                          "BottomWallCustomPainter",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 600, width: 600, child: const PlayGround()),
            ],
          ),
        ),
      ),
    ),
  );
}
