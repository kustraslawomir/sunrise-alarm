import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunrise.alarm/ui/theme/app_theme_extensions.dart';

import '../../../../theme/dimensions.dart';

class SelectableRadioButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectableRadioButton(
      {super.key,
      required this.label,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: Dimensions.buttonMargin),
        padding: const EdgeInsets.all(Dimensions.buttonPadding),
        decoration: BoxDecoration(
          border: Border.all(
              color: isSelected
                  ? context.theme.colorScheme.primary
                  : context.theme.dividerColor),
          borderRadius: BorderRadius.circular(Dimensions.cornerRadius),
        ),
        child: Text(
          label,
          style: context.theme.textTheme.bodyMedium,
        ),
      ),
    );
  }
}
