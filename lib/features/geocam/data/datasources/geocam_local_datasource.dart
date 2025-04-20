
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:shared_preferences/shared_preferences.dart';

class GeocamLocalDatasource {
  final SharedPreferences pref;

  GeocamLocalDatasource(this.pref);

  static const String keyLat = "SET_LAT";
  static const String keyLong = "SET_LONG";
  static const String keyImage= "SET_IMAGE";

  Future<void> savePhoto(Uint8List bytes) async {
    final base64 = base64Encode(bytes);
    final save = await pref.setString(keyImage, base64);
  }

  Future<Uint8List?> loadPhoto() async {
    final base64 = pref.getString(keyImage);
    if (base64 == null) return null;
    return base64Decode(base64);
  }

  Future<void> clearPhotoLocation() async {
    pref.remove(keyImage);
    pref.remove(keyLat);
    pref.remove(keyLong);
  }

  Future<void> saveLocation(double? lat, double? long) async {
    try {
      await pref.setDouble(keyLat, lat?? 0);
      await pref.setDouble(keyLong, long?? 0);
    } catch (e) {
      throw Exception("Cannot set Location");
    }
  }

  List<double?>? getLocation() {
    double? lat = pref.getDouble(keyLat);
    double? long = pref.getDouble(keyLong);
    return List<double?>.of([lat, long]);
  }

}