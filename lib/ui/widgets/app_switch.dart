import 'package:flutter/material.dart';
import 'package:sunrise.alarm/ui/theme/app_theme_extensions.dart';

class AppSwitch extends StatelessWidget {
  final String label;
  final bool isChecked;
  final Function(bool) onChanged;

  const AppSwitch({
    required this.label,
    required this.isChecked,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(label, style: context.theme.textTheme.bodyMedium),
      const Spacer(),
      Switch(
          value: isChecked,
          onChanged: (isChecked) {
            onChanged(isChecked);
          })
    ]);
  }
}
