import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sunrise.alarm/ui/pages/drawer/drawer_page.dart';
import 'package:sunrise.alarm/ui/pages/homepage/state/alarm_state/alarm_controller.dart';
import 'package:sunrise.alarm/ui/pages/homepage/state/home_page_state/home_page_controller.dart';
import 'package:sunrise.alarm/ui/pages/homepage/widget/alarm_schedule/alarm_schedule.dart';
import 'package:sunrise.alarm/ui/pages/homepage/widget/set_alarm/set_alarm_button.dart';
import 'package:sunrise.alarm/ui/pages/homepage/widget/spacing/vertical_spacing.dart';
import 'package:sunrise.alarm/ui/theme/app_theme_extensions.dart';
import 'package:sunrise.alarm/ui/widgets/loading_page.dart';

import '../../theme/dimensions.dart';
import '../../widgets/app_button.dart';
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
      final controller = ref.read(homePageControllerProvider.notifier);
      controller.initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homePageControllerProvider);
    final alarmState = ref.watch(alarmControllerProvider);
    if (state.isLoading) {
      return const LoadingPage();
    }
    return Scaffold(
        appBar: AppBar(centerTitle: true, title: const AppBarTitle()),
        drawer: const Drawer(child: DrawerPage()),
        body: Padding(
            padding: const EdgeInsets.all(Dimensions.appPadding),
            child: Center(
                child: Column(
              children: [
                const SunriseTimeDescription(),
                const VerticalSpacing(),
                const AlarmTimeRadioGroup(),
                const VerticalSpacing(),
                const RepeatDaily(),
                if (!alarmState.repeatDaily) const VerticalSpacing(),
                if (!alarmState.repeatDaily) const AlarmSchedule(),
                const Spacer(),
                const SetAlarmButton()
              ],
            ))));
  }

  _setAlarm() {}
}
