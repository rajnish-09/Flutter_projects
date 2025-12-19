import 'package:geolocator/geolocator.dart';

class DetermineLocation {
  Future<Position> getLocation() async {
    bool isServiceEnabled;
    LocationPermission permission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (isServiceEnabled == false) {
      return Future.error("Location service is not enabled.");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location service is denied permanently.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
