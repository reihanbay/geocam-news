import 'package:geocam_news/features/geocam/domain/entities/location_entity.dart';
import 'package:geocam_news/features/geocam/domain/repository/geocam_repository.dart';

class LoadLocationUsecase {
  final GeocamRepository repo;

  LoadLocationUsecase(this.repo);

  Future<LocationEntity?> call() => repo.loadLocation();
}