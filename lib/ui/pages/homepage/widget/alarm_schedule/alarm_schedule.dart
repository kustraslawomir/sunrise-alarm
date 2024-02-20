import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sunrise.alarm/ui/pages/homepage/state/alarm_state/alarm_controller.dart';
import 'package:sunrise.alarm/ui/pages/homepage/state/alarm_state/model/day.dart';
import 'package:sunrise.alarm/ui/theme/dimensions.dart';

import 'day_of_week_item.dart';

class AlarmSchedule extends ConsumerWidget {
  const AlarmSchedule({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(alarmTimeControllerProvider);
    const days = DayOfWeek.values;
    return SizedBox(
        height: Dimensions.dayOfTheWeekItemHeight,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: days.length,
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(width: Dimensions.separatorWidth),
          itemBuilder: (context, index) {
            return DayOfWeekItem(
              dayOfWeek: days[index],
              isSelected: state.schedule.contains(days[index]),
            );
          },
        ));
  }
}
