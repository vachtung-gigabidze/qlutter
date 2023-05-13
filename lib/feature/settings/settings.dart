import 'package:flutter/foundation.dart';
import 'package:qlutter/i18n/strings.g.dart';
import 'persistence/settings_persistence.dart';

class SettingsController {
  final SettingsPersistence _persistence;

  ValueNotifier<String> theme = ValueNotifier('');

  ValueNotifier<String> language = ValueNotifier('en');

  SettingsController({required SettingsPersistence persistence})
      : _persistence = persistence;

  ValueNotifier<String> playerName = ValueNotifier('Player');

  Future<void> loadStateFromPersistence() async {
    await Future.wait([
      _persistence.getTheme().then((value) => theme.value = value),
      _persistence.getLanguage().then((value) => language.value = value),
      // _persistence.getMusicOn().then((value) => musicOn.value = value),
      // _persistence.getPlayerName().then((value) => playerName.value = value),
    ]);
  }

  void setTheme(String theme) {
    // theme.value = theme.value == 'dark' ? 'light' : 'dark';
    _persistence.saveTheme(theme);
  }

  void setLanguage(String l) {
    // _persistence.saveLanguage(language.value);
    AppLocale locale = AppLocale.values
        .firstWhere((local) => local != LocaleSettings.currentLocale);

    language.value = LocaleSettings.currentLocale.languageTag;
    _persistence.saveLanguage(locale.languageTag);
    LocaleSettings.setLocale(locale);
  }
}
