import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sunrise.alarm/ui/pages/homepage/state/alarm_state/alarm_controller.dart';
import 'package:sunrise.alarm/ui/pages/homepage/state/alarm_state/model/alarm_schedule.dart';
import 'package:sunrise.alarm/ui/pages/homepage/state/alarm_state/model/alarm_time_state.dart';
import 'package:sunrise.alarm/ui/pages/homepage/widget/alarm_time/selecatble_radio_button.dart';
import 'package:sunrise.alarm/ui/theme/app_theme_extensions.dart';

import '../../../../theme/dimensions.dart';

class AlarmTimeRadioGroup extends ConsumerWidget {
  const AlarmTimeRadioGroup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AlarmState state = ref.watch(alarmTimeControllerProvider);
    final controller = ref.watch(alarmTimeControllerProvider.notifier);
    return Container(
        margin: const EdgeInsets.only(top: Dimensions.verticalWidgetSpacing),
        child: Row(children: [
          SelectableRadioButton(
            label: context.text.at_sunrise,
            onTap: () => controller.setAlarmSchedule(AlarmSchedule.atSunrise),
            isSelected: state.alarmSchedule == AlarmSchedule.atSunrise,
          ),
          SelectableRadioButton(
            label: context.text.half_hour_before,
            onTap: () => controller
                .setAlarmSchedule(AlarmSchedule.halfHourBeforeTheSunrise),
            isSelected:
                state.alarmSchedule == AlarmSchedule.halfHourBeforeTheSunrise,
          )
        ]));
  }
}
