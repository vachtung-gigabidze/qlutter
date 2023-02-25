// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
// import 'package:qlutter/feature/auth/domain/auth_state/auth_cubit.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
// import '../games_services/games_services.dart';
import '../settings/settings.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Palette palette = context.watch<Palette>();
    // final gamesServicesController = context.watch<GamesServicesController?>();
    // final auth = context.watch<AuthState>();
    final settingsController = context.watch<SettingsController>();
    final audioController = context.watch<AudioController>();

    return Scaffold(
      backgroundColor: palette.backgroundMain,
      body: ResponsiveScreen(
        mainAreaProminence: 0.45,
        squarishMainArea: Center(
          child: Transform.rotate(
            angle: -0.1,
            child: Text(
              'Qlutter',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: palette.fontMain,
                fontSize: 100,
                //height: 1,
              ),
            ),
          ),
        ),
        rectangularMenuArea: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                audioController.playSfx(SfxType.buttonTap);
                GoRouter.of(context).go('/play');
              },
              child: Text(
                'Игра',
                style: TextStyle(
                  fontFamily: palette.fontMain,
                  fontSize: 32,
                  color: palette.ink,
                ),
              ),
            ),
            _gap,
            // ElevatedButton(
            //   onPressed: () {
            //     audioController.playSfx(SfxType.buttonTap);
            //     GoRouter.of(context).go('/auth');
            //   },
            //   child: Text(
            //     'Рейтинг',
            //     style: TextStyle(
            //       fontFamily: palette.fontMain,
            //       fontSize: 26,
            //       color: palette.ink,
            //     ),
            //   ),
            // ),
            // _gap,

            // if (gamesServicesController != null) ...[
            //   _hideUntilReady(
            //     ready: gamesServicesController.signedIn,
            //     child: ElevatedButton(
            //       onPressed: () => gamesServicesController.showAchievements(),
            //       child: const Text('Achievements'),
            //     ),
            //   ),
            //   _gap,
            //   _hideUntilReady(
            //     ready: gamesServicesController.signedIn,
            //     child: ElevatedButton(
            //       onPressed: () => gamesServicesController.showLeaderboard(),
            //       child: const Text('Leaderboard'),
            //     ),
            //   ),
            //   _gap,
            // ],
            ElevatedButton(
              onPressed: () => GoRouter.of(context).push('/settings'),
              child: Text(
                'Настройки',
                style: TextStyle(
                  fontFamily: palette.fontMain,
                  fontSize: 26,
                  color: palette.ink,
                ),
              ),
            ),
            _gap,
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: ValueListenableBuilder<bool>(
                valueListenable: settingsController.muted,
                builder: (context, muted, child) {
                  return IconButton(
                    onPressed: () => settingsController.toggleMuted(),
                    icon: Icon(muted ? Icons.volume_off : Icons.volume_up),
                  );
                },
              ),
            ),
            _gap,
            // const Text('Music by Mr Smith'),
            // _gap,
          ],
        ),
      ),
    );
  }

  /// Prevents the game from showing game-services-related menu items
  /// until we're sure the player is signed in.
  ///
  /// This normally happens immediately after game start, so players will not
  /// see any flash. The exception is folks who decline to use Game Center
  /// or Google Play Game Services, or who haven't yet set it up.
  Widget _hideUntilReady({required Widget child, required Future<bool> ready}) {
    return FutureBuilder<bool>(
      future: ready,
      builder: (context, snapshot) {
        // Use Visibility here so that we have the space for the buttons
        // ready.
        return Visibility(
          visible: snapshot.data ?? false,
          maintainState: true,
          maintainSize: true,
          maintainAnimation: true,
          child: child,
        );
      },
    );
  }

  static const _gap = SizedBox(height: 10);
}
