

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceSingleton {
  static final SharedPreferenceSingleton instance =
  SharedPreferenceSingleton._internal();
  factory SharedPreferenceSingleton() => instance;
  SharedPreferenceSingleton._internal();

  String TOKEN = "TOKEN";

  void setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(TOKEN, token);

  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(TOKEN) ?? "";
  }
}