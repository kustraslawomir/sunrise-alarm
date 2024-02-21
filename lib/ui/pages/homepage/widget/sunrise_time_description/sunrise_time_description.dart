import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sunrise.alarm/ui/pages/homepage/state/alarm_state/alarm_controller.dart';
import 'package:sunrise.alarm/ui/theme/app_theme_extensions.dart';

class SunriseTimeDescription extends ConsumerWidget {
  const SunriseTimeDescription({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(alarmControllerProvider);
    final sunriseDateTime = state.sunriseDateTime;
    if (sunriseDateTime == null) {
      return const SizedBox.shrink();
    }
    return Text(
        context.text.tomorrows_sunrise_at_your_location_description(
            state.localSunriseDateHHmm()),
        style: context.theme.textTheme.titleMedium);
  }
}
