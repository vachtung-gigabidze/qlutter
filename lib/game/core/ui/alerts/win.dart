import 'package:flutter/material.dart';
import 'package:qlutter/game/core/styles.dart';

class AlertLevelComplete extends StatelessWidget {
  static bool newGame = false;
  static bool restartGame = false;
  static int? levelNumber;

  const AlertLevelComplete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Styles.secondaryBackgroundColor,
      title: Text(
        'Congratulation!!',
        style: TextStyle(color: Styles.foregroundColor),
      ),
      content: Text(
        (levelNumber != null && levelNumber! > 0)
            ? 'You successfully solved $levelNumber level'
            : 'You successfully solved tutorial',
        style: TextStyle(color: Styles.foregroundColor),
      ),
      actions: [
        TextButton(
          style: ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.all<Color>(Styles.primaryColor)),
          onPressed: () {
            Navigator.pop(context);
            restartGame = true;
          },
          child: const Text('Restart Level'),
        ),
        TextButton(
          style: ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.all<Color>(Styles.primaryColor)),
          onPressed: () {
            Navigator.pop(context);
            newGame = true;
          },
          child: const Text('Next Level'),
        ),
      ],
    );
  }
}
