import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sunrise.alarm/ui/pages/homepage/home_page.dart';
import 'package:sunrise.alarm/ui/theme/app_theme.dart';
import 'package:sunrise.alarm/ui/theme/controller/app_theme_controller.dart';

import 'generated/l10n.dart';

void main() {
  runApp(const ProviderScope(child: SunriseAlarmApplication()));
}

class SunriseAlarmApplication extends ConsumerWidget {
  const SunriseAlarmApplication({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeState = ref.watch(appThemeControllerProvider);
    debugPrint("theme mode: $themeModeState");
    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeModeState,
      debugShowCheckedModeBanner: false,
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        //WidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const HomePage(),
    );
  }
}
