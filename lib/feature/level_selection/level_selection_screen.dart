import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:qlutter/app/ui/app_loader.dart';
import 'package:qlutter/feature/field_view/field_view.dart';
import 'package:qlutter/feature/game_core/game_core.dart';
import 'package:qlutter/feature/level_manager/domain/entities/level_entity/level_entity.dart';
import 'package:qlutter/feature/level_manager/level_manager.dart';
import 'package:qlutter/feature/player_progress/player_progress.dart';
// import '../player_progress/player_progress.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';

class LevelSelectionScreen extends StatelessWidget {
  const LevelSelectionScreen({super.key});

  static double textScaleFactor(BuildContext context,
      {double maxTextScaleFactor = 1}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 500) * maxTextScaleFactor;
    return min(val, maxTextScaleFactor);
  }

  @override
  Widget build(BuildContext context) {
    Palette palette = context.watch<Palette>();
    final playerProgress = context.watch<PlayerProgress>();
    // final levelManager = context.read<LevelManager>();

    return Scaffold(
      backgroundColor: palette.backgroundLevelSelection,
      body: FutureBuilder(
          future: context.read<LevelManager>().readLevels(),
          builder: (context, AsyncSnapshot<Map<int, Level>> snapshot) {
            if (snapshot.hasData) {
              return ResponsiveScreen(
                squarishMainArea: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: Text(
                          'Выбор уровня',
                          style: TextStyle(
                              fontFamily: palette.fontMain, fontSize: 30),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 6,
                        children: [
                          for (final level in snapshot.data!.values)
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: FittedBox(
                                    child: InkWell(
                                      onTap: () {
                                        GoRouter.of(context).go(
                                            '/play/session/${level.levelId}');
                                      },
                                      child: FieldView(
                                        backgroundColor:
                                            palette.backgroundLevelSelection,
                                        parentSize: const Size(150, 150),
                                        key: ValueKey<List<List<Item?>>>(
                                            level.field),
                                        field: Field(level),
                                        onChanged: (p0, s0) {},
                                        onWin: () {},
                                        onRefresh: () {},
                                        isView: true,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  level.levelId == 0
                                      ? 'Обучение'
                                      : level.levelId.toString(),
                                  style: const TextStyle(fontSize: 16),
                                  textScaleFactor: level.levelId == 0
                                      ? textScaleFactor(context)
                                      : 1,
                                ),
                              ],
                            )
                        ],
                      ),
                    ),
                  ],
                ),
                rectangularMenuArea: ElevatedButton(
                  onPressed: () {
                    GoRouter.of(context).go('/');
                  },
                  child: Text(
                    'Назад',
                    style: TextStyle(
                      fontFamily: palette.fontMain,
                      fontSize: 20,
                      color: palette.ink,
                    ),
                  ),
                ),
              );
            } else {
              return const AppLoader();
            }
          }),
    );
  }
}
