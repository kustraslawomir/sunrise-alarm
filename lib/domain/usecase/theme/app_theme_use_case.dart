
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_theme_use_case.g.dart';

@riverpod
AppThemeUseCase appThemeUseCase(AppThemeUseCaseRef ref) => AppThemeUseCase(ref);

class AppThemeUseCase {

  final AppThemeUseCaseRef ref;

  AppThemeUseCase(this.ref);

}