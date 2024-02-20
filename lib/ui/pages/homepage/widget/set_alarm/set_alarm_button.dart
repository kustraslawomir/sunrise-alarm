import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sunrise.alarm/ui/theme/app_theme_extensions.dart';

import '../../../../widgets/app_button.dart';
import '../../state/alarm_state/alarm_controller.dart';

class SetAlarmButton extends ConsumerWidget {
  const SetAlarmButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(alarmControllerProvider.notifier);
    final state = ref.watch(alarmControllerProvider);

    return AppButton(
        label: context.text.done,
        isEnabled: state.schedule.isNotEmpty,
        onTap: () {
          controller.setAlarm();
        });
  }
}
