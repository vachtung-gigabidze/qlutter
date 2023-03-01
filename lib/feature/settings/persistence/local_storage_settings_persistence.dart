import 'package:shared_preferences/shared_preferences.dart';

import 'settings_persistence.dart';

class LocalStorageSettingsPersistence extends SettingsPersistence {
  final Future<SharedPreferences> instanceFuture =
      SharedPreferences.getInstance();

  @override
  Future<String> getLanguage({required String defaultValue}) async {
    final prefs = await instanceFuture;
    return prefs.getString('language') ?? defaultValue;
  }

  @override
  Future<String> getTheme({required String defaultValue}) async {
    final prefs = await instanceFuture;
    return prefs.getString('there') ?? defaultValue;
  }

  @override
  Future<void> saveLanguage(String value) async {
    final prefs = await instanceFuture;
    await prefs.setString('language', value);
  }

  @override
  Future<void> saveTheme(String value) async {
    final prefs = await instanceFuture;
    await prefs.setString('there', value);
  }
}
