import 'package:qlutter/ver_1/app/domain/app_builder.dart';

abstract class AppRunner {
  Future<void> preloaderData();

  Future<void> run(AppBuilder appBuilder);
}
