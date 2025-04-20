import 'package:geocam_news/features/geocam/domain/entities/location_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class SharedPreferencesServices {
//   final SharedPreferences pref;

//   SharedPreferencesServices(this.pref);

//   static const String keyLatLong = "SET_LATLONG";
//   static const String keyImage= "SET_IMAGE";

//   Future<void> saveLocation(String lat, String long) async {
//     try {
//       await pref.setStringList(keyLatLong, [lat, long]);
//     } catch (e) {
//       throw Exception("Cannot set Location");
//     }
//   }

//   List<String>? getLocation() {
//     return pref.getStringList(keyLatLong);
//   }

// }