import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sunrise.alarm/domain/usecase/datetime/date_time_formatter.dart';
import 'package:sunrise.alarm/ui/theme/app_theme_extensions.dart';

import '../state/home_page_controller.dart';

class AppBarTitle extends ConsumerWidget {
  const AppBarTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var title = context.text.app_name;
    final state = ref.watch(homePageControllerProvider);
    final date = state.localSunriseDate;
    if (date != null) {
      title = context.text.am(DateTimeFormatter.toHHmm(date));
    }
    return Text(title, style: context.theme.textTheme.titleMedium);
  }
}
