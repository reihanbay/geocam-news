

import 'package:geocam_news/core/services/location_service.dart';
import 'package:geocam_news/features/geocam/domain/entities/location_entity.dart';
import 'package:geocam_news/features/geocam/domain/repository/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository{
  final LocationService service;

  LocationRepositoryImpl(this.service);

  @override
  Future<Stream<LocationEntity>?> getLocationStream() async {
    var stream = await service.startListening();

    if(stream == null) return null;

    return stream.map((data) => LocationEntity(
      latitude: data.latitude,
      longitude: data.longitude,
    ));
  }
  
  @override
  Future<LocationEntity?> getLocation() async {
    var location = await service.getLocation();
    if(location == null) return null;
    
    return LocationEntity(latitude: location.latitude, longitude: location.longitude);
  }

  
}