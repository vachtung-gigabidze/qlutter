import 'package:flutter/material.dart';
import 'package:qlutter/ver_1/app/domain/app_builder.dart';
import 'package:qlutter/ver_1/app/domain/app_runner.dart';
import 'package:qlutter/ver_1/i18n/strings.g.dart';

class MainAppRunner implements AppRunner {
  const MainAppRunner(this.env);
  final String env;

  @override
  Future<void> preloaderData() async {
    // init app
    // initDi(env);
    // init config
  }

  @override
  Future<void> run(AppBuilder appBuilder) async {
    // HydratedBloc.storage = await HydratedStorage.build(
    //   storageDirectory: kIsWeb
    //       ? HydratedStorage.webStorageDirectory
    //       : await getTemporaryDirectory(),
    // );

    //HydratedBlocOverrides.runZoned(
    // () async {
    await preloaderData();
    //WidgetsFlutterBinding.ensureInitialized();
    LocaleSettings.useDeviceLocale();
    // LocaleSettings.setLocale(AppLocale.values.last);

    runApp(TranslationProvider(child: await appBuilder.buildApp()));
    // },
    //   storage: storage,
    // );
  }
}
