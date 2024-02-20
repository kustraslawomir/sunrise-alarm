import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sunrise.alarm/ui/theme/app_theme_extensions.dart';
import 'package:sunrise.alarm/ui/theme/controller/theme_mode_controller.dart';

import '../../../widgets/app_switch.dart';

class ThemeSwitcher extends ConsumerWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(themeModeControllerProvider);
    final controller = ref.read(themeModeControllerProvider.notifier);
    return AppSwitch(
      label: context.text.dark_mode,
      isChecked: state == ThemeMode.dark,
      onChanged: (isSelected) {
        controller.changeThemeMode(isSelected);
      },
    );
  }
}
