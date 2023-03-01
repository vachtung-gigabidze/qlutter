import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../games_services/score.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';

class WinGameScreen extends StatelessWidget {
  final Score score;

  const WinGameScreen({
    super.key,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    Palette palette = context.watch<Palette>();

    const gap = SizedBox(height: 10);

    return Scaffold(
      backgroundColor: palette.backgroundPlaySession,
      body: ResponsiveScreen(
        squarishMainArea: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            gap,
            Center(
              child: Text(
                'Победа!',
                style: TextStyle(fontFamily: palette.fontMain, fontSize: 50),
              ),
            ),
            gap,
            Center(
              child: Text(
                'Ход: ${score.score}\n'
                'Время: ${score.formattedTime}',
                style: TextStyle(fontFamily: palette.fontMain, fontSize: 20),
              ),
            ),
          ],
        ),
        rectangularMenuArea: ElevatedButton(
          onPressed: () {
            GoRouter.of(context).go('/play/session/${score.level + 1}');
          },
          child: Text(
            'Вперед',
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
