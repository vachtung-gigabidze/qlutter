// import 'package:qlutter/fox_render_box/example_app_runner.dart';

// import 'dart:async';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart'
//     as material
//     show runApp, WidgetsFlutterBinding;
import 'package:flutter/material.dart';
import 'package:qlutter/ver_2/app.dart';
import 'package:qlutter/ver_2/game/level_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализируем менеджер уровней
  await LevelManager().initialize();

  runApp(const QookApp());
}







//import 'package:qlutter/fox_render_box/example_app_runner.dart';

// import 'package:ui/ui.dart';

// void main() {
//   //const runner = ExampleAppRunner();
//   //runner.run();
//   runZonedGuarded<void>(
//     () async {
//       //init
//       final binding = material.WidgetsFlutterBinding.ensureInitialized()
//         ..deferFirstFrame();

//       PlatformDispatcher.instance.onError = (error, stackTrace) {
//         print(error.toString());
//         return true;
//       };

//       //init deps //share pref , database  //Без запросов в сеть

//       material.runApp(const PlayGround());
//     },
//     zoneSpecification: ZoneSpecification(print: (self, parent, zone, line) {}),
//     (error, stack) {},
//   );
// }





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
