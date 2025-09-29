import 'package:flutter/material.dart';
import 'package:qlutter/render/models/step_data.dart';

import 'render/widgets/custom_stepper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Custom Stepper')),
        body: const StepperExample(),
      ),
    );
  }
}

class StepperExample extends StatelessWidget {
  const StepperExample({super.key});

  @override
  Widget build(BuildContext context) {
    final steps = [
      const StepData(title: 'Step 1', subtitle: 'Description 1'),
      const StepData(
        title: 'Step 2',
        subtitle: 'Description 2 with longer text',
      ),
      const StepData(title: 'Step 3', subtitle: 'Description 3'),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: CustomStepper(
        steps: steps,
        onStepTap: (step) {
          print('Tapped on: ${step.title}');
        },
      ),
    );
  }
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
