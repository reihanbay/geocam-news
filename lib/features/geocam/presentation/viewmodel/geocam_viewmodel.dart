import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geocam_news/features/geocam/domain/entities/location_entity.dart';
import 'package:geocam_news/features/geocam/domain/usecase/get_location_stream.dart';
import 'package:geocam_news/features/geocam/domain/usecase/reset_data_usecase.dart';
import 'package:geocam_news/features/geocam/domain/usecase/save_photo_and_location_usecase.dart';

import '../../domain/usecase/load_location_usecase.dart';
import '../../domain/usecase/load_photo_usecase.dart';

class GeocamViewmodel extends ChangeNotifier {
  //constructor
  final GetLocationStream getLocationStream;
  final SavePhotoAndLocationUsecase savePhotoAndLocationUsecase;
  final LoadPhotoUsecase loadPhotoUsecase;
  final LoadLocationUsecase loadLocationUsecase;
  final ResetDataUsecase resetDataUsecase;

  GeocamViewmodel(this.getLocationStream, this.savePhotoAndLocationUsecase, this.loadPhotoUsecase, this.loadLocationUsecase, this.resetDataUsecase);


  double? latitude;
  double? longitude;
  Uint8List? photo;
  bool isListening = false;

  void getLocation() async {
    final location = await getLocationStream();
    isListening = true;
    notifyListeners();
    if (location != null) {
      latitude = location.latitude;
      longitude = location.longitude;
    }
    isListening = false;
    notifyListeners();
  }

  Future<void> loadLocation() async {
    final load = await loadLocationUsecase.call();
    if(load == null) {
      latitude = null;
      longitude = null;
      notifyListeners();
    } else {
      latitude = load.latitude;
      longitude = load.longitude;
      notifyListeners();
    }
  }

  Future<bool> savePhotoLocation(
      Uint8List bytes, double lat, double long) async {
    final load = await savePhotoAndLocationUsecase(
        bytes, LocationEntity(latitude: lat, longitude: long));
    if (load) {
      photo = bytes;
      latitude = lat;
      longitude = long;
      log("sampe disini");
      notifyListeners();
      return true;
    } else {
      return false;
    }

  }

  Future<void> loadPhoto() async {
    final loaded = await loadPhotoUsecase();
    photo = loaded;
    notifyListeners();
  }

  Future<bool> resetData() async {
    final resetState = await resetDataUsecase();
    if(resetState) {
      latitude = null;
      longitude = null;
      photo = null;
      log("disini");
      notifyListeners();
    }

    return resetState;
  }

  //Camera
  String? imagePath;
  void setImagePath(String? value) {
    imagePath = value;
    notifyListeners();
  }

  XFile? imageFile;
  void setImageFile(XFile? value) {
    imageFile = value;
    notifyListeners();
  }

  void setImageBytes(XFile? value) async {
    final bytes = await value?.readAsBytes();
    if (bytes != null) {
      final compressed = await FlutterImageCompress.compressWithList(bytes);
      photo = compressed;
      notifyListeners();
    }
  }
}
