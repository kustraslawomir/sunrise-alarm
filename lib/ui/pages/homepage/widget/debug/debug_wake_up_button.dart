import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_alarm_background_trigger/flutter_alarm_background_trigger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sunrise.alarm/ui/theme/app_theme_extensions.dart';

import '../../../../widgets/app_button.dart';
import '../../../wake_up/wake_up_page.dart';

class DebugWakeUpButton extends ConsumerWidget {
  const DebugWakeUpButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Visibility(
        visible: kDebugMode,
        child: AppButton(
            label: context.text.debug_wake_up_page,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      WakeUpPage(alarmItem: AlarmItem(time: DateTime.now()))));
            }));
  }
}
