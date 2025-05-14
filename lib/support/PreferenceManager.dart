import 'dart:convert';

import 'package:nikitchem/screens/model/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/constant_string.dart';

class PreferenceManager {
  PreferenceManager._privateConstructor();
  static final PreferenceManager instance = PreferenceManager._privateConstructor();

  Future<bool> setString(String key, String value) async {
    print("$key--$value");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  Future<String> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "";
  }

  Future<LoginModel> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? loginString = prefs.getString(ConstantString.loginKey);
    print('getUserDetails: $loginString');

    if (loginString == null || loginString.isEmpty) {
      return LoginModel();
    }
    try {
      return LoginModel.fromJson(jsonDecode(loginString));
    } catch (e) {
      print('Error decoding user details: $e');
      return LoginModel();
    }
  }

  Future<bool> setUserDetails(Map<String, dynamic> userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(ConstantString.loginKey, jsonEncode(userData));
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}