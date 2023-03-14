import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:qlutter/feature/settings/information_dialog.dart';
import 'package:rive/rive.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Palette palette = context.watch<Palette>();

    return Scaffold(
      backgroundColor: palette.backgroundMain,
      body: ResponsiveScreen(
        mainAreaProminence: 0.45,
        squarishMainArea: Stack(children: [
          const RiveAnimation.asset("assets/rive/balls.riv"),
          Positioned.fill(
              child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: const SizedBox(),
          )),
          Center(
            child: Transform.rotate(
              angle: -0.1,
              child: Text(
                'Qlutter',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: palette.fontMain,
                  fontSize: 100,
                ),
              ),
            ),
          ),
        ]),
        rectangularMenuArea: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).go('/play');
              },
              child: Text(
                'Уровни',
                style: TextStyle(
                  fontFamily: palette.fontMain,
                  fontSize: 32,
                  color: palette.ink,
                ),
              ),
            ),
            _gap,
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).go('/progress');
              },
              child: Text(
                'Рекорды',
                style: TextStyle(
                  fontFamily: palette.fontMain,
                  fontSize: 32,
                  color: palette.ink,
                ),
              ),
            ),
            _gap,
            IconButton(
              onPressed: () {
                showInformationDialog(context);
              },
              icon: const Icon(Icons.info_outline, size: 34),
            ),
            _gap,
          ],
        ),
      ),
    );
  }

  static const _gap = SizedBox(height: 10);
}
