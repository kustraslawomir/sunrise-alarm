import 'package:daylight/daylight.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_sunrise_date_use_case.g.dart';

@riverpod
GetSunriseDateUseCase getSunriseDateUseCase(GetSunriseDateUseCaseRef ref) =>
    GetSunriseDateUseCase(ref);

class GetSunriseDateUseCase {
  final GetSunriseDateUseCaseRef ref;

  GetSunriseDateUseCase(this.ref);

  Future<DateTime> invoke(Position position, DateTime dateTime) async {
    final dayLightLocation =
        DaylightLocation(position.latitude, position.longitude);
    final dayLightCalculator = DaylightCalculator(dayLightLocation);
    final sunriseDateTime = dayLightCalculator
        .calculateEvent(dateTime, Zenith.official, EventType.sunrise)
        ?.toLocal();
    if (sunriseDateTime == null) {
      throw Exception('could\' determine sunrise date time');
    }

    debugPrint("location: ${position.latitude},${position.longitude}");
    debugPrint("sunrise: $sunriseDateTime");
    return sunriseDateTime;
  }
}
