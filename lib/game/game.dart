import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';

class GameWidget extends StatelessWidget {
  const GameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = locator.get<Palette>();
    final setting = LocalStorageSettingsPersistence();
    final themeSetting = await setting.getTheme();
    final languageSetting = await setting.getLanguage();
    LocaleSettings.setLocale(
        AppLocale.values.firstWhere((e) => e.languageTag == languageSetting));
    ThemeData initTheme =
        themeSetting == 'light' ? palette.light : palette.dark;
    return ThemeProvider(
          initTheme: initTheme,
          builder: (p0, theme) {
            return MaterialApp.router(
              locale: TranslationProvider.of(p0).flutterLocale,
              supportedLocales: AppLocaleUtils.supportedLocales,
              localizationsDelegates: GlobalMaterialLocalizations.delegates,
              debugShowCheckedModeBanner: false,
              title: 'Qlutter',
              theme: theme,
              routeInformationProvider: _router.routeInformationProvider,
              routeInformationParser: _router.routeInformationParser,
              routerDelegate: _router.routerDelegate,
              scaffoldMessengerKey: scaffoldMessengerKey,
            );
          });
  }
}
