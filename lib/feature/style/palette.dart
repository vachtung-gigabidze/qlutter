import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class Palette {
  Color get pen => const Color(0xff1d75fb);
  Color get darkPen => const Color(0xFF0050bc);
  Color get redPen => const Color(0xFFd10841);
  Color get inkFullOpacity => const Color(0xff352b42);
  Color get ink => const Color(0xee352b42);
  Color get backgroundMain => const Color.fromARGB(255, 193, 183, 116);
  Color get backgroundField => const Color(0xffffffff);
  Color get backgroundAuth => const Color.fromARGB(255, 163, 163, 114);
  Color get backgroundLevelSelection => const Color(0xffa2dcc7);
  Color get backgroundPlaySession => const Color(0xffffebb5);
  Color get background4 => const Color(0xffffd7ff);
  Color get backgroundSettings => const Color(0xffbbc8e3);
  Color get trueWhite => const Color(0xffffffff);

  Color get blockColor => const Color.fromARGB(255, 141, 132, 149);
  Color get cellColor1 => Colors.green;
  Color get cellColor2 => Colors.red;
  Color get cellColor3 => Colors.blue;
  Color get cellColor4 => Colors.deepPurple;
  Color get cellColor5 => Colors.deepOrangeAccent;
  Color get cellColor6 => Colors.indigo;
  String get fontMain => 'DS Goose';
  TextStyle get headTableStyle => TextStyle(fontSize: 16, fontFamily: fontMain);
  TextStyle get rowTableStyle => const TextStyle(fontSize: 12);

  ThemeData get light => ThemeData.light().copyWith(
        colorScheme: ThemeData.light().colorScheme.copyWith(
              primary: ink,
              surface: backgroundMain,
            ),
        scaffoldBackgroundColor: backgroundMain,
        appBarTheme: ThemeData.light().appBarTheme.copyWith(
            iconTheme: const IconThemeData(color: Colors.black),
            color: backgroundMain,
            foregroundColor: Colors.black,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: backgroundMain,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.dark,
            )),
        buttonTheme: ThemeData.light().buttonTheme.copyWith(
              buttonColor: Colors.green,
            ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            fontFamily: fontMain,
            fontSize: 26,
            color: ink,
          ),
        ),
      );

  ThemeData get dark => ThemeData.dark().copyWith(
        colorScheme: ThemeData.dark().colorScheme.copyWith(
              shadow: Colors.white,
              secondary: Colors.white70,
              primary: Colors.white70,
              surface: Colors.grey[800],
            ),
        elevatedButtonTheme: ThemeData.dark().elevatedButtonTheme,
        scaffoldBackgroundColor: Colors.grey[900],
        appBarTheme: ThemeData.dark().appBarTheme.copyWith(
            iconTheme: const IconThemeData(color: Colors.white70),
            color: Colors.grey[900],
            foregroundColor: Colors.white70,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.grey[900],
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.light,
            )),
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            fontFamily: fontMain,
            fontSize: 26,
            color: Colors.white,
          ),
        ),
      );
}
