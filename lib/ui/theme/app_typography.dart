import 'package:flutter/cupertino.dart';

import '../../generated/fonts.gen.dart';

abstract class AppTypography {
  static const String appFont = FontFamily.sora;

  static const bodyMedium = TextStyle(
      fontSize: 14, fontFamily: appFont, fontWeight: FontWeight.normal);

  static const titleMedium =
      TextStyle(fontSize: 18, fontFamily: appFont, fontWeight: FontWeight.w800);

  static const labelMedium =
      TextStyle(fontSize: 14, fontFamily: appFont, fontWeight: FontWeight.w800);
}
