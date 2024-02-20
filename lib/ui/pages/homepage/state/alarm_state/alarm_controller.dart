import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sunrise.alarm/ui/pages/homepage/state/alarm_state/model/alarm_time.dart';
import 'package:sunrise.alarm/ui/pages/homepage/state/alarm_state/model/day.dart';

import 'model/alarm_configuration_state.dart';

part 'alarm_controller.g.dart';

@riverpod
class AlarmTimeController extends _$AlarmTimeController {
  @override
  AlarmConfigurationState build() => AlarmConfigurationState.defaultState();

  setAlarmSchedule(AlarmTime alarmTime) {
    state = state.copyWith(alarmTime: alarmTime);
  }

  setRepeatDaily(bool repeatDaily) {
    state = state.copyWith(repeatDaily: repeatDaily);
  }

  setSchedule(List<DayOfWeek> schedule) {
    state = state.copyWith(schedule: schedule);
  }

  void toggleScheduleDay(DayOfWeek dayOfWeek) {
    final schedule = state.schedule;
    if (schedule.contains(dayOfWeek)) {
      schedule.remove(dayOfWeek);
      state = state.copyWith(schedule: schedule);
    } else {
      schedule.add(dayOfWeek);
      state = state.copyWith(schedule: schedule);
    }
  }
}
