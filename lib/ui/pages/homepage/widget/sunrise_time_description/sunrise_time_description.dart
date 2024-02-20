import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sunrise.alarm/domain/usecase/datetime/date_time_formatter.dart';
import 'package:sunrise.alarm/ui/theme/app_theme_extensions.dart';

import '../../state/home_page_state/home_page_controller.dart';

class SunriseTimeDescription extends ConsumerWidget {
  const SunriseTimeDescription({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homePageControllerProvider);
    final location = state.location;
    final time = state.localSunriseDate;
    if (time == null || location == null) {
      return const SizedBox.shrink();
    }
    return Text(
        context.text.todays_sunrise_description(
            location, DateTimeFormatter.toHHmm(time)),
        style: context.theme.textTheme.titleMedium);
  }
}
