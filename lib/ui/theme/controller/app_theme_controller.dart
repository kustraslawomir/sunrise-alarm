import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../app_theme.dart';

part 'app_theme_controller.g.dart';

@riverpod
class AppThemeController extends _$AppThemeController {
  @override
  ThemeMode build() => ThemeMode.system;

  void set(ThemeMode themeMode) {
    state = themeMode;
  }

  void setDarkMode(bool darkMode) {
    if (darkMode) {
      state = ThemeMode.dark;
    } else {
      state = ThemeMode.light;
    }
  }
}
