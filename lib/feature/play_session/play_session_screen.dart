// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart' hide Level;
import 'package:provider/provider.dart';
import 'package:qlutter/feature/game_core/game_core.dart';
import 'package:qlutter/feature/field_view/field_view.dart';
import 'package:qlutter/feature/level_manager/level_manager.dart';
// import 'package:qlutter/game/core/core.dart';

// import '../ads/ads_controller.dart';
import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../game_internals/level_state.dart';
import '../games_services/games_services.dart';
import '../games_services/score.dart';
// import '../in_app_purchase/in_app_purchase.dart';
// import '../level_selection/levels.dart';
import '../player_progress/player_progress.dart';
import '../style/confetti.dart';
import '../style/palette.dart';

class PlaySessionScreen extends StatefulWidget {
  final int levelNumber;

  const PlaySessionScreen(this.levelNumber, {super.key});

  @override
  State<PlaySessionScreen> createState() => _PlaySessionScreenState();
}

class _PlaySessionScreenState extends State<PlaySessionScreen> {
  static final _log = Logger('PlaySessionScreen');

  static const _celebrationDuration = Duration(milliseconds: 2000);

  static const _preCelebrationDuration = Duration(milliseconds: 500);

  bool _duringCelebration = false;

  late DateTime _startOfPlay;
  late Level level;
  late Field field;
  late Field fieldCopy;

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    //level = context.read<LevelManager>().levels![widget.levelNumber]!;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LevelState(
            goal: false, //widget.level.difficulty,
            onWin: _playerWon,
          ),
        ),
      ],
      child: IgnorePointer(
        ignoring: _duringCelebration,
        child: Scaffold(
          backgroundColor: palette.backgroundPlaySession,
          body: Stack(
            children: [
              Center(
                // This is the entirety of the "game".
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: InkResponse(
                            onTap: () => setState(() {
                              field = Field.copyField(fieldCopy);
                            }),
                            child: Image.asset(
                              'assets/images/restart.png',
                              semanticLabel: 'Restart',
                              height: 50,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkResponse(
                            onTap: () => GoRouter.of(context).push('/settings'),
                            child: Image.asset(
                              'assets/images/settings.png',
                              semanticLabel: 'Settings',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Consumer<LevelState>(
                      builder: (context, levelState, child) => FieldView(
                        key: ValueKey<List<List<Item?>>>(field.level.field),
                        field: field,
                        onChanged: (value) => levelState.setProgress(value),
                        onWin: () => levelState.evaluate(),
                      ),
                    ),
                    // Text('Drag the slider to %'
                    //     ' or above!'),
                    // Consumer<LevelState>(
                    //   builder: (context, levelState, child) => Slider(
                    //     label: 'Level Progress',
                    //     autofocus: true,
                    //     value: levelState.progress / 100,
                    //     onChanged: (value) =>
                    //         levelState.setProgress((value * 100).round()),
                    //     onChangeEnd: (value) => levelState.evaluate(),
                    //   ),
                    // ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => GoRouter.of(context).go('/play'),
                          child: const Text('Back'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox.expand(
                child: Visibility(
                  visible: _duringCelebration,
                  child: IgnorePointer(
                    child: Confetti(
                      isStopped: !_duringCelebration,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    level = context.read<LevelManager>().levels![widget.levelNumber]!;
    field = Field(level);
    fieldCopy = Field.copyField(field);

    _startOfPlay = DateTime.now();

    // Preload ad for the win screen.
    // final adsRemoved =
    //     context.read<InAppPurchaseController?>()?.adRemoval.active ?? false;
    // if (!adsRemoved) {
    //   final adsController = context.read<AdsController?>();
    //   adsController?.preloadAd();
    // }
  }

  Future<void> _playerWon() async {
    _log.info('Level ${widget.levelNumber} won');

    final score = Score(
      widget.levelNumber,
      1, //widget.level.difficulty,
      DateTime.now().difference(_startOfPlay),
    );

    final playerProgress = context.read<PlayerProgress>();
    playerProgress.setLevelReached(widget.levelNumber + 1);

    // Let the player see the game just after winning for a bit.
    await Future<void>.delayed(_preCelebrationDuration);
    if (!mounted) return;

    setState(() {
      _duringCelebration = true;
    });

    final audioController = context.read<AudioController>();
    audioController.playSfx(SfxType.congrats);

    final gamesServicesController = context.read<GamesServicesController?>();
    if (gamesServicesController != null) {
      // Award achievement.
      // if (widget.level.awardsAchievement) {
      //   await gamesServicesController.awardAchievement(
      //     android: widget.level.achievementIdAndroid!,
      //     iOS: widget.level.achievementIdIOS!,
      //   );
      // }

      // Send score to leaderboard.
      await gamesServicesController.submitLeaderboardScore(score);
    }

    /// Give the player some time to see the celebration animation.
    await Future<void>.delayed(_celebrationDuration);
    if (!mounted) return;

    GoRouter.of(context).go('/play/won', extra: {'score': score});
  }
}