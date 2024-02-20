import 'package:flutter/material.dart';
import 'package:sunrise.alarm/ui/theme/app_theme_extensions.dart';

import '../theme/dimensions.dart';

class AppButton extends StatelessWidget {
  final String label;
  final bool isEnabled;
  final Function onTap;

  const AppButton(
      {super.key,
      required this.label,
      required this.isEnabled,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.cornerRadius),
                ),
              ),
              backgroundColor: isEnabled
                  ? MaterialStateProperty.all<Color>(context.theme.primaryColor)
                  : MaterialStateProperty.all<Color>(
                      context.theme.disabledColor)),
          onPressed: () {
            if (isEnabled) {
              onTap();
            }
          },
          child: Text(label, style: context.theme.textTheme.labelMedium),
        ));
  }
}
