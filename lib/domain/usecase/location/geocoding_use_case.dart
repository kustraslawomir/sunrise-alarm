import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'geocoding_use_case.g.dart';

@riverpod
GeocodingUseCase geocodingUseCase(GeocodingUseCaseRef ref) =>
    GeocodingUseCase(ref);

class GeocodingUseCase {
  final GeocodingUseCaseRef ref;

  GeocodingUseCase(this.ref);

  Future<String?> fetchAddress(Position position) async {
    try {
      List<Placemark> data = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      final address = data[0];
      debugPrint("$address");
      final positionAddress =
          "${address.country} ${address.administrativeArea}";
      debugPrint('return $positionAddress');
      return Future.value(positionAddress);
    } catch (err) {
      return Future.error(err);
    }
  }
}
