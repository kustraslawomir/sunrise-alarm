import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_alarm_background_trigger/src/AlarmItem.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sunrise.alarm/domain/usecase/sunrise/app_logger.dart';
import 'package:sunrise.alarm/ui/pages/homepage/state/alarm_state/alarm_controller.dart';
import 'package:sunrise.alarm/ui/pages/wake_up/alarm_service.dart';
import 'package:sunrise.alarm/ui/theme/app_theme_extensions.dart';
import 'package:vibration/vibration.dart';

import '../homepage/sunrise_material_application.dart';

class WakeUpPage extends ConsumerStatefulWidget {
  final AlarmItem alarmItem;

  const WakeUpPage({required this.alarmItem, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return WakeUpState();
  }
}

class WakeUpState extends ConsumerState<WakeUpPage> {
  @override
  void initState() {
    _vibrate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          await AlarmService.instance.deleteAlarmByTime(widget.alarmItem.time!);
          await Vibration.cancel();
          await SystemNavigator.pop();
        },
        child: Container(
            color: Colors.red,
            height: double.infinity,
            width: double.infinity,
            child: Center(
              child: Text(
                "Wake up",
                style: context.theme.textTheme.bodyLarge,
              ),
            )));
  }

  @override
  void dispose() {
    Vibration.cancel();
    super.dispose();
  }

  void _vibrate() async {
    final pattern = List<int>.generate(
        50, (int index) => index.floor().isEven ? 4000 : 1000,
        growable: true);

    Vibration.vibrate(pattern: pattern);
  }
}
