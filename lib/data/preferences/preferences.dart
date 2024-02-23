import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunrise.alarm/data/preferences/preferences_keys.dart';

class Preferences {
  Preferences._privateConstructor();

  static final Preferences _instance = Preferences._privateConstructor();

  static Preferences get instance => _instance;

  late SharedPreferences _prefs;

  initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  reload() async {
    _prefs.reload();
  }

  enableDarkMode(bool value) async {
    _prefs.setBool(PreferencesKeys.isDarkModeEnabled, value);
  }

  Future<bool> isDarkModeEnabled() async {
    return _prefs.getBool(PreferencesKeys.isDarkModeEnabled) ?? false;
  }

  Future<bool> isDarkModeSet() async {
    return _prefs.containsKey(PreferencesKeys.isDarkModeEnabled);
  }

  setLastAlarmDate(String value) async {
    _prefs.setString(PreferencesKeys.lastAlarmDate, value);
  }

  Future<String?> getLastAlarmDate() async {
    return _prefs.getString(PreferencesKeys.lastAlarmDate);
  }
}
