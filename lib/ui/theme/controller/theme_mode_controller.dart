import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/preferences/preferences.dart';
import '../app_theme.dart';

part 'theme_mode_controller.g.dart';

@riverpod
class ThemeModeController extends _$ThemeModeController {
  @override
  ThemeMode build() => ThemeMode.system;

  setThemeModeAsSystemBrightness(Brightness brightness) async {
    if (await Preferences.instance.isDarkModeSet()) {
      _loadThemeMode();
      return;
    }

    final isDarkModeEnabled = brightness == Brightness.dark;
    storeThemeMode(isDarkModeEnabled);
    setState(isDarkModeEnabled);
  }

  changeThemeMode(bool isDarkModeEnabled) async {
    storeThemeMode(isDarkModeEnabled);
    setState(isDarkModeEnabled);
  }

  storeThemeMode(bool isDarkModeEnabled) {
    Preferences.instance.enableDarkMode(isDarkModeEnabled);
  }

  setState(bool isDarkModeEnabled) {
    debugPrint("is dark mode enabled: $isDarkModeEnabled");
    if (isDarkModeEnabled) {
      state = ThemeMode.dark;
    } else {
      state = ThemeMode.light;
    }
  }

  _loadThemeMode() async {
    final isDarkModeEnabled = await Preferences.instance.isDarkModeEnabled();
    setState(isDarkModeEnabled);
  }
}
