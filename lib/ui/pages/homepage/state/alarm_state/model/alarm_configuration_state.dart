import 'alarm_time.dart';
import 'day.dart';

class AlarmConfigurationState {
  final AlarmTime alarmTime;
  final bool repeatDaily;
  final List<DayOfWeek> schedule;

  AlarmConfigurationState(
      {required this.alarmTime,
      required this.repeatDaily,
      required this.schedule});

  static defaultState() => AlarmConfigurationState(
      alarmTime: AlarmTime.atSunrise,
      repeatDaily: true,
      schedule: DayOfWeek.values);

  AlarmConfigurationState copyWith(
      {AlarmTime? alarmTime,
      bool? repeatDaily,
      List<DayOfWeek>? schedule}) {
    return AlarmConfigurationState(
        alarmTime: alarmTime ?? this.alarmTime,
        repeatDaily: repeatDaily ?? this.repeatDaily,
        schedule: schedule ?? this.schedule);
  }
}
