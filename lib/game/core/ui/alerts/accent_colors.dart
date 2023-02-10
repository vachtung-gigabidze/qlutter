import 'package:flutter/material.dart';
import 'package:qlutter/game/core/styles.dart';

class AlertAccentColorsState extends StatefulWidget {
  String currentAccentColor;

  AlertAccentColorsState(this.currentAccentColor, {super.key});

  static String? get accentColor {
    return AlertAccentColors.accentColor ?? "no";
  }

  static set accentColor(String? color) {
    AlertAccentColors.accentColor = color;
  }

  @override
  AlertAccentColors createState() => AlertAccentColors(currentAccentColor);
}

class AlertAccentColors extends State<AlertAccentColorsState> {
  static String? accentColor;
  static final List<String> accentColors = [...Styles.accentColors.keys];
  String currentAccentColor;

  AlertAccentColors(this.currentAccentColor);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Center(
          child: Text(
        'Select Accent Color',
        style: TextStyle(color: Styles.foregroundColor),
      )),
      backgroundColor: Styles.secondaryBackgroundColor,
      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      children: <Widget>[
        for (String color in accentColors)
          SimpleDialogOption(
            onPressed: () {
              if (color != currentAccentColor) {
                setState(() {
                  accentColor = color;
                });
              }
              Navigator.pop(context);
            },
            child: Text(color,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    color: color == currentAccentColor
                        ? Styles.primaryColor
                        : Styles.foregroundColor)),
          ),
      ],
    );
  }
}
