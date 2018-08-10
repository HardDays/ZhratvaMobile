import 'dart:async';
import 'package:geolocation/geolocation.dart';

class GeolocationCache {

  static Location lastLocation;

  static Future init() async {
    var res = await Geolocation.isLocationOperational();

    if (res.isSuccessful) {
      Geolocation.currentLocation(accuracy: LocationAccuracy.best).listen(
        (loc){
          if (loc.isSuccessful){
            lastLocation = loc.location;
          }
        }
      );
    } else {
     
    }
  }
}