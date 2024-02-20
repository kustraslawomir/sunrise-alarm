import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sunrise.alarm/ui/pages/homepage/state/alarm_state/alarm_controller.dart';
import 'package:sunrise.alarm/ui/theme/app_theme_extensions.dart';

import '../../../../theme/dimensions.dart';
import '../../state/alarm_state/model/day.dart';

class DayOfWeekItem extends ConsumerWidget {
  final DayOfWeek dayOfWeek;
  final bool isSelected;

  const DayOfWeekItem({Key? key, required this.dayOfWeek, required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(alarmControllerProvider.notifier);

    String label = '';
    switch (dayOfWeek) {
      case DayOfWeek.monday:
        label = context.text.monday;
        break;
      case DayOfWeek.tuesday:
        label = context.text.tuesday;
        break;
      case DayOfWeek.wednesday:
        label = context.text.wednesday;
        break;
      case DayOfWeek.thursday:
        label = context.text.thursday;
        break;
      case DayOfWeek.friday:
        label = context.text.friday;
        break;
      case DayOfWeek.saturday:
        label = context.text.saturday;
        break;
      case DayOfWeek.sunday:
        label = context.text.sunday;
        break;
    }
    return GestureDetector(
      onTap: () {
        controller.toggleScheduleDay(dayOfWeek);
      },
        child: Container(
      height: Dimensions.dayOfTheWeekItemHeight,
      width: Dimensions.dayOfTheWeekItemHeight,
      decoration: BoxDecoration(
        border: Border.all(
            color: isSelected
                ? context.theme.primaryColor
                : context.theme.dividerColor),
        borderRadius: BorderRadius.circular(Dimensions.cornerRadius),
      ),
      child:
          Center(child: Text(label, style: context.theme.textTheme.bodySmall)),
    ));
  }
}
