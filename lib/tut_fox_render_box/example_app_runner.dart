import 'package:flutter/material.dart';
import 'package:qlutter/tut_fox_render_box/widgets/custom_stepper.dart';

class ExampleAppRunner {
  const ExampleAppRunner();

  Future<void> run() async {
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('Custom Stepper')),
      body: const StepperExample(),
    ),
  );
}

class StepperExample extends StatelessWidget {
  const StepperExample({super.key});

  @override
  Widget build(BuildContext context) {
    final steps = [
      (title: 'Step 1', subtitle: 'Description 1'),
      (title: 'Step 2', subtitle: 'Description 2 with longer text'),
      (title: 'Step 3', subtitle: 'Description 3'),
      (title: 'Step 4', subtitle: 'Description 4'),
      (title: 'Step 5', subtitle: 'Description 5'),
      (title: 'Step 6', subtitle: 'Description 6 with longer text'),
      (title: 'Step 7', subtitle: 'Description 7'),
      (title: 'Step 8', subtitle: 'Description 8'),
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
