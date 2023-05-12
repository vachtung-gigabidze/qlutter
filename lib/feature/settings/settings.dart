import 'package:flutter/foundation.dart';
import 'package:qlutter/i18n/strings.g.dart';
import 'persistence/settings_persistence.dart';

class SettingsController {
  final SettingsPersistence _persistence;

  ValueNotifier<String> theme = ValueNotifier('light');

  ValueNotifier<String> language = ValueNotifier('ru');

  SettingsController({required SettingsPersistence persistence})
      : _persistence = persistence;

  ValueNotifier<String> playerName = ValueNotifier('Player');

  Future<void> loadStateFromPersistence() async {
    await Future.wait([
      _persistence
          .getTheme(defaultValue: 'light')
          .then((value) => theme.value = value),
      _persistence
          .getLanguage(defaultValue: 'ru')
          .then((value) => language.value = value),
      // _persistence.getMusicOn().then((value) => musicOn.value = value),
      // _persistence.getPlayerName().then((value) => playerName.value = value),
    ]);
  }

  void setTheme(String t) {
    theme.value = theme.value == 'dark' ? 'light' : 'dark';
    _persistence.saveTheme(theme.value);
  }

  void setLanguage(String l) {
    //language.value = l;
    // _persistence.saveLanguage(language.value);
    AppLocale locale = AppLocale.values
        .firstWhere((local) => local != LocaleSettings.currentLocale);

    _persistence.saveLanguage(locale.languageTag);
    LocaleSettings.setLocale(locale);
  }
}
