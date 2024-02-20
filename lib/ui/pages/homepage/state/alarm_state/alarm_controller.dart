import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sunrise.alarm/ui/pages/homepage/state/alarm_state/model/alarm_schedule.dart';

import 'model/alarm_time_state.dart';

part 'alarm_controller.g.dart';

@riverpod
class AlarmTimeController extends _$AlarmTimeController {
  @override
  AlarmState build() => AlarmState.defaultState();

  setAlarmSchedule(AlarmSchedule alarmSchedule) {
    state = state.copyWith(alarmSchedule: alarmSchedule);
  }
}
