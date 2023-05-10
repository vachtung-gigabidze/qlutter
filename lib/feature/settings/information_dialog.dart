import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qlutter/feature/style/palette.dart';
import 'package:qlutter/i18n/strings.g.dart';

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
    final t = Translations.of(context);
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
              t.info.text,
              style: TextStyle(fontFamily: 'Roboto', color: palette.ink),
              textAlign: TextAlign.left,
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              t.info.back,
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
