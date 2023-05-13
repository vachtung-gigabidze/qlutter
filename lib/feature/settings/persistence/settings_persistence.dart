abstract class SettingsPersistence {
  Future<String> getTheme();

  Future<String> getLanguage();

  Future<void> saveTheme(String value);

  Future<void> saveLanguage(String value);
}
