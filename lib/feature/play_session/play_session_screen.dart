import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart' hide Level;
import 'package:provider/provider.dart';
import 'package:qlutter/app/di/init_di.dart';
import 'package:qlutter/app/ui/app_loader.dart';
import 'package:qlutter/feature/game_core/game_core.dart';
import 'package:qlutter/feature/field_view/field_view.dart';
import 'package:qlutter/feature/level_manager/domain/entities/level_entity/level_entity.dart';
import 'package:qlutter/feature/level_manager/domain/level_repository.dart';
import 'package:qlutter/feature/level_manager/level_manager.dart';
import 'package:qlutter/feature/settings/information_dialog.dart';
import '../game_internals/level_state.dart';
import '../games_services/score.dart';
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
  Field? field;
  Field? fieldCopy;

  Widget tutorial() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('Шаг 1: Нажмите на шар.'),
        Text('Шаг 2: Нажмите на стрелочку.'),
        Text('Шаг 3: Повторить шаги 1 и 2.'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LevelState(
            onWin: _playerWon,
          ),
        ),
      ],
      child: IgnorePointer(
        ignoring: _duringCelebration,
        child: Scaffold(
          backgroundColor: palette.backgroundPlaySession,
          body: FutureBuilder(
              future: _loadLevel(),
              builder: (context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.hasData) {
                  return Stack(
                    children: [
                      Center(
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
                                      if (field != null) {
                                        fieldCopy = Field.copyField(field!);
                                      }
                                    }),
                                    child: const Icon(Icons.refresh, size: 50),
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      level.levelId == 0
                                          ? 'Обучение'
                                          : 'Уровень: ${level.levelId}',
                                      style: TextStyle(
                                        fontFamily: palette.fontMain,
                                        fontSize: 26,
                                        color: palette.ink,
                                      ),
                                    )),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: InkResponse(
                                    onTap: () => showInformationDialog(context),
                                    child: const Icon(
                                      Icons.info_outline,
                                      size: 50,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            (level.levelId == 0) ? tutorial() : const Spacer(),
                            Consumer<LevelState>(
                              builder: (context, levelState, child) =>
                                  FieldView(
                                key: ValueKey<List<List<Item?>>>(
                                    fieldCopy!.level.field),
                                field: fieldCopy!,
                                onChanged: (value, step) =>
                                    levelState.setProgress(value, step),
                                onWin: () => levelState.evaluate(level.levelId),
                                onRefresh: () {
                                  setState(() {
                                    fieldCopy = Field.copyField(field!);
                                  });
                                },
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () =>
                                      GoRouter.of(context).go('/play'),
                                  child: Text(
                                    'Назад',
                                    style: TextStyle(
                                      fontFamily: palette.fontMain,
                                      fontSize: 26,
                                      color: palette.ink,
                                    ),
                                  ),
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
                  );
                } else {
                  return const AppLoader();
                }
              }),
        ),
      ),
    );
  }

  Future<bool> _loadLevel() async {
    final levels = await context.read<LevelManager>().readLevels();

    level = levels[widget.levelNumber]!;

    field = Field(level);
    fieldCopy = Field.copyField(field!);

    _startOfPlay = DateTime.now();
    return Future.value(true);
  }

  @override
  void initState() {
    super.initState();

    // level = context.read<LevelManager>().levels![widget.levelNumber]!;
  }

  Future<void> _playerWon(int steps) async {
    _log.info('Level ${widget.levelNumber} won');

    final score = Score(
      widget.levelNumber,
      steps,
      DateTime.now().difference(_startOfPlay),
    );

    final playerProgress = context.read<PlayerProgress>();
    playerProgress.setLevelReached(widget.levelNumber + 1);

    await Future<void>.delayed(_preCelebrationDuration);
    if (!mounted) return;

    setState(() {
      _duringCelebration = true;
    });

    await Future<void>.delayed(_celebrationDuration);
    if (!mounted) return;
    locator.get<LevelRepository>().sendProcess(
        levelId: score.level,
        steps: score.score,
        seconds: score.duration.inSeconds,
        dateTime: DateTime.now());

    GoRouter.of(context).go('/play/won', extra: {'score': score});
  }
}
