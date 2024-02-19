import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sunrise.alarm/ui/pages/homepage/home_page.dart';
import 'package:sunrise.alarm/ui/theme/app_theme.dart';
import 'package:sunrise.alarm/ui/theme/controller/theme_mode_controller.dart';

import 'generated/l10n.dart';

void main() {
  runApp(const ProviderScope(child: SunriseAlarmApplication()));
}

class SunriseAlarmApplication extends ConsumerStatefulWidget {
  const SunriseAlarmApplication({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return SunriseAlarmApplicationState();
  }
}

class SunriseAlarmApplicationState
    extends ConsumerState<ConsumerStatefulWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final themeModeController =
          ref.read(themeModeControllerProvider.notifier);
      final systemBrightness = MediaQuery.of(context).platformBrightness;
      themeModeController.setThemeModeAsSystemBrightness(systemBrightness);
    });
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeControllerProvider);
    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
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
