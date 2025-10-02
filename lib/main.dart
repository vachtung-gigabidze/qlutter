// import 'package:qlutter/fox_render_box/example_app_runner.dart';

import 'package:flutter/material.dart';
//import 'package:qlutter/fox_render_box/example_app_runner.dart';

import 'package:qlutter/game/painter/wall_painter.dart';

const double sizeWall = 120;

void main() {
  //const runner = ExampleAppRunner();
  //runner.run();
  runApp(
    MaterialApp(
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
    ),
  );
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
        scaleX: -1,
      ),
      DrawWallWidget(wall: LeftWallCustomPainter(), x: 0, y: 2),
      DrawWallWidget(wall: LeftWallCustomPainter(), x: 4, y: 2, scaleX: -1),
      DrawWallWidget(wall: LeftWallCustomPainter(), x: 0, y: 3),
      DrawWallWidget(wall: LeftWallCustomPainter(), x: 4, y: 3, scaleX: -1),
      DrawWallWidget(wall: LeftWallCustomPainter(), x: 0, y: 4),
      DrawWallWidget(wall: LeftWallCustomPainter(), x: 4, y: 4, scaleX: -1),

      DrawWallWidget(wall: BottomInAngleCustomPainter(), x: 0, y: 5),
      DrawWallWidget(wall: LeftWallCustomPainter(), x: 1, y: 5, rotate: 3),
      DrawWallWidget(wall: LeftWallCustomPainter(), x: 2, y: 5, rotate: 3),
      DrawWallWidget(wall: LeftWallCustomPainter(), x: 3, y: 5, rotate: 3),
      DrawWallWidget(
        wall: BottomInAngleCustomPainter(),
        x: 4,
        y: 5,
        scaleX: -1,
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
    this.scaleX = 1,
    this.rotate = 0,
  });
  final CustomPainter wall;
  final int x;
  final int y;
  final double scaleX;
  final int rotate;

  @override
  Widget build(BuildContext context) => Positioned(
    top: y * sizeWall,
    left: x * sizeWall,
    child: Transform.scale(
      scaleX: scaleX,
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



// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:logging/logging.dart';
// import 'package:qlutter/app/ui/main_app_builder.dart';
// import 'package:qlutter/app/ui/main_app_runner.dart';




//void main() {
 // runApp(MaterialApp(home:  StepperRenderObject(steps: <StepData>[]]));
  //   guardedMain();
  //   const env = String.fromEnvironment("env", defaultValue: "prod");
  //   const runner = MainAppRunner(env);
  //   final builder = MainAppBuilder();
  //   runner.run(builder);
  // }

  // Logger _log = Logger('main.dart');

  // void guardedMain() {
  //   if (kReleaseMode) {
  //     // Don't log anything below warnings in production.
  //     Logger.root.level = Level.WARNING;
  //   }
  //   Logger.root.onRecord.listen((record) {
  //     debugPrint('${record.level.name}: ${record.time}: '
  //         '${record.loggerName}: '
  //         '${record.message}');
  //   });

  //   WidgetsFlutterBinding.ensureInitialized();

  //   _log.info('Going full screen');
  //   SystemChrome.setEnabledSystemUIMode(
  //     SystemUiMode.edgeToEdge,
  //   );
//}
