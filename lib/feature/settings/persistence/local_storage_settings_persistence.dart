import 'package:flutter/material.dart';
// import 'package:qlutter/i18n/strings.g.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'settings_persistence.dart';

class LocalStorageSettingsPersistence extends SettingsPersistence {
  final Future<SharedPreferences> instanceFuture =
      SharedPreferences.getInstance();

  @override
  Future<String> getLanguage() async {
    //final local = LocaleSettings.useDeviceLocale();
    final prefs = await instanceFuture;
    //defaultValue = local.languageCode;
    return prefs.getString('language') ?? "en";
  }

  @override
  Future<String> getTheme() async {
    final isPlatformDark =
        WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
    final prefs = await instanceFuture;
    final theme = prefs.getString('theme');

    final initTheme = theme ?? (isPlatformDark ? "dark" : "light");
    return initTheme;
  }

  @override
  Future<void> saveLanguage(String value) async {
    final prefs = await instanceFuture;
    await prefs.setString('language', value);
  }

  @override
  Future<void> saveTheme(String value) async {
    final prefs = await instanceFuture;
    //final newTheme = value == 'light' ? 'dark' : 'light';
    await prefs.setString('theme', value);
  }
}
