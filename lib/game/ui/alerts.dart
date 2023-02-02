import 'dart:html';

import 'package:flutter/material.dart';
import 'package:qlutter/game/field_view.dart';
import 'package:qlutter/game/styles.dart';
import 'package:qlutter/main.dart';
import 'package:url_launcher/url_launcher.dart';

class AlertAccentColorsState extends StatefulWidget {
  String currentAccentColor;

  AlertAccentColorsState(this.currentAccentColor);

  String get accentColor {
    return AlertAccentColors.accentColor ?? "no";
  }

  set accentColor(String color) {
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

class AlertAbout extends StatelessWidget {
  static const String authorURL = "https://github.com/vachtung-gigabidze/";
  static const String releasesURL =
      "https://github.com/vachtung-gigabidze/qlutter/releases/";
  static const String sourceURL =
      "https://github.com/vachtung-gigabidze/qlutter/";
  static const String licenseURL =
      "https://github.com/vachtung-gigabidze/qlutter/blob/main/LICENSE";

  const AlertAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Styles.secondaryBackgroundColor,
      title: Center(
        child: Text(
          'About',
          style: TextStyle(color: Styles.foregroundColor),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('icon/icon_foreground.png',
                  height: 48.0, width: 48.0, fit: BoxFit.contain),
              Text(
                '   Qlutter',
                style: TextStyle(
                    color: Styles.foregroundColor,
                    fontFamily: 'roboto',
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '                ',
                style: TextStyle(
                    color: Styles.foregroundColor,
                    fontFamily: 'roboto',
                    fontSize: 15),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Version: ',
                style: TextStyle(
                    color: Styles.foregroundColor,
                    fontFamily: 'roboto',
                    fontSize: 15),
              ),
              InkWell(
                onTap: () async {
                  await launchUrl(Uri.parse(AlertAbout.releasesURL));
                },
                child: Text(
                  '${Qlutter.versionNumber} ',
                  style: TextStyle(
                      color: Styles.primaryColor,
                      fontFamily: 'roboto',
                      fontSize: 15),
                ),
              ),
              Text(
                FieldViewState.platform ?? "web",
                style: TextStyle(
                    color: Styles.foregroundColor,
                    fontFamily: 'roboto',
                    fontSize: 15),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '                ',
                style: TextStyle(
                    color: Styles.foregroundColor,
                    fontFamily: 'roboto',
                    fontSize: 15),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Author: ',
                style: TextStyle(
                    color: Styles.foregroundColor,
                    fontFamily: 'roboto',
                    fontSize: 15),
              ),
              InkWell(
                onTap: () async {
                  await launchUrl(Uri.parse(AlertAbout.authorURL));
                },
                child: Text(
                  'vachtung-gigabidze',
                  style: TextStyle(
                      color: Styles.primaryColor,
                      fontFamily: 'roboto',
                      fontSize: 15),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '                ',
                style: TextStyle(
                    color: Styles.foregroundColor,
                    fontFamily: 'roboto',
                    fontSize: 15),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'License: ',
                style: TextStyle(
                    color: Styles.foregroundColor,
                    fontFamily: 'roboto',
                    fontSize: 15),
              ),
              InkWell(
                onTap: () async {
                  await launchUrl(Uri.parse(AlertAbout.licenseURL));
                },
                child: Text(
                  'GNU GPLv3',
                  style: TextStyle(
                      color: Styles.primaryColor,
                      fontFamily: 'roboto',
                      fontSize: 15),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '                ',
                style: TextStyle(
                    color: Styles.foregroundColor,
                    fontFamily: 'roboto',
                    fontSize: 15),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  await launchUrl(Uri.parse(AlertAbout.sourceURL));
                },
                child: Text(
                  'Source Code',
                  style: TextStyle(
                      color: Styles.primaryColor,
                      fontFamily: 'roboto',
                      fontSize: 15),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
