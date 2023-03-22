import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static final Preferences _instance = Preferences._();

  factory Preferences() {
    return _instance;
  }

  Preferences._();

  static Preferences get instance => _instance;
  SharedPreferences? prefs;

  static String isOn = 'isOn';

  Future<void> initialAppPreference() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future setString(String key, String value) async {
    await prefs?.setString(key, value);
  }

  Future setInt(String key, int value) async {
    await prefs?.setInt(key, value);
  }

  Future setBool(String key, bool value) async {
    await prefs?.setBool(key, value);
  }

  getBool(String key, int value) {
    return prefs?.getBool(key);
  }
  //  Future setSelectLeague(List<String> value) async {
  //   await prefs?.setStringList(setSelectLeagueData, value);
  // }

  String getString(String key) {
    return prefs?.getString(key) ?? "";
  }

  int getInt(String key) {
    return prefs?.getInt(key) ?? 0;
  }

  //  List<String> getSelectLeague() {
  //   return prefs?.getStringList(setSelectLeagueData) ?? [];
  // }

  void clearSharedPreferences() {
    prefs?.clear();
  }
}
