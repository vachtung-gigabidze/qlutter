import 'settings_persistence.dart';

/// An in-memory implementation of [SettingsPersistence].
/// Useful for testing.
class MemoryOnlySettingsPersistence implements SettingsPersistence {
  String theme = 'light';

  String language = 'Русский';

  @override
  Future<String> getTheme({required String defaultValue}) async => theme;

  @override
  Future<String> getLanguage({required String defaultValue}) async => language;

  @override
  Future<void> saveLanguage(String value) async => language = value;

  @override
  Future<void> saveTheme(String value) async => theme = value;
}
