import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart' hide Level;
import 'package:qlutter/ver_1/game/game_core/game_core.dart';
import 'package:qlutter/ver_1/game/field_view/field_view.dart';
import 'package:qlutter/ver_1/game/level_builder/level_builder.dart';
import 'package:qlutter/ver_1/app/ui/components/components.dart';
import 'package:qlutter/ver_1/game/models/score.dart';
import 'package:qlutter/ver_1/game/provider/setting_provider.dart';
import 'package:qlutter/ver_1/i18n/strings.g.dart';

class PlaySceneScreen extends StatefulWidget {
  const PlaySceneScreen(this.levelNumber, {super.key});
  final int levelNumber;

  @override
  State<PlaySceneScreen> createState() => _PlaySceneScreenState();
}

class _PlaySceneScreenState extends State<PlaySceneScreen> {
  static final _log = Logger('PlayScreen');

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
    var val = (width / 600) * maxTextScaleFactor;
    return min(val, maxTextScaleFactor);
  }

  Widget tutorial(List<String> t) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(t[0], textScaleFactor: textScaleFactor(context)),
      Text(t[1], textScaleFactor: textScaleFactor(context)),
      Text(t[2], textScaleFactor: textScaleFactor(context)),
    ],
  );

  @override
  Widget build(BuildContext context) {
    final palette = Palette();
    final t = Translations.of(context);

    final settings = SettingProvider.of(context);
    // final setting = settings.setting;
    return IgnorePointer(
      ignoring: _duringCelebration,
      child: FutureBuilder(
        future: _loadLevel(settings.levelBuilder.levels!),
        builder: (context, snapshot) {
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
                            ? t.session.tutorial.title
                            : '${t.session.title} ${level.levelId}',
                        style: TextStyle(
                          fontFamily: palette.fontMain,
                          fontSize: 26,
                          // color: palette.ink,
                        ),
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
                          FieldView(
                            key: ValueKey<List<List<Item?>>>(
                              fieldCopy!.level.field,
                            ),
                            field: fieldCopy!,
                            onChanged: (value, step) {},
                            onWin: () => _playerWon(1),
                            onRefresh: () {
                              setState(() {
                                fieldCopy = Field.copyField(field!);
                              });
                            },
                          ),

                          const Spacer(),
                          if (level.levelId == 0)
                            tutorial(t.session.tutorial.steps)
                          else
                            const Spacer(),
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
    );
  }

  Future<bool> _loadLevel(Map<int, Level> levels) async {
    // final settings = SettingProvider.of(context);

    // final levels = settings.levelBuilder.levels!;

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
      level: widget.levelNumber,
      score: 0,
      duration: DateTime.now().difference(_startOfPlay),
    );

    //final playerProgress = context.read<PlayerProgress>();
    //playerProgress.setLevelReached(widget.levelNumber + 1);

    await Future<void>.delayed(_preCelebrationDuration);
    if (!mounted) return;

    setState(() {
      _duringCelebration = true;
    });

    // await Future<void>.delayed(_celebrationDuration);
    if (!mounted) return;

    GoRouter.of(context).go('/play/won', extra: {'score': score});
  }
}
