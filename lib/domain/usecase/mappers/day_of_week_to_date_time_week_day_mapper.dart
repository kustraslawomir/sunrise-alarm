import 'package:sunrise.alarm/domain/usecase/mappers/mapper.dart';
import 'package:sunrise.alarm/ui/pages/homepage/state/alarm_state/model/day.dart';

class DayOfWeekToDateTimeWeekDayMapper extends Mapper<DayOfWeek, int> {
  @override
  int map(DayOfWeek input) {
    switch (input) {
      case DayOfWeek.monday:
        return DateTime.monday;
      case DayOfWeek.tuesday:
        return DateTime.tuesday;
      case DayOfWeek.wednesday:
        return DateTime.wednesday;
      case DayOfWeek.thursday:
        return DateTime.thursday;
      case DayOfWeek.friday:
        return DateTime.friday;
      case DayOfWeek.saturday:
        return DateTime.saturday;
      case DayOfWeek.sunday:
        return DateTime.sunday;
    }
  }
}
