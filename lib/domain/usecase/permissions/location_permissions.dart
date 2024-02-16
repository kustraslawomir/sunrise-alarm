import 'package:geolocator/geolocator.dart';

class LocationPermissions {
  void requestPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
  }
}
