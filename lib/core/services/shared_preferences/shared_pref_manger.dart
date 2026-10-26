import 'package:shared_preferences/shared_preferences.dart';

class PrefManger {
  static final PrefManger _instance = PrefManger._internal();

  factory SharedPrefManger() {
    return _instance;
  }

  PrefManger._internal();

  late final SharedPreferences _preferences;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  String? getString(String key) {
    return _preferences.getString(key);
  }

  Future<bool> setString(String key, String value) async {
    return await _preferences.setString(key, value);
  }

  int? getInt(String key) {
    return _preferences.getInt(key);
  }

  Future<bool> setInt(String key, int value) async {
    return await _preferences.setInt(key, value);
  }

  double? getDouble(String key) {
    return _preferences.getDouble(key);
  }

  Future<bool> setDouble(String key, double value) async {
    return await _preferences.setDouble(key, value);
  }

  bool? getBool(String key) {
    return _preferences.getBool(key);
  }

  Future<bool> setBool(String key, bool value) async {
    return await _preferences.setBool(key, value);
  }

  remove(String key) async {
    return await _preferences.remove(key);
  }

  clear() async {
    await _preferences.clear();
  }
}
