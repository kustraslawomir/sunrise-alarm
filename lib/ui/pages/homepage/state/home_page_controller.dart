import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sunrise.alarm/domain/usecase/get_sunrise_date_use_case.dart';
import 'package:sunrise.alarm/domain/usecase/location/current_position_use_case.dart';
import 'package:sunrise.alarm/domain/usecase/location/geocoding_use_case.dart';
import 'package:sunrise.alarm/ui/pages/homepage/state/home_page_state.dart';

part 'home_page_controller.g.dart';

@riverpod
class HomePageController extends _$HomePageController {
  late final CurrentPositionUseCase currentPositionUseCase =
      ref.read(currentPositionUseCaseProvider);

  late final GeocodingUseCase geocodingUseCase =
      ref.read(geocodingUseCaseProvider);

  late final GetSunriseDateUseCase getSunriseDateUseCase =
      ref.read(getSunriseDateUseCaseProvider);

  @override
  HomePageState build() => HomePageState.empty();

  void initialize() async {
    final position = await currentPositionUseCase.determinePosition();
    final sunriseDate = await getSunriseDateUseCase.invoke(position);
    final cityName = await geocodingUseCase.fetchCityName(position);
    state = state.copyWith(
      localSunriseDate: sunriseDate,
      location: cityName
    );
  }
}
