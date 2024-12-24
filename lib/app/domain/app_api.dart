// import 'package:dio/dio.dart';

abstract class AppApi {
  Future<dynamic> request(String path);

  Future<dynamic> getLevel();

  Future<dynamic> getProgress();

  Future<dynamic> getBestRecords();

  Future<dynamic> sendProcess({
    int? levelId,
    int? steps,
    int? seconds,
    DateTime? dateTime,
  });

  // Future<dynamic> fetch(RequestOptions requestOptions);
}
