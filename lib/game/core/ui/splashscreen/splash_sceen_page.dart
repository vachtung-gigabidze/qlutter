import 'package:flutter/material.dart';
import 'package:qlutter/game/core/field_view.dart';
import 'package:qlutter/game/core/styles.dart';
import 'package:qlutter/game/core/ui/splashscreen/splash.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      navigateAfterSeconds: FieldView(),
      title: Text(
        '\nQlutter',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
            color: Styles.foregroundColor),
      ),
      image: Image.asset('assets/icon/icon_foreground.png'),
      photoSize: 100,
      backgroundColor: Styles.primaryBackgroundColor,
      loaderColor: Styles.primaryColor,
      loadingText: const Text(
        'vachtung-gigabidze',
        style: TextStyle(color: Colors.grey),
      ),
      loadingTextPadding: null,
      styleTextUnderTheLoader: null,
      useLoader: null,
    );
  }
}
