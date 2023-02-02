import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qlutter/game/ui/splash_sceen_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const Qlutter());
}

class Qlutter extends StatelessWidget {
  static String versionNumber = '1.0.0';
  const Qlutter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Qlutter',
        theme: ThemeData(
          useMaterial3: true,

          primarySwatch: Colors.blue,
          //colorSchemeSeed: Colors.white
        ),
        home: SplashScreenPage());
  }
}
