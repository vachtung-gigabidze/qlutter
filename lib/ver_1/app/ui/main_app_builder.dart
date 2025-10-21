import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:qlutter/ver_1/app/domain/app_builder.dart';
import 'package:qlutter/ver_1/app/ui/components/app_palette.dart';
import 'package:qlutter/ver_1/game/provider/setting_provider.dart';
import 'package:qlutter/ver_1/game/router.dart';
import 'package:qlutter/ver_1/i18n/strings.g.dart';

class MainAppBuilder implements AppBuilder {
  @override
  Future<Widget> buildApp() async =>
      const SettingStateWidget(child: _GlobalProviders());
}

class _GlobalProviders extends StatelessWidget {
  const _GlobalProviders();

  @override
  Widget build(BuildContext context) {
    final setting = SettingProvider.of(context).setting;
    var initTheme = setting.theme == 'light' ? Palette().light : Palette().dark;
    LocaleSettings.setLocale(
      AppLocale.values.firstWhere((e) => e.languageTag == setting.language),
    );
    return ThemeProvider(
      initTheme: initTheme,
      builder: (p0, theme) => MaterialApp.router(
        locale: TranslationProvider.of(p0).flutterLocale,
        supportedLocales: AppLocaleUtils.supportedLocales,
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        debugShowCheckedModeBanner: false,
        title: 'Qlutter',
        theme: theme,
        routeInformationProvider: GameRouter.router.routeInformationProvider,
        routeInformationParser: GameRouter.router.routeInformationParser,
        routerDelegate: GameRouter.router.routerDelegate,
        // scaffoldMessengerKey: scaffoldMessengerKey,
      ),
    );
  }
}
