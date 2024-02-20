import 'package:flutter/material.dart';

import 'app_text_extension.dart';
import 'app_typography.dart';

class AppTheme {
  static final ThemeData light = () {
    final defaultTheme = ThemeData.light();
    final textColor = lightAppColors.onBackground;
    return defaultTheme.copyWith(
        primaryColor: lightAppColors.primary,
        colorScheme: lightAppColors,
        textTheme: defaultTheme.textTheme.copyWith(
          // Note: Default text style for Text widget.
          bodyMedium: AppTypography.bodyMedium.copyWith(color: textColor),
          titleMedium: AppTypography.title.copyWith(color: textColor),
        ));
  }();

  static final ThemeData dark = () {
    final defaultTheme = ThemeData.dark();
    final textColor = darkAppColors.onBackground;
    return defaultTheme.copyWith(
        primaryColor: darkAppColors.primary,
        colorScheme: darkAppColors,
        textTheme: defaultTheme.textTheme.copyWith(
          // Note: Default text style for Text widget.
          bodyMedium: AppTypography.bodyMedium.copyWith(color: textColor),
          titleMedium: AppTypography.title.copyWith(color: textColor),
        ));
  }();

  static const lightAppColors = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFFF5D126),
    onPrimary: Color(0xFF121212),
    secondary: Color(0xFFF5D126),
    onSecondary: Color(0xFF121212),
    error: Color(0xffb00020),
    onError: Color(0xFFFCFAF7),
    background: Color(0xFFFCFAF7),
    onBackground: Color(0xFF121212),
    surface: Color(0xFFFCFAF7),
    onSurface: Color(0xFF121212),
  );

  static final lightTextTheme = AppTextThemeExtension(
    bodyMedium:
        AppTypography.bodyMedium.copyWith(color: const Color(0xFF121212)),
    titleMedium: AppTypography.title.copyWith(color: const Color(0xFF121212)),
  );

  static const darkAppColors = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFF5D126),
    onPrimary: Color(0xFF121212),
    secondary: Color(0xFFF5D126),
    onSecondary: Color(0xFF121212),
    error: Color(0xffb00020),
    onError: Color(0xFFFCFAF7),
    background: Color(0xFF121212),
    onBackground: Color(0xFFFFFFFF),
    surface: Color(0xFF121212),
    onSurface: Color(0xFFFFFFFF),
  );

  static final darkTextTheme = AppTextThemeExtension(
    bodyMedium:
        AppTypography.bodyMedium.copyWith(color: const Color(0xFFFFFFFF)),
    titleMedium: AppTypography.title.copyWith(color: const Color(0xFFFFFFFF)),
  );
}
