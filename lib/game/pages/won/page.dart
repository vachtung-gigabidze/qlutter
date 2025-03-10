import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:qlutter/app/ui/components/app_palette.dart';
import 'package:qlutter/feature/level_manager/level_manager.dart';
import 'package:qlutter/game/models/score.dart';
import 'package:qlutter/i18n/strings.g.dart';
import 'package:qlutter/app/ui/components/app_responsive.dart';

class WinGameScreen extends StatelessWidget {
  final Score score;

  const WinGameScreen({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    Palette palette = context.watch<Palette>();
    LevelManager lm = context.read<LevelManager>();
    final t = Translations.of(context);
    const gap = SizedBox(height: 10);
    final maxLevel = lm.levels?.length ?? 0;

    return Scaffold(
      //backgroundColor: palette.backgroundPlaySession,
      body: AppResponsiveScreen(
        squarishMainArea: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            gap,
            Center(
              child: Text(
                t.win.title,
                style: TextStyle(fontFamily: palette.fontMain, fontSize: 50),
              ),
            ),
            gap,
            Center(
              child: Text(
                '${t.win.step}: ${score.score}\n'
                '${t.win.time}: ${score.formattedTime}',
                style: TextStyle(fontFamily: palette.fontMain, fontSize: 20),
              ),
            ),
          ],
        ),
        rectangularMenuArea:
            (score.level != (maxLevel - 1))
                ? ElevatedButton(
                  onPressed: () {
                    GoRouter.of(context).go('/play/session/${score.level + 1}');
                  },
                  child: Text(
                    t.win.next,
                    style: TextStyle(
                      fontFamily: palette.fontMain,
                      fontSize: 20,
                      // color: palette.ink,
                    ),
                  ),
                )
                : ElevatedButton(
                  onPressed: () {
                    GoRouter.of(context).go('/play/');
                  },
                  child: Text(
                    t.win.back,
                    style: TextStyle(
                      fontFamily: palette.fontMain,
                      fontSize: 20,
                      //color: palette.ink,
                    ),
                  ),
                ),
      ),
    );
  }
}
