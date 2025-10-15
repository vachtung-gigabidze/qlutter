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
                          painter: TopWallCP(),
                        ),
                        Text("TopWallCP", style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    Row(
                      children: [
                        CustomPaint(
                          size: Size(50, (50 * 1).toDouble()),
                          painter: LeftWallCP(),
                        ),
                        Text("LeftWallCP", style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    Row(
                      children: [
                        CustomPaint(
                          size: Size(50, (50 * 1).toDouble()),
                          painter: TopLeftOutAngleCP(),
                        ),
                        Text(
                          "TopLeftOutAngleCP",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CustomPaint(
                          size: Size(50, (50 * 1).toDouble()),
                          painter: TopLeftInAngleCP(),
                        ),
                        Text(
                          "TopLeftInAngleCP",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        CustomPaint(
                          size: Size(50, (50 * 1).toDouble()),
                          painter: DownLeftInAngleCP(),
                        ),
                        Text(
                          "DownLeftInAngleCP",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CustomPaint(
                          size: Size(50, (50 * 1).toDouble()),
                          painter: DownRightOutAngleCP(),
                        ),
                        Text(
                          "DownRightOutAngleCP",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CustomPaint(
                          size: Size(50, (50 * 1).toDouble()),
                          painter: DownWallCP(),
                        ),
                        Text("DownWallCP", style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 700, width: 700, child: const PlayGround()),
            ],
          ),
        ),
      ),
    ),
  );
}
