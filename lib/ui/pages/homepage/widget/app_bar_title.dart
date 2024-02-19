import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sunrise.alarm/ui/theme/app_theme_extensions.dart';

import '../state/home_page_controller.dart';

class AppBarTitle extends ConsumerWidget {
  const AppBarTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var title = context.text.app_name;
    final state = ref.watch(homePageControllerProvider);
    try {
      title = context.text.am(state.localSunriseDateHHmm());
    } catch (e) {
      debugPrint(e.toString());
    }
    return Text(title, style: context.theme.textTheme.titleMedium);
  }
}
