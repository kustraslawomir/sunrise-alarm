import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sunrise.alarm/data/preferences/preferences.dart';
import 'package:sunrise.alarm/domain/usecase/sunrise/app_logger.dart';
import 'package:sunrise.alarm/domain/usecase/sunrise/get_sunrise_date_use_case.dart';
import 'package:sunrise.alarm/ui/pages/homepage/state/alarm_state/model/alarm_time.dart';
import 'package:sunrise.alarm/ui/pages/homepage/state/alarm_state/model/day.dart';
import 'package:sunrise.alarm/ui/pages/wake_up/alarm_service.dart';

import 'model/alarm_configuration_state.dart';

part 'alarm_controller.g.dart';

@riverpod
class AlarmController extends _$AlarmController {
  static const alarmId = 999;
  static const androidAlarmManagerId = 888;

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

  setAlarmMoment(AlarmMoment alarmMoment) {
    state = state.copyWith(alarmTime: alarmMoment);
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

  prepareAlarmSchedule() async {
    final position = state.position;
    if (position == null) {
      return;
    }

    state = state.copyWith(isLoading: true);
    final getSunriseDateUseCase = ref.read(getSunriseDateUseCaseProvider);
    await _clearCurrentAlarms();
    final currentDateTime = DateTime.now();
    final dateTimeSchedule =
        state.schedule.map((e) => dayOfWeekToDateTimeDayNumber(e)).toList();
    for (var i = 0; i < 356; i++) {
      final tempDateTime = currentDateTime.add(Duration(days: i));
      debugPrint("temp date: ${tempDateTime.toString()}");
      if (dayInSchedule(tempDateTime, dateTimeSchedule)) {
        final sunriseDate =
            await getSunriseDateUseCase.invoke(position, tempDateTime);
        switch (state.alarmMoment) {
          case AlarmMoment.atSunrise:
            //ignore
            break;
          case AlarmMoment.halfHourBeforeTheSunrise:
            sunriseDate.add(const Duration(minutes: -30));
            break;
          case AlarmMoment.halfHourAfterTheSunrise:
            sunriseDate.add(const Duration(minutes: 30));
            break;
        }
        await _setAlarm(sunriseDate);
      }else{
        AppLogger.instance.logger.w("${tempDateTime.day} ${tempDateTime.toString()} is out of schedule. Ignore.");
      }
    }
    state = state.copyWith(isLoading: false);
  }

  _setAlarm(DateTime sunriseDateTime) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String packageName = packageInfo.packageName;
    await AlarmService.instance.addAlarm(sunriseDateTime,
        uid: packageName, screenWakeDuration: const Duration(minutes: 1));
    AppLogger.instance.logger.d("Set alarm on: ${sunriseDateTime.toString()}");
    return Future.value(true);
  }

  storeLastAlarmDate(DateTime? dateTime) async {
    if (dateTime == null) {
      return;
    }
    Preferences.instance.setLastAlarmDate(dateTime.toString());
  }

  debugPrintLastAlarmDate() async {
    Preferences.instance
        .getLastAlarmDate()
        .then((value) => debugPrint("Last alarm date: $value"));
  }

  _clearCurrentAlarms() async {
    final alarms = await AlarmService.instance.getAllAlarms();
    for (var element in alarms) {
      await AlarmService.instance.deleteAlarm(element.id!);
    }
  }

  bool dayInSchedule(DateTime date, List<int> dateTimeSchedule) {
    return dateTimeSchedule.contains(date.weekday);
  }

  int dayOfWeekToDateTimeDayNumber(DayOfWeek dayOfWeek) {
    switch (dayOfWeek) {
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
