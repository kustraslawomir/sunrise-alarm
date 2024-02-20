import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sunrise.alarm/ui/pages/drawer/drawer_page.dart';
import 'package:sunrise.alarm/ui/pages/homepage/state/home_page_state/home_page_controller.dart';
import 'package:sunrise.alarm/ui/pages/homepage/widget/alarm_time/alarm_time_radio_group.dart';
import 'package:sunrise.alarm/ui/pages/homepage/widget/app_bar/app_bar_title.dart';
import 'package:sunrise.alarm/ui/pages/homepage/widget/sunrise_time_description/sunrise_time_description.dart';
import 'package:sunrise.alarm/ui/theme/app_theme_extensions.dart';

import '../../../generated/l10n.dart';
import '../../theme/dimensions.dart';

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
    return Scaffold(
        appBar: AppBar(centerTitle: true, title: const AppBarTitle()),
        drawer: const Drawer(child: DrawerPage()),
        body: const Padding(
            padding: EdgeInsets.all(Dimensions.appPadding),
            child: Center(
                child: Column(
              children: [SunriseTimeDescription(), AlarmTimeRadioGroup()],
            ))));
  }
}
