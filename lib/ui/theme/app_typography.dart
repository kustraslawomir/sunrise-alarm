import 'package:flutter/cupertino.dart';

import '../../generated/fonts.gen.dart';

abstract class AppTypography {
  static const String appFont = FontFamily.sora;

  static const bodyMedium = TextStyle(
      fontSize: 16, fontFamily: appFont, fontWeight: FontWeight.normal);

  static const title =
      TextStyle(fontSize: 19, fontFamily: appFont, fontWeight: FontWeight.w800);
}
