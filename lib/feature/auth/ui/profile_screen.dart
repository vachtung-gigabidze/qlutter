import 'package:flutter/material.dart';
// import 'package:qlutter/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:qlutter/app/ui/components/app_snackbar.dart';
import 'package:qlutter/app/ui/components/app_text_button.dart';
import 'package:qlutter/app/ui/components/app_text_field.dart';
import 'package:qlutter/app/domain/error_entity/error_entity.dart';
import 'package:qlutter/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:qlutter/feature/auth/domain/entities/user_entity/user_entity.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UserEntity? userEntity = context.read<AuthCubit>().state.maybeWhen(
          authorized: (userEntity) => userEntity,
          orElse: () => null,
        );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => context.read<AuthCubit>().getProfile(),
              icon: const Icon(Icons.refresh)),
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const _UserUpdateDialog(),
                );
              },
              icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const _UserUpdatePasswordDialog(),
                );
              },
              icon: const Icon(Icons.password)),
        ],
      ),
      backgroundColor: const Color(0xFFC2C2C2),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          state.whenOrNull(
            authorized: (userEntity) {
              if (userEntity.userState?.hasData == true) {
                AppSnackBar.showSnackBarWithMessage(
                    context, userEntity.userState?.data);
              }
              if (userEntity.userState?.hasError == true) {
                AppSnackBar.showSnackBarWithError(context,
                    ErrorEntity.fromException(userEntity.userState?.error));
              }
            },
          );
        },
        builder: (context, state) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 123,
                width: 123,
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF165932),
                    width: 4,
                  ),
                ),
                child: Image.asset(
                  "assets/setting.png",
                  height: 96,
                  width: 96,
                  fit: BoxFit.fitWidth,
                ),
              ),
              const SizedBox(
                height: 29,
              ),
              Container(
                width: 396.0,
                height: 64.0,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Логин',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0,
                          color: Color(0xFF165932),
                        ),
                      ),
                      Text(
                        userEntity?.login ?? "",
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0,
                          color: Color(0xFF165932),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                width: 396.0,
                height: 64.0,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: Center(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                        fontFamily: 'Roboto',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                        color: Color(0xFFF54848),
                      ),
                    ),
                    onPressed: () {
                      context.read<AuthCubit>().logOut();
                    },
                    child: const Text('Выход'),
                  ),
                ),
              ),
              const SizedBox(
                height: 29,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserUpdateDialog extends StatefulWidget {
  const _UserUpdateDialog();

  @override
  State<_UserUpdateDialog> createState() => __UserUpdateDialogState();
}

class __UserUpdateDialogState extends State<_UserUpdateDialog> {
  final emailController = TextEditingController();
  final loginController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    loginController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            AppTextField(controller: loginController, labelText: "Логин"),
            const SizedBox(
              height: 16,
            ),
            AppTextField(
                controller: emailController,
                labelText: "email",
                icon: Icons.email),
            const SizedBox(
              height: 16,
            ),
            AppTextButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.read<AuthCubit>().userUpdate(
                        email: emailController.text,
                        login: loginController.text,
                      );
                },
                text: "Сохранить")
          ],
        ),
      ),
    ]);
  }
}

class _UserUpdatePasswordDialog extends StatefulWidget {
  const _UserUpdatePasswordDialog();

  @override
  State<_UserUpdatePasswordDialog> createState() =>
      __UserUpdatePasswordDialogState();
}

class __UserUpdatePasswordDialogState extends State<_UserUpdatePasswordDialog> {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  // final newPasswordConfirmController = TextEditingController();

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    // newPasswordConfirmController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            AppTextField(
              controller: oldPasswordController,
              labelText: "Старый пароль",
              icon: Icons.lock,
            ),
            const SizedBox(
              height: 16,
            ),
            AppTextField(
                controller: newPasswordController,
                labelText: "Новый пароль",
                icon: Icons.lock),
            const SizedBox(
              height: 16,
            ),
            // AppTextField(
            //     controller: newPasswordConfirmController,
            //     labelText: "Повторите пароль",
            //     iconName: Constants.lockIcon),
            // const SizedBox(
            //   height: 16,
            // ),
            AppTextButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.read<AuthCubit>().passwordUpdate(
                      oldPassword: oldPasswordController.text,
                      newPassword: newPasswordController.text);
                },
                text: "Сохранить")
          ],
        ),
      ),
    ]);
  }
}
