// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
// import 'package:qlutter/game/core/domain/error_entity/error_entity.dart';
import 'package:qlutter/feature/auth/domain/auth_repository.dart';
import 'package:qlutter/feature/auth/domain/entities/user_entity/user_entity.dart';
import 'package:qlutter/feature/auth/domain/auth_repository.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';
part 'auth_cubit.g.dart';

@Singleton()
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(AuthState.notAuthorized());

  final AuthRepository authRepository;

  Future<void> singIn({required String login, required String password}) async {
    emit(AuthState.waiting());
    try {
      final UserEntity userEntity =
          await authRepository.singIn(password: password, login: login);
      emit(AuthState.authorized(userEntity));
    } catch (error, st) {
      addError(error, st);
    }
  }

  Future<void> singUp({
    required String login,
    required String password,
    required String email,
  }) async {
    emit(AuthState.waiting());
    try {
      final UserEntity userEntity = await authRepository.singUp(
        password: password,
        login: login,
        email: email,
      );
      emit(AuthState.authorized(userEntity));
    } catch (error, st) {
      addError(error, st);
    }
  }

  Future<void> getProfile() async {
    try {
      _updateUserState(const AsyncSnapshot.waiting());
      final UserEntity newUserEntity = await authRepository.getProfile();

      emit(state.maybeWhen(
        orElse: () => state,
        authorized: (userEntity) => AuthState.authorized(userEntity.copyWith(
          email: newUserEntity.email,
          login: newUserEntity.login,
        )),
      ));
      _updateUserState(const AsyncSnapshot.withData(
          ConnectionState.done, "Успешное получение данных"));
    } catch (error) {
      _updateUserState(AsyncSnapshot.withError(ConnectionState.done, error));
    }
  }

  void _updateUserState(AsyncSnapshot asyncSnapshot) {
    emit(state.maybeWhen(
      orElse: () => state,
      authorized: (userEntity) =>
          AuthState.authorized(userEntity.copyWith(userState: asyncSnapshot)),
    ));
  }

  Future<void> userUpdate({
    String? login,
    String? email,
  }) async {
    try {
      _updateUserState(const AsyncSnapshot.waiting());
      await Future.delayed(const Duration(seconds: 1));
      final bool isEmptyEmail = email?.trim().isEmpty == true;
      final bool isEmptyLogin = login?.trim().isEmpty == true;

      final UserEntity newUserEntity = await authRepository.userUpdate(
        login: isEmptyLogin ? null : login,
        email: isEmptyEmail ? null : email,
      );

      emit(state.maybeWhen(
        orElse: () => state,
        authorized: (userEntity) => AuthState.authorized(userEntity.copyWith(
          email: newUserEntity.email,
          login: newUserEntity.login,
        )),
      ));
      _updateUserState(const AsyncSnapshot.withData(
          ConnectionState.done, "Успешное обновление данных"));
    } catch (error) {
      _updateUserState(AsyncSnapshot.withError(ConnectionState.done, error));
    }
  }

  Future<void> passwordUpdate({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      _updateUserState(const AsyncSnapshot.waiting());
      await Future.delayed(const Duration(seconds: 1));

      if (newPassword.trim().isEmpty == true) {
        // throw ErrorEntity(message: "Новый пароль пустой");
      }

      final message = await authRepository.passwordUpdate(
          oldPassword: oldPassword, newPassword: newPassword);

      _updateUserState(AsyncSnapshot.withData(ConnectionState.done, message));
    } catch (error) {
      _updateUserState(AsyncSnapshot.withError(ConnectionState.done, error));
    }
  }

  Future<void> refreshToken() async {
    final refreshToken =
        state.whenOrNull(authorized: (userEntity) => userEntity.refreshToken);
    try {
      final UserEntity userEntity =
          await authRepository.refreshToken(refreshToken: refreshToken);
      emit(AuthState.authorized(userEntity));
    } catch (error, st) {
      addError(error, st);
    }
  }

  void logOut() => emit(AuthState.notAuthorized());

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    final state = AuthState.fromJson(json);
    return state.whenOrNull(
      authorized: (userEntity) => AuthState.authorized(userEntity),
    );
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return state
            .whenOrNull(
              authorized: (userEntity) => AuthState.authorized(userEntity),
            )
            ?.toJson() ??
        AuthState.notAuthorized().toJson();
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    emit(AuthState.error(error));
    super.addError(error, stackTrace);
  }
}
