import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sunrise.alarm/ui/theme/app_theme_extensions.dart';
import 'package:sunrise.alarm/ui/widgets/loading_page.dart';

import '../../../../widgets/app_button.dart';
import '../../../wake_up/alarm_service.dart';
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

    final label =
        state.schedule.isEmpty ? context.text.only_once : context.text.done;
    return AppButton(
        label: label,
        onTap: () async {
          AlarmService.instance.requestPermission().then((isGranted) {
            if (isGranted) {
              controller.prepareAlarmSchedule();
            }
          });
        });
  }
}
