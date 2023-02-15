import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:qlutter/app/domain/app_api.dart';
import 'package:qlutter/app/domain/app_config.dart';
import 'package:qlutter/feature/auth/data/auth_interceptor.dart';
// import 'package:otus_food_app/feature/favorite/data/dto/favorite_dto.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@Singleton(as: AppApi)
class DioAppApi implements AppApi {
  late final Dio dio;

  DioAppApi(AppConfig appConfig) {
    final options = BaseOptions(
      baseUrl: appConfig.baseUrl,
      connectTimeout: 15000,
    );

    dio = Dio(options);
    if (kDebugMode) addInterceptor(PrettyDioLogger());

    addInterceptor(AuthInterceptor());
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
  Future<Response> getProfile() {
    try {
      return dio.get("/user");
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Response> passwordUpdate(
      {required String? oldPassword, required String? newPassword}) {
    try {
      return dio.put(
        "/user",
        queryParameters: {
          "oldPassword": oldPassword,
          "newPassword": newPassword
        },
      );
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Response> refreshToken({String? refreshToken}) {
    try {
      return dio.post(
        "/token/$refreshToken",
      );
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Response> singIn({required String password, required String login}) {
    try {
      return dio
          .post("/token", data: {"username": login, "password": password});
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Response> singUp(
      {required String password,
      required String login,
      required String email}) {
    try {
      return dio.put(
        "/token",
        data: {
          "username": login,
          "password": password,
          "email": email,
        },
      );
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Response> userUpdate({String? login, String? email}) {
    try {
      return dio.post(
        "/user",
        data: {
          "username": login,
          "email": email,
        },
      );
    } catch (_) {
      rethrow;
    }
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
}
