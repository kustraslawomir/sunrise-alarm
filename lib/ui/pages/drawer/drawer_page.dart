import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sunrise.alarm/ui/pages/drawer/widgets/theme_switcher.dart';
import 'package:sunrise.alarm/ui/theme/dimensions.dart';

class DrawerPage extends ConsumerWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        padding: const EdgeInsets.all(Dimensions.appPadding),
        child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [ThemeSwitcher()]));
  }
}
