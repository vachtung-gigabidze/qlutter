import 'package:flutter/material.dart';
import 'package:qlutter/game/field_view/field_view.dart';
import 'package:qlutter/game/core/styles.dart';
import 'package:qlutter/game/core/ui/splashscreen/splash.dart';
import 'package:qlutter/main.dart';

class SplashScreenPage extends StatefulWidget {
  final Object? naviagateScreen;
  const SplashScreenPage({Key? key, this.naviagateScreen}) : super(key: key);

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
      navigateAfterSeconds: widget.naviagateScreen,
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
