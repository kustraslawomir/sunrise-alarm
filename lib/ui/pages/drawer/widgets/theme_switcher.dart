import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sunrise.alarm/ui/theme/app_theme_extensions.dart';
import 'package:sunrise.alarm/ui/theme/controller/theme_mode_controller.dart';

class ThemeSwitcher extends ConsumerWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.read(themeModeControllerProvider);
    final controller = ref.read(themeModeControllerProvider.notifier);
    return Row(children: [
      Text(context.text.dark_mode, style: context.theme.textTheme.bodyMedium),
      const Spacer(),
      Switch(
          value: state == ThemeMode.dark,
          onChanged: (isChecked) {
            controller.changeThemeMode(isChecked);
          })
    ]);
  }
}
