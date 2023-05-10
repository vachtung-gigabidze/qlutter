import 'package:flutter/foundation.dart';

import 'persistence/settings_persistence.dart';

class SettingsController {
  final SettingsPersistence _persistence;

  ValueNotifier<String> theme = ValueNotifier('light');

  ValueNotifier<String> language = ValueNotifier('Русский');

  SettingsController({required SettingsPersistence persistence})
      : _persistence = persistence;

  ValueNotifier<String> playerName = ValueNotifier('Player');

  Future<void> loadStateFromPersistence() async {
    await Future.wait([
      _persistence
          .getTheme(defaultValue: 'light')
          .then((value) => theme.value = value),
      _persistence
          .getLanguage(defaultValue: 'Русский')
          .then((value) => language.value = value),
      // _persistence.getMusicOn().then((value) => musicOn.value = value),
      // _persistence.getPlayerName().then((value) => playerName.value = value),
    ]);
  }

  void setTheme(String t) {
    theme.value = t;
    _persistence.saveTheme(theme.value);
  }

  void setLanguage(String l) {
    language.value = l;
    _persistence.saveLanguage(language.value);
  }

  // void setPlayerName(String name) {
  //   playerName.value = name;
  //   _persistence.savePlayerName(playerName.value);
  // }

  // void toggleMusicOn() {
  //   musicOn.value = !musicOn.value;
  //   _persistence.saveMusicOn(musicOn.value);
  // }

  // void toggleMuted() {
  //   muted.value = !muted.value;
  //   _persistence.saveMuted(muted.value);
  // }

  // void toggleSoundsOn() {
  //   soundsOn.value = !soundsOn.value;
  //   _persistence.saveSoundsOn(soundsOn.value);
  // }
}
