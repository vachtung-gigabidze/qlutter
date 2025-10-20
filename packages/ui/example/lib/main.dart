library;

import 'package:flutter/material.dart';

import 'package:ui/ui.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
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

              SizedBox(height: 800, width: 800, child: HomePage()),
            ],
          ),
        ),
      ),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wall System')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PlayGround(
                      h: 10,
                      w: 10,
                      elementSize: 50,
                      levelId: 4,
                    ),
                  ),
                );
              },
              child: const Text('Просмотр поля'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MapEditor()),
                );
              },
              child: const Text('Редактор карт'),
            ),
          ],
        ),
      ),
    );
  }
}
