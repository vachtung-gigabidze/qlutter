abstract class SettingsPersistence {
  Future<String> getTheme({required String defaultValue});

  Future<String> getLanguage({required String defaultValue});

  Future<void> saveTheme(String value);

  Future<void> saveLanguage(String value);
}
