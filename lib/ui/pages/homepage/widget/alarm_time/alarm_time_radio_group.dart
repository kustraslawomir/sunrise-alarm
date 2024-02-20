import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sunrise.alarm/ui/pages/homepage/state/alarm_state/alarm_controller.dart';
import 'package:sunrise.alarm/ui/pages/homepage/state/alarm_state/model/alarm_time.dart';
import 'package:sunrise.alarm/ui/theme/app_theme_extensions.dart';

import 'selecatble_radio_button.dart';

class AlarmTimeRadioGroup extends ConsumerWidget {
  const AlarmTimeRadioGroup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(alarmControllerProvider);
    final controller = ref.watch(alarmControllerProvider.notifier);
    return Row(children: [
      SelectableRadioButton(
        label: context.text.at_sunrise,
        onTap: () => controller.setAlarmSchedule(AlarmTime.atSunrise),
        isSelected: state.alarmTime == AlarmTime.atSunrise,
      ),
      SelectableRadioButton(
        label: context.text.half_hour_before,
        onTap: () =>
            controller.setAlarmSchedule(AlarmTime.halfHourBeforeTheSunrise),
        isSelected:
            state.alarmTime == AlarmTime.halfHourBeforeTheSunrise,
      )
    ]);
  }
}
