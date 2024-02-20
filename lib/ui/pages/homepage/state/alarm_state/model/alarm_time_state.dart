import 'alarm_schedule.dart';
import 'day.dart';

class AlarmState {
  final AlarmSchedule alarmSchedule;
  final bool repeatDaily;
  final List<DayOfWeek> daysOfWeek;

  AlarmState(
      {required this.alarmSchedule,
      required this.repeatDaily,
      required this.daysOfWeek});

  static defaultState() => AlarmState(
      alarmSchedule: AlarmSchedule.atSunrise,
      repeatDaily: true,
      daysOfWeek: DayOfWeek.values);

  AlarmState copyWith(
      {AlarmSchedule? alarmSchedule,
      bool? repeatDaily,
      List<DayOfWeek>? daysOfWeek}) {
    return AlarmState(
        alarmSchedule: alarmSchedule ?? this.alarmSchedule,
        repeatDaily: repeatDaily ?? this.repeatDaily,
        daysOfWeek: daysOfWeek ?? this.daysOfWeek);
  }
}
