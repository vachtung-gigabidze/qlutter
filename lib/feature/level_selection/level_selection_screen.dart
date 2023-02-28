import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:qlutter/feature/field_view/field_view.dart';
import 'package:qlutter/feature/game_core/game_core.dart';
import 'package:qlutter/feature/level_manager/level_manager.dart';

// import '../audio/audio_controller.dart';
// import '../audio/sounds.dart';
import '../player_progress/player_progress.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';

class LevelSelectionScreen extends StatelessWidget {
  const LevelSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Palette palette = context.watch<Palette>();
    final playerProgress = context.watch<PlayerProgress>();
    final levelManager = context.read<LevelManager>();

    return Scaffold(
      backgroundColor: palette.backgroundLevelSelection,
      body: ResponsiveScreen(
        squarishMainArea: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Text(
                  'Выбор уровня',
                  style: TextStyle(fontFamily: palette.fontMain, fontSize: 30),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Expanded(
              child: ListView(
                children: [
                  for (final level in levelManager.levels!.values)
                    ListTile(
                      enabled:
                          playerProgress.highestLevelReached >= level.levelId,
                      onTap: () {
                        // final audioController = context.read<AudioController>();
                        // audioController.playSfx(SfxType.buttonTap);

                        GoRouter.of(context)
                            .go('/play/session/${level.levelId}');
                      },
                      leading: Text(level.levelId.toString()),
                      title: SizedBox(
                        height: 50,
                        width: 50,
                        child: FieldView(
                          backgroundColor: palette.backgroundLevelSelection,
                          parentSize: const Size(50, 50),
                          key: ValueKey<List<List<Item?>>>(level.field),
                          field: Field(level),
                          onChanged: (p0, s0) {},
                          onWin: () {},
                          onRefresh: () {},
                        ),
                      ),
                      // title: Text(level.levelId == 0
                      //     ? 'Tutorial'
                      //     : 'Level #${level.levelId}'),
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
      ),
    );
  }
}
