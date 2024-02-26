import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sunrise.alarm/ui/pages/homepage/state/alarm_state/alarm_controller.dart';
import 'package:sunrise.alarm/ui/theme/app_theme_extensions.dart';

import '../../../../widgets/app_button.dart';

class DebugAlarmSetButton extends ConsumerWidget {
  const DebugAlarmSetButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(alarmControllerProvider.notifier);
    return Visibility(
        visible: kDebugMode,
        child: AppButton(

            label: context.text.debug_alarm_set,
            onTap: () {
              controller.setDebugAlarm();
            }));
  }
}
