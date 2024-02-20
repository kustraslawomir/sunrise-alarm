import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'alarm_time_state.dart';

part 'alarm_controller.g.dart';

@riverpod
class AlarmTimeController extends _$AlarmTimeController {
  @override
  AlarmTimeState build() => AlarmTimeState.atSunrise;

  setState(AlarmTimeState state) {
    this.state = state;
  }
}
