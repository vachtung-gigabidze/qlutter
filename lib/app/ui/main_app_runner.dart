import 'package:flutter/material.dart';
import 'package:qlutter/app/di/init_di.dart';
import 'package:qlutter/app/domain/app_builder.dart';
import 'package:qlutter/app/domain/app_runner.dart';
import 'package:path_provider/path_provider.dart';

class MainAppRunner implements AppRunner {
  final String env;

  const MainAppRunner(this.env);

  @override
  Future<void> preloaderData() async {
    // init app
    initDi(env);
    // init config
  }

  @override
  Future<void> run(AppBuilder appBuilder) async {
    // final storage = await HydratedStorage.build(
    //     storageDirectory: await getApplicationDocumentsDirectory());
    // HydratedBlocOverrides.runZoned(
    //   () async {
    await preloaderData();
    //WidgetsFlutterBinding.ensureInitialized();
    runApp(appBuilder.buildApp());
    //   },
    //   storage: storage,
    // );
  }
}
