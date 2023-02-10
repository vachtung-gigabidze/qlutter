import 'package:dio/dio.dart';

abstract class AppApi {
  Future<dynamic> singUp({
    required String password,
    required String login,
    required String email,
  });

  Future<dynamic> singIn({
    required String password,
    required String login,
  });

  Future<dynamic> getProfile();

  Future<dynamic> userUpdate({
    String? login,
    String? email,
  });

  Future<dynamic> passwordUpdate({
    required String? oldPassword,
    required String? newPassword,
  });

  Future<dynamic> refreshToken({String? refreshToken});

  Future<dynamic> request(String path);

  Future<dynamic> fetch(RequestOptions requestOptions);
}
