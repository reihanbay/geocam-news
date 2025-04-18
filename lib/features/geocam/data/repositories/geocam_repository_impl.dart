import 'dart:developer';
import 'dart:typed_data';

import 'package:geocam_news/features/geocam/data/datasources/geocam_local_datasource.dart';
import 'package:geocam_news/features/geocam/domain/entities/location_entity.dart';
import 'package:geocam_news/features/geocam/domain/repository/geocam_repository.dart';

class GeocamRepositoryImpl implements GeocamRepository {
  final GeocamLocalDatasource dataLocal;

  GeocamRepositoryImpl(this.dataLocal);
  
  @override
  Future<bool> clearPhotoLocation() async {
    try {
      dataLocal.clearPhotoLocation();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<LocationEntity?> loadLocation() async {
    var data = dataLocal.getLocation();
    if(data == null) return null;
    log("${data[0]} ${data[1]}");
    return LocationEntity(latitude: data[0], longitude: data[1]);
  }

  @override
  Future<Uint8List?> loadPhoto() => dataLocal.loadPhoto();

  @override
  Future<void> saveLocation(double? lat, double? long) => dataLocal.saveLocation(lat, long);

  @override
  Future<bool> savePhoto(Uint8List bytes) async {
    try {
      dataLocal.savePhoto(bytes);
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
  
}