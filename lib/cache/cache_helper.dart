import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

//! Here The Initialize of cache .
  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  String? getDataString({required String key}) {
    return sharedPreferences.getString(key);
  }

//! this method to put data in local database using key
  Future<bool> saveData({required String key, required dynamic value}) async {
    if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    }

    if (value is String) {
      return await sharedPreferences.setString(key, value);
    }

    if (value is int) {
      return await sharedPreferences.setInt(key, value);
    }

    if (value is double) {
      return await sharedPreferences.setDouble(key, value);
    }

    // Handle other types or return false if the type is not supported
    return false;
  }

//! this method to get data already saved in local database
  dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

//! remove data using specific key
  Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

//! this method to check if local database contains {key}
  bool containsKey({required String key}) {
    return sharedPreferences.containsKey(key);
  }

  Future<bool> clearData() async {
    return await sharedPreferences.clear();
  }

//! this fun to put data in local data base using key
  Future<dynamic> put({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await sharedPreferences.setString(key, value);
    } else if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    } else if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else if (value is double) {
      return await sharedPreferences.setDouble(key, value);
    }

    // Handle other types or return false if the type is not supported
    return false;
  }

// Save JSON data
  Future<bool> saveJsonData({
    required String key,
    required Map<String, dynamic> value,
  }) async {
    return await sharedPreferences.setString(key, jsonEncode(value));
  }

  // Get JSON data
  Map<String, dynamic>? getJsonData({required String key}) {
    String? jsonString = sharedPreferences.getString(key);
    if (jsonString != null) {
      return Map<String, dynamic>.from(jsonDecode(jsonString));
    }
    return null;
  }
}
