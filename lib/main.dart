
import 'package:flutter/material.dart';
import 'package:flutter_alarm_background_trigger/flutter_alarm_background_trigger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sunrise.alarm/ui/pages/homepage/home_page.dart';
import 'package:sunrise.alarm/ui/pages/homepage/sunrise_material_application.dart';
import 'package:sunrise.alarm/ui/theme/controller/theme_mode_controller.dart';
import 'data/preferences/preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.instance.initialize();
  FlutterAlarmBackgroundTrigger.initialize();
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
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _setThemeModeAsSystemBrightness();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SunriseMaterialApplication(home: HomePage());
  }

  void _setThemeModeAsSystemBrightness() {
    final themeModeController = ref.read(themeModeControllerProvider.notifier);
    final systemBrightness = MediaQuery.of(context).platformBrightness;
    themeModeController.setThemeModeAsSystemBrightness(systemBrightness);
  }
}
