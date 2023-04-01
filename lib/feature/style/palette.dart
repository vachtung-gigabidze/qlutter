import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class Palette {
  Color get pen => const Color(0xff1d75fb);
  Color get darkPen => const Color(0xFF0050bc);
  Color get redPen => const Color(0xFFd10841);
  Color get inkFullOpacity => const Color(0xff352b42);
  Color get ink => const Color(0xee352b42);
  Color get backgroundMain => const Color(0xffffffd1);
  Color get backgroundField => const Color(0xffffffff);
  Color get backgroundAuth => const Color(0xffffffb1);
  Color get backgroundLevelSelection => const Color(0xffa2dcc7);
  Color get backgroundPlaySession => const Color(0xffffebb5);
  Color get background4 => const Color(0xffffd7ff);
  Color get backgroundSettings => const Color(0xffbbc8e3);
  Color get trueWhite => const Color(0xffffffff);

  Color get blockColor => Colors.grey;
  Color get cellColor1 => Colors.green;
  Color get cellColor2 => Colors.red;
  Color get cellColor3 => Colors.blue;
  Color get cellColor4 => Colors.deepPurple;
  // Color get cellColor4 => Colors.yellow;
  Color get cellColor5 => Colors.deepOrangeAccent;
  Color get cellColor6 => Colors.indigo;
  String get fontMain => 'DS Goose';
  TextStyle get headTableStyle => TextStyle(fontSize: 16, fontFamily: fontMain);
  TextStyle get rowTableStyle => const TextStyle(fontSize: 12);

  ThemeData get light => ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.light,
          seedColor: darkPen,
          background: backgroundMain,
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            fontFamily: fontMain,
            fontSize: 26,
            color: ink,
          ),
        ),
        useMaterial3: true,
      );
  ThemeData get dark => ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.white54,
          background: Colors.grey[700],
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            fontFamily: fontMain,
            fontSize: 26,
            color: Colors.white,
          ),
        ),
        useMaterial3: true,
      );
  /*
  Color get cellColor1 => const Color(0xfff5bfd2);
  Color get cellColor2 => const Color(0xffa1cdce);
  Color get cellColor3 => const Color(0xffe5db9c);
  Color get cellColor4 => const Color(0xffbeb4c5);
  Color get cellColor5 => const Color(0xffe6a57e);
  Color get cellColor6 => const Color(0xff218b82);
  */
}
