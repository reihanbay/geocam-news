import 'package:location/location.dart';

class LocationService {
  final Location _location = Location();

  Future<bool> checkPermission() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) return false;
    }

    PermissionStatus permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return false;
    }

    return true;
  }

  Future<LocationData?> getLocation() async {
    try {
      final hasPermission = await checkPermission();
      if (!hasPermission) return null;

      final locationData = await _location.getLocation();
      return locationData;
    } catch (e) {
      print("Location error: $e");
      return null;
    }
  }

  // stream location
  Stream<LocationData>? locationStream;

  Future<Stream<LocationData>?> startListening() async {
    final allowed = await checkPermission();
    if (!allowed) return null;

    _location.changeSettings(
      interval: 5000, // milliseconds
      accuracy: LocationAccuracy.high,
    );

    locationStream = _location.onLocationChanged;
    return locationStream;
  }
}
