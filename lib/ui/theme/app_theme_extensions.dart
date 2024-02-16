import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import 'app_colors_extension.dart';
import 'app_text_extension.dart';
import 'app_theme.dart';

extension AppThemeExtension on ThemeData {
  AppTextThemeExtension get appTextTheme =>
      extension<AppTextThemeExtension>() ?? AppTheme.lightTextTheme;
}

extension ThemeGetter on BuildContext {
  // Usage example: `context.theme`
  ThemeData get theme => Theme.of(this);
}

extension AppColorsGetter on BuildContext {
  // Usage example: `context.theme`
  ColorScheme get colors => Theme.of(this).colorScheme;
}

extension TextGetter on BuildContext {
  // Usage example: `context.theme`
  S get text => S.of(this);
}
