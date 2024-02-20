import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sunrise.alarm/ui/pages/homepage/state/alarm_state/alarm_controller.dart';
import 'package:sunrise.alarm/ui/pages/homepage/state/alarm_state/model/day.dart';
import 'package:sunrise.alarm/ui/theme/app_theme_extensions.dart';
import 'package:sunrise.alarm/ui/widgets/app_switch.dart';

class RepeatDaily extends ConsumerWidget {
  const RepeatDaily({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(alarmControllerProvider.notifier);
    final state = ref.watch(alarmControllerProvider);

    return AppSwitch(
        label: context.text.repeat_daily,
        isChecked: state.repeatDaily,
        onChanged: (isChecked) {
          controller.setRepeatDaily(isChecked);
          if (isChecked) {
            controller.setSchedule(DayOfWeek.values);
          } else {
            controller.setSchedule(List.empty(growable: true));
          }
        });
  }
}
