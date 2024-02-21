
import 'package:alarm/alarm.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sunrise.alarm/ui/pages/homepage/state/alarm_state/model/alarm_time.dart';
import 'package:sunrise.alarm/ui/pages/homepage/state/alarm_state/model/day.dart';

import 'model/alarm_configuration_state.dart';

part 'alarm_controller.g.dart';

@riverpod
class AlarmController extends _$AlarmController {
  static const alarmId = 999;

  @override
  AlarmConfigurationState build() => AlarmConfigurationState.defaultState();

  void setAlarmPosition(Position? position) {
    state = state.copyWith(position: position);
  }

  void setSunriseDateTime(DateTime? sunriseDateTime) {
    state = state.copyWith(sunriseDateTime: sunriseDateTime);
  }

  void setAddress(String? address) {
    state = state.copyWith(address: address);
  }

  setAlarmSchedule(AlarmTime alarmTime) {
    state = state.copyWith(alarmTime: alarmTime);
  }

  setRepeatDaily(bool repeatDaily) {
    state = state.copyWith(repeatDaily: repeatDaily);
  }

  setSchedule(List<DayOfWeek> schedule) {
    state = state.copyWith(schedule: schedule);
  }

  toggleScheduleDay(DayOfWeek dayOfWeek) {
    final schedule = state.schedule;
    if (schedule.contains(dayOfWeek)) {
      schedule.remove(dayOfWeek);
      state = state.copyWith(schedule: schedule);
    } else {
      schedule.add(dayOfWeek);
      state = state.copyWith(schedule: schedule);
    }
  }

  prepareAlarm(String title, String description, Function callback) async {
    final now = DateTime.now();
    final test = now.add(const Duration(seconds: 5));
    _startAlarm(test, title, description, callback);
  }

  stopAlarm() async {
    await Alarm.stop(alarmId);
  }

  _startAlarm(DateTime dateTime, String title, String description,
      Function callback) async {
    state = state.copyWith(isLoading: true);
    await Alarm.setNotificationOnAppKillContent(title, description);
    final alarmSettings = AlarmSettings(
      id: alarmId,
      dateTime: dateTime,
      assetAudioPath: 'assets/audio/alarm.mp3',
      loopAudio: true,
      vibrate: false,
      volume: 0.1,
      fadeDuration: 10.0,
      notificationTitle: title,
      notificationBody: description,
      enableNotificationOnKill: true,
    );

    await Alarm.set(alarmSettings: alarmSettings);
    state = state.copyWith(isLoading: false);
    FlutterForegroundTask.minimizeApp();
  }
}
