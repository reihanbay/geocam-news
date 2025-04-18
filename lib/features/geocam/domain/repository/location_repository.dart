import 'package:geocam_news/features/geocam/domain/entities/location_entity.dart';

abstract class LocationRepository {
  Future<Stream<LocationEntity>?> getLocationStream();
  Future<LocationEntity?> getLocation();
}