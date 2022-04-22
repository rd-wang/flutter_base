import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  static SharedPreferences? _sharedPreferences;

  static Future<bool> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return true;
  }

  static String? getString(String key) {
    if (_sharedPreferences == null) throw new Exception("SharedPreferences 未初始化 请在使用之前 请调用 init()");
    return _sharedPreferences!.getString(key);
  }

  static Future<bool> setString(String key, String value) {
    if (_sharedPreferences == null) throw new Exception("SharedPreferences 未初始化 请在使用之前 请调用 init()");
    return _sharedPreferences!.setString(key, value);
  }

  static bool getBool(String key) {
    if (_sharedPreferences == null) throw new Exception("SharedPreferences 未初始化 请在使用之前 请调用 init()");
    return _sharedPreferences!.getBool(key) ?? false;
  }

  static Future<bool> setBool(String key, bool value) {
    if (_sharedPreferences == null) throw new Exception("SharedPreferences 未初始化 请在使用之前 请调用 init()");
    return _sharedPreferences!.setBool(key, value);
  }

  static int? getInt(String key) {
    if (_sharedPreferences == null) throw new Exception("SharedPreferences 未初始化 请在使用之前 请调用 init()");
    return _sharedPreferences!.getInt(key);
  }

  static Future<bool> setInt(String key, int value) {
    if (_sharedPreferences == null) throw new Exception("SharedPreferences 未初始化 请在使用之前 请调用 init()");
    return _sharedPreferences!.setInt(key, value);
  }

  static Future<bool> clear(String key) {
    if (_sharedPreferences == null) throw new Exception("SharedPreferences 未初始化 请在使用之前 请调用 init()");
    return _sharedPreferences!.remove(key);
  }
}
