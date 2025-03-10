import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart' hide Level;
import 'package:provider/provider.dart';
import 'package:qlutter/app/ui/app_loader.dart';
import 'package:qlutter/game/game_core/game_core.dart';
import 'package:qlutter/game/field_view/field_view.dart';
import 'package:qlutter/feature/level_builder/domain/entities/level_entity/level_entity.dart';
import 'package:qlutter/feature/level_builder/level_builder.dart';
import 'package:qlutter/feature/settings/information_dialog.dart';
import 'package:qlutter/app/ui/components/components.dart';
import 'package:qlutter/game/models/score.dart';
import 'package:qlutter/i18n/strings.g.dart';

class PlayScreen extends StatefulWidget {
  final int levelNumber;

  const PlayScreen(this.levelNumber, {super.key});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  static final _log = Logger('PlayScreen');

  static const _celebrationDuration = Duration(milliseconds: 2000);

  static const _preCelebrationDuration = Duration(milliseconds: 500);

  bool _duringCelebration = false;

  late DateTime _startOfPlay;
  late Level level;
  Field? field;
  Field? fieldCopy;

  static double textScaleFactor(
    BuildContext context, {
    double maxTextScaleFactor = 1,
  }) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 600) * maxTextScaleFactor;
    return min(val, maxTextScaleFactor);
  }

  Widget tutorial(List<String> t) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(t[0], textScaleFactor: textScaleFactor(context)),
        Text(t[1], textScaleFactor: textScaleFactor(context)),
        Text(t[2], textScaleFactor: textScaleFactor(context)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final t = Translations.of(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LevelState(onWin: _playerWon),
        ),
      ],
      child: IgnorePointer(
        ignoring: _duringCelebration,
        child: FutureBuilder(
          future: _loadLevel(),
          builder: (context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              return Scaffold(
                appBar: AppBar(
                  //backgroundColor: Colors.transparent,
                  automaticallyImplyLeading: false,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkResponse(
                          onTap:
                              () => setState(() {
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
                              ? t.session.tutorial.title
                              : '${t.session.title} ${level.levelId}',
                          style: TextStyle(
                            fontFamily: palette.fontMain,
                            fontSize: 26,
                            // color: palette.ink,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkResponse(
                          onTap: () => showInformationDialog(context),
                          child: const Icon(Icons.info_outline, size: 50),
                        ),
                      ),
                    ],
                  ),
                ),
                //backgroundColor: palette.backgroundPlaySession,
                body: AppResponsiveScreen(
                  squarishMainArea: Stack(
                    children: [
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Spacer(),
                            Consumer<LevelState>(
                              builder:
                                  (context, levelState, child) => FieldView(
                                    key: ValueKey<List<List<Item?>>>(
                                      fieldCopy!.level.field,
                                    ),
                                    field: fieldCopy!,
                                    onChanged:
                                        (value, step) =>
                                            levelState.setProgress(value, step),
                                    onWin:
                                        () =>
                                            levelState.evaluate(level.levelId),
                                    onRefresh: () {
                                      setState(() {
                                        fieldCopy = Field.copyField(field!);
                                      });
                                    },
                                  ),
                            ),
                            const Spacer(),
                            (level.levelId == 0)
                                ? tutorial(t.session.tutorial.steps)
                                : const Spacer(),
                            const Spacer(),
                          ],
                        ),
                      ),
                      // SizedBox.expand(
                      //   child: Visibility(
                      //     visible: _duringCelebration,
                      //     child: IgnorePointer(
                      //       child: Confetti(
                      //         isStopped: !_duringCelebration,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  rectangularMenuArea: ElevatedButton(
                    onPressed: () => GoRouter.of(context).go('/play'),
                    child: Text(
                      t.session.back,
                      style: TextStyle(
                        fontFamily: palette.fontMain,
                        fontSize: 26,
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return const AppLoader();
            }
          },
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

    GoRouter.of(context).go('/play/won', extra: {'score': score});
  }
}
