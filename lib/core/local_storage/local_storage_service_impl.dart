import 'package:shared_preferences/shared_preferences.dart';

import 'local_storage_service.dart';

class LocalStorageServiceImpl implements LocalStorageService {
  LocalStorageServiceImpl();
  SharedPreferences? _preferences;

  @override
  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  @override
  Future<void> clear() async {
    await _preferences?.clear();
  }

  @override
  Future<void> setValue<T>(String key, T value) async {
    _preferences ??= await SharedPreferences.getInstance();
    if (value is int) await _preferences?.setInt(key, value);
    if (value is double) await _preferences?.setDouble(key, value);
    if (value is bool) await _preferences?.setBool(key, value);
    if (value is String) await _preferences?.setString(key, value);
    if (value is List<String>) await _preferences?.setStringList(key, value);
  }

  @override
  Future<T?> getValue<T>(String key) async {
    _preferences ??= await SharedPreferences.getInstance();
    final value = _preferences?.get(key);
    if (value is T) return value;
    return null;
  }

  @override
  Future<void> deleteValue(String key) async {
    _preferences ??= await SharedPreferences.getInstance();
    await _preferences?.remove(key);
  }
}
