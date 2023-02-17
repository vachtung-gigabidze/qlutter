import 'package:flutter/material.dart';
import 'package:qlutter/app/di/init_di.dart';
import 'package:qlutter/app/ui/components/app_text_button.dart';
import 'package:qlutter/app/ui/components/app_text_field.dart';
import 'package:qlutter/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:qlutter/feature/auth/ui/register_screen.dart';
import 'package:provider/provider.dart';
import 'package:qlutter/feature/style/palette.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});

  final controllerLogin = TextEditingController();
  final controllerPassword = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  void _onTapToSingIn(AuthCubit authCubit) => authCubit.singIn(
      login: controllerLogin.text, password: controllerPassword.text);

  @override
  Widget build(BuildContext context) {
    Palette? palette = locator.get<Palette>();
    final isKeyboardShow = MediaQuery.of(context).viewInsets.bottom != 0;
    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: palette.backgroundAuth,
        body: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!isKeyboardShow)
                      Text(
                        'Qlutter',
                        style: TextStyle(
                          fontFamily: palette.fontMain,
                          fontSize: 30.0,
                          color: palette.ink,
                        ),
                      ),
                    const SizedBox(
                      height: 81,
                    ),
                    AppTextField(
                      controller: controllerLogin,
                      labelText: 'логин',
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    AppTextField(
                      controller: controllerPassword,
                      labelText: 'пароль',
                      obscureText: true,
                      icon: Icons.lock,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                        height: 48,
                        width: 232,
                        child: AppTextButton(
                            backGroundColor: palette.ink,
                            onPressed: () {
                              if (formKey.currentState?.validate() == true) {
                                _onTapToSingIn(context.read<AuthCubit>());
                              }
                            },
                            text: 'Войти')),
                    // if (!isKeyboardShow)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => RegisterScreen()));
                        },
                        child: Text(
                          'Зарегистрироваться',
                          style: TextStyle(
                            fontFamily: palette.fontMain,
                            fontSize: 16,
                            color: palette.ink,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
