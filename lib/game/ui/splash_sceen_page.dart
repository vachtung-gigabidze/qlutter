import 'package:flutter/material.dart';
import 'package:qlutter/game/field_view.dart';
import 'package:qlutter/game/styles.dart';
import 'package:qlutter/game/ui/splash.dart';

class SplashScreenPage extends StatefulWidget {
  SplashScreenPage({Key? key}) : super(key: key);

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
      navigateAfterSeconds: Scaffold(
          floatingActionButton: FloatingActionButton(
            foregroundColor: Styles.primaryBackgroundColor,
            backgroundColor: Styles.primaryColor,
            onPressed: () => {}, //showOptionModalSheet(context),
            child: Icon(Icons.menu_rounded),
          ),
          backgroundColor: Styles.primaryBackgroundColor,
          body: FieldView()),
      title: Text(
        '\nQlutter',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
            color: Styles.foregroundColor),
      ),
      image: Image.asset('icon/icon_foreground.png'),
      photoSize: 50,
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
