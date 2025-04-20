import 'package:geocam_news/features/geocam/domain/entities/location_entity.dart';
import 'package:geocam_news/features/geocam/domain/repository/location_repository.dart';

class GetLocationStream {
  final LocationRepository repository;

  GetLocationStream(this.repository);

  // Future<Stream<LocationEntity>?> call() => repository.getLocationStream();
  Future<LocationEntity?> call() => repository.getLocation();
}