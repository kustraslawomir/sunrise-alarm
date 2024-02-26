import 'dart:isolate';
import 'dart:ui';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_alarm_background_trigger/flutter_alarm_background_trigger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunrise.alarm/domain/usecase/sunrise/app_logger.dart';
import 'package:sunrise.alarm/ui/pages/drawer/drawer_page.dart';
import 'package:sunrise.alarm/ui/pages/homepage/state/alarm_state/alarm_controller.dart';
import 'package:sunrise.alarm/ui/pages/homepage/state/home_page_state/determine_sunrise_data_controller.dart';
import 'package:sunrise.alarm/ui/pages/homepage/widget/alarm_schedule/alarm_schedule.dart';
import 'package:sunrise.alarm/ui/pages/homepage/widget/debug/debug_alarm_set.dart';
import 'package:sunrise.alarm/ui/pages/homepage/widget/debug/debug_wake_up_button.dart';
import 'package:sunrise.alarm/ui/pages/homepage/widget/set_alarm/set_alarm_button.dart';
import 'package:sunrise.alarm/ui/pages/homepage/widget/spacing/vertical_spacing.dart';
import 'package:sunrise.alarm/ui/widgets/loading_page.dart';

import '../../../main.dart';
import '../../theme/dimensions.dart';
import '../wake_up/alarm_service.dart';
import '../wake_up/wake_up_page.dart';
import 'widget/alarm_time/alarm_time_radio_group.dart';
import 'widget/app_bar/app_bar_title.dart';
import 'widget/repeat_daily/repeat_daily.dart';
import 'widget/sunrise_time_description/sunrise_time_description.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final controller =
          ref.read(determinesSunriseDataControllerProvider.notifier);
      controller.determineSunriseData(_setSunriseData);
    });

    _reloadAlarmsOnAppResume();

    AlarmService.instance.onForegroundAlarmEventHandler((alarmItem) {
      Future.delayed(const Duration(seconds: 3), () {
        _reloadAlarms();
      });
    });

    AndroidAlarmManager.initialize();
    port.listen((_) async {
      Future.delayed(const Duration(seconds: 3), () {
        _reloadAlarms();
      });
    });
  }

  static SendPort? uiSendPort;

  @pragma('vm:entry-point')
  static Future<void> callback() async {
    final prefs = await SharedPreferences.getInstance();
    final currentCount = prefs.getInt(countKey) ?? 0;
    await prefs.setInt(countKey, currentCount + 1);

    uiSendPort ??= IsolateNameServer.lookupPortByName(isolateName);
    uiSendPort?.send(null);
    AppLogger.instance.log.d('Alarm fired!');
  }

  @override
  Widget build(BuildContext context) {
    final determineSunriseDataState =
        ref.watch(determinesSunriseDataControllerProvider);
    final alarmConfigState = ref.watch(alarmControllerProvider);
    if (determineSunriseDataState.isLoading) {
      return const LoadingPage();
    }
    return Scaffold(
        appBar: AppBar(centerTitle: true, title: const AppBarTitle()),
        drawer: const Drawer(child: DrawerPage()),
        body: Padding(
            padding: const EdgeInsets.all(Dimensions.appPadding),
            child: Center(
                child: Column(children: [
              const SunriseTimeDescription(),
              const VerticalSpacing(size: VerticalSpacingSize.large),
              const AlarmTimeRadioGroup(),
              const VerticalSpacing(),
              const RepeatDaily(),
              if (!alarmConfigState.repeatDaily) const VerticalSpacing(),
              if (!alarmConfigState.repeatDaily) const AlarmSchedule(),
              const Spacer(),
              const DebugWakeUpButton(),
              const DebugAlarmSetButton(),
              const SetAlarmButton()
            ]))));
  }

  _setSunriseData(
      {Position? position, DateTime? sunriseDateTime, String? address}) {
    final controller = ref.read(alarmControllerProvider.notifier);
    controller.setAlarmPosition(position);
    controller.setSunriseDateTime(sunriseDateTime);
    controller.setAddress(address);
  }

  _reloadAlarms() async {
    final allAlarms = await AlarmService.instance.getAllAlarms();
    for (var element in allAlarms) {
      AppLogger.instance.log.i(
          "Alarm on: ${element.time?.toString()} has ${element.status.name} status.");
    }
    final doneAlarms =
        allAlarms.where((element) => element.status == AlarmStatus.DONE);

    if (doneAlarms.isEmpty) {
      return;
    }

    for (var doneAlarm in doneAlarms) {
      await AlarmService.instance.deleteAlarm(doneAlarm.id!);
    }
    _pushWakeUpPage(doneAlarms.first);
  }

  void _reloadAlarmsOnAppResume() {
    SystemChannels.lifecycle.setMessageHandler((state) {
      debugPrint('App lifecycle state: $state');
      if (state == AppLifecycleState.resumed.toString()) {
        _reloadAlarms();
      }

      return Future.value(state);
    });
  }

  Future<dynamic> _pushWakeUpPage(AlarmItem alarmItem) {
    final alarmController = ref.read(alarmControllerProvider.notifier);
    alarmController.storeLastAlarmDate(alarmItem.time);
    return Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => WakeUpPage(alarmItem: alarmItem)));
  }
}
