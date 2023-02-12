import 'package:injectable/injectable.dart';
import 'package:qlutter/app/domain/app_config.dart';

@Singleton(as: AppConfig)
// @prod
class ProdAppConfig implements AppConfig {
  @override
  String get baseUrl =>
      "https://dart.nvavia.ru"; //"http://172.20.20.4:8888"; //

  @override
  String get host => Environment.prod;
}

// @Singleton(as: AppConfig)
// @dev
// class DevAppConfig implements AppConfig {
//   @override
//   String get baseUrl => "http://172.20.20.4:8888";

//   @override
//   String get host => Environment.dev;
// }

// @Singleton(as: AppConfig)
// @test
// class TestAppConfig implements AppConfig {
//   @override
//   String get baseUrl => "_";

//   @override
//   String get host => Environment.test;
// }
