import 'dart:isolate';
import 'dart:ui';

import 'package:alarm/alarm.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sunrise.alarm/ui/pages/homepage/home_page.dart';
import 'package:sunrise.alarm/ui/pages/homepage/state/alarm_state/alarm_controller.dart';
import 'package:sunrise.alarm/ui/theme/app_theme.dart';
import 'package:sunrise.alarm/ui/theme/controller/theme_mode_controller.dart';
import 'data/preferences/preferences.dart';
import 'generated/l10n.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

const String countKey = 'count';
const String isolateName = 'isolate';
ReceivePort port = ReceivePort();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Alarm.init(showDebugLogs: kDebugMode);

  IsolateNameServer.registerPortWithName(
    port.sendPort,
    isolateName,
  );

  final containsAlarmCount = await Preferences.instance.containsAlarmCount();
  if (!containsAlarmCount) {
    Preferences.instance.setAlarmCount(0);
  }

  await AndroidAlarmManager.initialize();
  runApp(const ProviderScope(child: SunriseAlarmApplication()));
}

class SunriseAlarmApplication extends ConsumerStatefulWidget {
  const SunriseAlarmApplication({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return SunriseAlarmApplicationState();
  }
}

class SunriseAlarmApplicationState
    extends ConsumerState<SunriseAlarmApplication> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _setThemeModeAsSystemBrightness();
      _stopAlarmOnAppResume();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeControllerProvider);
    final alarmController = ref.read(alarmControllerProvider.notifier);
    alarmController.stopAlarm();
    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      debugShowCheckedModeBanner: false,
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        //WidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const HomePage(),
    );
  }

  void _setThemeModeAsSystemBrightness() {
    final themeModeController = ref.read(themeModeControllerProvider.notifier);
    final systemBrightness = MediaQuery.of(context).platformBrightness;
    themeModeController.setThemeModeAsSystemBrightness(systemBrightness);
  }

  void _stopAlarmOnAppResume() {
    SystemChannels.lifecycle.setMessageHandler((state) {
      debugPrint('App lifecycle state: $state');
      if (state == AppLifecycleState.resumed.toString()) {
        final alarmController = ref.read(alarmControllerProvider.notifier);
        alarmController.stopAlarm();
      }

      return Future.value(state);
    });
  }
}
