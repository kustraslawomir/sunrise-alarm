import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sunrise.alarm/domain/usecase/sunrise/get_sunrise_date_use_case.dart';
import 'package:sunrise.alarm/domain/usecase/location/current_position_use_case.dart';
import 'package:sunrise.alarm/domain/usecase/location/geocoding_use_case.dart';
import 'package:sunrise.alarm/ui/pages/homepage/state/alarm_state/alarm_controller.dart';
import 'package:sunrise.alarm/ui/pages/homepage/state/home_page_state/determine_sunrise_data_state.dart';

part 'determine_sunrise_data_controller.g.dart';

@riverpod
class DeterminesSunriseDataController
    extends _$DeterminesSunriseDataController {
  @override
  DetermineSunriseDataState build() => DetermineSunriseDataState.defaultState();

  late final CurrentPositionUseCase currentPositionUseCase =
      ref.read(currentPositionUseCaseProvider);

  late final GeocodingUseCase geocodingUseCase =
      ref.read(geocodingUseCaseProvider);

  late final GetSunriseDateUseCase getSunriseDateUseCase =
      ref.read(getSunriseDateUseCaseProvider);

  late final AlarmController alarmController =
      ref.read(alarmControllerProvider.notifier);

  void determineSunriseData(
      Function({Position? position, DateTime? sunriseDateTime, String? address})
          result) async {
    state = state.copyWith(isLoading: true);
    final position = await currentPositionUseCase.determinePosition();
    final sunriseDateTime =
        await getSunriseDateUseCase.invoke(position, DateTime.now());
    final address = await geocodingUseCase.fetchAddress(position);
    result(
        position: position, sunriseDateTime: sunriseDateTime, address: address);
    state = state.copyWith(isLoading: false);
  }
}
