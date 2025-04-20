import 'dart:typed_data';

import 'package:geocam_news/features/geocam/domain/entities/location_entity.dart';

abstract class GeocamRepository {
  Future<bool> savePhoto(Uint8List bytes) ;
  Future<void> saveLocation(double? lat, double? long) ;
  Future<Uint8List?> loadPhoto();
  Future<bool> clearPhotoLocation();
  Future<LocationEntity?> loadLocation();

}