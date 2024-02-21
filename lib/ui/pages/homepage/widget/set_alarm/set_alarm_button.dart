import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sunrise.alarm/ui/theme/app_theme_extensions.dart';
import 'package:sunrise.alarm/ui/widgets/loading_page.dart';

import '../../../../../data/preferences/preferences.dart';
import '../../../../../main.dart';
import '../../../../widgets/app_button.dart';
import '../../state/alarm_state/alarm_controller.dart';

class SetAlarmButton extends ConsumerWidget {
  const SetAlarmButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(alarmControllerProvider.notifier);
    final state = ref.watch(alarmControllerProvider);

    if (state.isLoading) {
      return const LoadingPage();
    }

    return AppButton(
        label: context.text.done,
        isEnabled: state.schedule.isNotEmpty,
        onTap: () async {
          await Permission.notification.onGrantedCallback(() {
            final title = context.text.wake_up_title;
            final description = context.text.wake_up_description;
            controller.prepareAlarm(title, description, callback);
          }).request();
        });
  }

  static SendPort? uiSendPort;

  @pragma('vm:entry-point')
  static Future<void> callback() async {
    debugPrint('Alarm fired!');
    final count = await Preferences.instance.getAlarmCount();
    await Preferences.instance.setAlarmCount(count + 1);

    uiSendPort ??= IsolateNameServer.lookupPortByName(isolateName);
    uiSendPort?.send(null);


  }
}
