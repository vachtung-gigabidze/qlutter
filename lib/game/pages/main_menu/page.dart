import 'dart:ui';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:qlutter/app/ui/components/components.dart';
import 'package:qlutter/i18n/strings.g.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Palette palette = context.watch<Palette>();
    final t = Translations.of(context);

    return ThemeSwitchingArea(
      child: Scaffold(
        //backgroundColor: palette.backgroundMain,
        body: AppResponsiveScreen(
          mainAreaProminence: 0.45,
          squarishMainArea: Stack(
            children: [
              Positioned.fill(child: Image.asset('assets/icon/qlutter.png')),
              Stack(
                children: [
                  //const RiveAnimation.asset("assets/rive/balls.riv"),
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                      child: const SizedBox(),
                    ),
                  ),
                  Center(
                    child: Transform.rotate(
                      angle: -0.1,
                      child: const Text(
                        'Qlutter',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 100),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          rectangularMenuArea: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).go('/play');
                },
                child: Text(
                  t.main.play,
                  style: TextStyle(fontFamily: palette.fontMain, fontSize: 32),
                ),
              ),

              _gap,
              ElevatedButton(
                onPressed: () {
                  context.push('/settings');
                },
                child: Text(
                  t.main.setting,
                  style: TextStyle(fontFamily: palette.fontMain, fontSize: 32),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static const _gap = SizedBox(height: 10);
}
