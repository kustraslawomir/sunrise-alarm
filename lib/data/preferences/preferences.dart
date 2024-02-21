import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunrise.alarm/data/preferences/preferences_keys.dart';

class Preferences {
  Preferences._privateConstructor();

  static final Preferences _instance = Preferences._privateConstructor();

  static Preferences get instance => _instance;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  enableDarkMode(bool value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool(PreferencesKeys.isDarkModeEnabled, value);
  }

  Future<bool> containsAlarmCount() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.containsKey(PreferencesKeys.alarmCount);
  }

  setAlarmCount(int value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setInt(PreferencesKeys.alarmCount, value);
  }

  Future<bool> isDarkModeEnabled() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool(PreferencesKeys.isDarkModeEnabled) ?? false;
  }

  Future<int> getAlarmCount() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getInt(PreferencesKeys.alarmCount) ?? 0;
  }

  Future<bool> isDarkModeSet() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.containsKey(PreferencesKeys.isDarkModeEnabled);
  }

  reload() async {
    final SharedPreferences prefs = await _prefs;
    prefs.reload();
  }
}
