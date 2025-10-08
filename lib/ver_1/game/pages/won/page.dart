import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qlutter/ver_1/app/ui/components/app_palette.dart';
// import 'package:qlutter/feature/level_builder/level_builder.dart';
import 'package:qlutter/ver_1/game/models/score.dart';
import 'package:qlutter/ver_1/i18n/strings.g.dart';
import 'package:qlutter/ver_1/app/ui/components/app_responsive.dart';

class WinGameScreen extends StatelessWidget {
  const WinGameScreen({required this.score, super.key});
  final Score score;

  @override
  Widget build(BuildContext context) {
    var palette = Palette();
    // LevelBuilder lm = LevelBuilder();
    final t = Translations.of(context);
    const gap = SizedBox(height: 10);
    const maxLevel = 60 ?? 0;

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
        rectangularMenuArea: (score.level != (maxLevel - 1))
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
