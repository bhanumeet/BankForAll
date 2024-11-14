import 'package:shared_preferences/shared_preferences.dart';

const String nameKey = "name", emailKey = "email", authIDKey = "authID";

class SharedPrefs {
  SharedPrefs();

  String name, email, authID;

  Future<void> setUser(String name, String email, String authID) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();

    _prefs.setString(nameKey, name);
    _prefs.setString(emailKey, email);
    _prefs.setString(authIDKey, authID);
  }

  Future<void> getUser() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();

    name = _prefs.getString(nameKey);
    email = _prefs.getString(emailKey);
    authID = _prefs.getString(authIDKey);
  }
}
