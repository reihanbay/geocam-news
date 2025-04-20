
import 'dart:typed_data';

import 'package:geocam_news/features/geocam/domain/entities/location_entity.dart';
import 'package:geocam_news/features/geocam/domain/repository/geocam_repository.dart';

class SavePhotoAndLocationUsecase {
  final GeocamRepository repo;
  SavePhotoAndLocationUsecase(this.repo);

  Future<bool> call(Uint8List photo, LocationEntity location) async {
    try {
      await repo.savePhoto(photo);
      await repo.saveLocation(location.latitude, location.longitude);
      return true;
    } catch (e) {
      return false;
    }
  }
}