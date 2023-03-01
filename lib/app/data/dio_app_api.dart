import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:qlutter/app/domain/app_api.dart';
import 'package:qlutter/app/domain/app_config.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@Singleton(as: AppApi)
class DioAppApi implements AppApi {
  late final Dio dio;

  DioAppApi(AppConfig appConfig) {
    final options = BaseOptions(
      baseUrl: appConfig.baseUrl,
      connectTimeout: 15000,
      // headers: {
      //   "Accept": "application/json",
      //   "Access-Control_Allow_Origin": "*"
      // }
    );

    dio = Dio(options);
    if (kDebugMode) addInterceptor(PrettyDioLogger());
  }

  void addInterceptor(Interceptor interceptor) {
    if (dio.interceptors.contains(interceptor)) {
      dio.interceptors.remove(interceptor);
    }

    deleteInterceptor(interceptor.runtimeType);

    dio.interceptors.add(interceptor);
  }

  void deleteInterceptor(Type type) {
    dio.interceptors.removeWhere((element) => element.runtimeType == type);
  }

  @override
  Future<Response> request(String path) {
    try {
      return dio.request(path);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Response> fetch(RequestOptions requestOptions) {
    try {
      return dio.fetch(requestOptions);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Response> getLevel() {
    try {
      return dio.get("/levels");
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Response> sendProcess(
      {int? levelId, int? steps, int? seconds, DateTime? dateTime}) {
    try {
      return dio.post(
        "/progress",
        data: {
          "levelId": levelId,
          "steps": steps,
          "seconds": seconds,
          "datetime": dateTime.toString()
        },
      );
    } catch (_) {
      rethrow;
    }
  }
}
