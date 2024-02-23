import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sunrise.alarm/ui/pages/homepage/state/alarm_state/alarm_controller.dart';
import 'package:sunrise.alarm/ui/pages/homepage/state/alarm_state/model/alarm_time.dart';
import 'package:sunrise.alarm/ui/pages/homepage/widget/spacing/vertical_spacing.dart';
import 'package:sunrise.alarm/ui/theme/app_theme_extensions.dart';

import 'selecatble_radio_button.dart';

class AlarmTimeRadioGroup extends ConsumerWidget {
  const AlarmTimeRadioGroup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(alarmControllerProvider);
    final controller = ref.watch(alarmControllerProvider.notifier);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(context.text.wake_me_up_title,
          style: context.theme.textTheme.bodyMedium),
      const VerticalSpacing(size: VerticalSpacingSize.small),
      SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: [
            SelectableRadioButton(
              label: context.text.at_sunrise,
              onTap: () => controller.setAlarmMoment(AlarmMoment.atSunrise),
              isSelected: state.alarmMoment == AlarmMoment.atSunrise,
            ),
            SelectableRadioButton(
              label: context.text.half_hour_before,
              onTap: () => controller
                  .setAlarmMoment(AlarmMoment.halfHourBeforeTheSunrise),
              isSelected:
                  state.alarmMoment == AlarmMoment.halfHourBeforeTheSunrise,
            ),
            SelectableRadioButton(
              label: context.text.half_hour_after,
              onTap: () => controller
                  .setAlarmMoment(AlarmMoment.halfHourAfterTheSunrise),
              isSelected:
                  state.alarmMoment == AlarmMoment.halfHourAfterTheSunrise,
            )
          ]))
    ]);
  }
}
