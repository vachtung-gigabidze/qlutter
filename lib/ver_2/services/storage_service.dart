// services/storage_service.dart
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _currentLevelKey = 'current_level';
  static const String _maxLevelKey = 'max_level';
  
  static Future<SharedPreferences> get _prefs async => 
      await SharedPreferences.getInstance();
  
  static Future<int> getCurrentLevel() async {
    final prefs = await _prefs;
    return prefs.getInt(_currentLevelKey) ?? 1;
  }
  
  static Future<void> setCurrentLevel(int level) async {
    final prefs = await _prefs;
    await prefs.setInt(_currentLevelKey, level);
    
    final maxLevel = await getMaxLevel();
    if (level > maxLevel) {
      await prefs.setInt(_maxLevelKey, level);
    }
  }
  
  static Future<int> getMaxLevel() async {
    final prefs = await _prefs;
    return prefs.getInt(_maxLevelKey) ?? 1;
  }
}