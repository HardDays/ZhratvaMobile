import 'dart:async';
import 'package:geolocation/geolocation.dart';
import 'package:synchronized/synchronized.dart';

class GeolocationCache {

  static Location _lastLocation;

  static Location lastLocation(){
    //if (_lastLocation == null){
    //  init();
      
    //}
    return _lastLocation;
  }

  static Future init() async {
    var lock = new Lock();
    await lock.synchronized(() async {
      var res = await Geolocation.isLocationOperational();

      if (res.isSuccessful) {
        Geolocation.currentLocation(accuracy: LocationAccuracy.best).listen(
          (loc){
            if (loc.isSuccessful){
              _lastLocation = loc.location;
            }
          }
        );
      } else {
      
      }
    });
  }
}