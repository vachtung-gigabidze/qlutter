import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qlutter/feature/style/palette.dart';

void showInformationDialog(BuildContext context) {
  showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) =>
          InformationDialog(animation: animation));
}

class InformationDialog extends StatelessWidget {
  final Animation<double> animation;

  const InformationDialog({required this.animation, super.key});

  @override
  Widget build(BuildContext context) {
    Palette palette = context.watch<Palette>();
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      ),
      child: SimpleDialog(
        backgroundColor: palette.backgroundSettings,
        title: null,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              'Цель закатить все цветные шарики на игровом поле в лунки того же цвета. Шарики двигаются только по прямой и только до первого препятствия.',
              style: TextStyle(fontFamily: 'Roboto', color: palette.ink),
              textAlign: TextAlign.left,
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Закрыть',
              style: TextStyle(
                fontFamily: palette.fontMain,
                fontSize: 32,
                color: palette.ink,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
