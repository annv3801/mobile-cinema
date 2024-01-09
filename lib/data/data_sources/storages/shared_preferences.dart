import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String userToken = 'USER_TOKEN';
  static const String accountId = 'ACCOUNT_ID';

  static Future<void> saveStringValue(String key, String value) async {
    try {
      final preferences = await SharedPreferences.getInstance();
      preferences.setString(key, value);
    } catch (e, s) {
      debugPrint("SAVE STRING $key ERROR: $e $s");
    }
  }

  static Future<String> getStringValue(String key) async {
    try {
      final preferences = await SharedPreferences.getInstance();
      final value = preferences.getString(key) ?? '';
      return value;
    } catch (e, s) {
      debugPrint("GET STRING $key ERROR: $e $s");
      return "";
    }
  }

  static Future<void> saveIntValue(String key, int value) async {
    try {
      final preferences = await SharedPreferences.getInstance();
      preferences.setInt(key, value);
    } catch (e, s) {
      debugPrint("SAVE INT $key ERROR: $e $s");
    }
  }

  static Future<int?> getIntValue(String key) async {
    try {
      final preferences = await SharedPreferences.getInstance();
      final value = preferences.getInt(key);
      return value;
    } catch (e, s) {
      debugPrint("GET INT $key ERROR: $e $s");
      return null;
    }
  }

  static Future<void> removeByKey(String key) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove(key);
    } catch (e, s) {
      debugPrint("REMOVE $key ERROR: $e $s");
    }
  }
}
