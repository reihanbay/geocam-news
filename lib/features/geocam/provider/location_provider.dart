import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import '../../../core/services/location_service.dart';

class LocationProvider with ChangeNotifier {
  final LocationService _locationService = LocationService();

  double? latitude;
  double? longitude;
  bool isLoading = false;
  bool isListening = false;

  Future<void> fetchLocation() async {
    isLoading = true;
    notifyListeners();

    final locationData = await _locationService.getLocation();
    if (locationData != null) {
      latitude = locationData.latitude;
      longitude = locationData.longitude;
    }

    isLoading = false;
    notifyListeners();
  }

  StreamSubscription<LocationData>? _locationSubscription;

  Future<void> startListeningLocation() async {
    final stream = await _locationService.startListening();
    if (stream == null) return;

    _locationSubscription = stream.listen((locationData) {
      latitude = locationData.latitude;
      longitude = locationData.longitude;
      notifyListeners();
    });

    isListening = true;
    notifyListeners();
  }

  void stopListening() {
    _locationSubscription?.cancel();
    _locationSubscription = null;
    isListening = false;
    notifyListeners();
  }

}
