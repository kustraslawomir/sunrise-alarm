import 'dart:math';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sunrise.alarm/data/preferences/preferences.dart';
import 'package:sunrise.alarm/domain/usecase/sunrise/app_logger.dart';
import 'package:sunrise.alarm/domain/usecase/sunrise/get_sunrise_date_use_case.dart';
import 'package:sunrise.alarm/ui/pages/homepage/home_page.dart';
import 'package:sunrise.alarm/ui/pages/homepage/state/alarm_state/model/alarm_time.dart';
import 'package:sunrise.alarm/ui/pages/homepage/state/alarm_state/model/day.dart';
import 'package:sunrise.alarm/ui/pages/wake_up/alarm_service.dart';

import '../../../../../domain/usecase/mappers/day_of_week_to_date_time_week_day_mapper.dart';
import 'model/alarm_configuration_state.dart';

part 'alarm_controller.g.dart';

@riverpod
class AlarmController extends _$AlarmController {
  static const alarmId = 999;

  final DayOfWeekToDateTimeWeekDayMapper _dayOfWeekMapper =
      DayOfWeekToDateTimeWeekDayMapper();

  AlarmController() {
    debugPrintLastAlarmDate();
  }

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
        state.schedule.map((element) => _dayOfWeekMapper.map(element)).toList();
    for (var i = 0; i < 365; i++) {
      final tempDateTime = currentDateTime.add(Duration(days: i));
      if (_dayInSchedule(tempDateTime, dateTimeSchedule)) {
        final sunriseDate =
            await getSunriseDateUseCase.invoke(position, tempDateTime);
        switch (state.alarmMoment) {
          case AlarmMoment.atSunrise:
            //do nothing
            break;
          case AlarmMoment.halfHourBeforeTheSunrise:
            sunriseDate.add(const Duration(minutes: -30));
            break;
          case AlarmMoment.halfHourAfterTheSunrise:
            sunriseDate.add(const Duration(minutes: 30));
            break;
        }
        await _setAlarm(sunriseDate);
      } else {
        AppLogger.instance.log.w(
            "${tempDateTime.day} ${tempDateTime.toString()} is out of schedule. Ignore.");
      }
    }
    state = state.copyWith(isLoading: false);
  }

  _setAlarm(DateTime sunriseDateTime) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String packageName = packageInfo.packageName;
    await AlarmService.instance.addAlarm(sunriseDateTime,
        uid: packageName, screenWakeDuration: const Duration(minutes: 1));
    AppLogger.instance.log.d("Set alarm on: ${sunriseDateTime.toString()}");

    await AndroidAlarmManager.oneShotAt(
      sunriseDateTime,
      Random().nextInt(pow(2, 31) as int),
      HomePageState.callback,
      exact: true,
      wakeup: true,
    );

    return Future.value(true);
  }

  storeLastAlarmDate(DateTime? dateTime) async {
    if (dateTime == null) {
      return;
    }
    Preferences.instance.setLastAlarmDate(dateTime.toString());
  }

  _clearCurrentAlarms() async {
    final alarms = await AlarmService.instance.getAllAlarms();
    for (var element in alarms) {
      await AlarmService.instance.deleteAlarm(element.id!);
    }
  }

  bool _dayInSchedule(DateTime date, List<int> dateTimeSchedule) {
    return dateTimeSchedule.contains(date.weekday);
  }

  debugPrintLastAlarmDate() async {
    if (!kDebugMode) {
      return;
    }
    Preferences.instance.getLastAlarmDate().then(
        (value) => AppLogger.instance.log.d("Last alarm date time: $value"));

    final closestAlarm =
        (await AlarmService.instance.getAllAlarms()).firstOrNull;
    AppLogger.instance.log.d(
        "Incoming alarm date time: ${closestAlarm?.time} ${closestAlarm?.status}");
  }

  void setDebugAlarm() {
    final debugDateTime = DateTime.now();
    debugDateTime.add(const Duration(seconds: 30));
    _setAlarm(debugDateTime);
  }
}
