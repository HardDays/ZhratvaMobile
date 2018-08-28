import 'package:intl/intl.dart';
import 'package:haversine/haversine.dart';

import 'menu_category.dart';
import 'working_hour.dart';

import '../../helpers/api/main_api.dart';
import '../../helpers/util/geolocation_cache.dart';

class Restaurant{
  String id;

  String name;
  String coverId;
  String address;
  String hours;
  String description;
  String currency;
  String phone;
  String link;

  double rating;

  double lat;
  double lng;

  bool openNow;
  double distance;
  Duration travelTime;
  String cover;
  WorkingHour workingHourNow;

  List <WorkingHour> workingHours = [];
  List <MenuCategory> menuCategories = [];

  Restaurant({this.id, this.name, this.distance, this.openNow, this.coverId, this.address, this.lat, this.lng, this.hours, this.link, this.phone, this.workingHours, this.description, this.currency, this.rating, this.menuCategories}){
    openNow = isOpenNow();
    distance = calcDistance();
    travelTime = calcTravelTime();
    cover = getCover();
    workingHourNow = findWorkingHourNow();
  }

  bool isOpenNow(){
    String time = DateFormat('H:m').format(DateTime.now());
    String day = DateFormat('EEEE').format(DateTime.now()).toLowerCase();
    return workingHours.any((w) => (w.day == day && w.open.compareTo(time) < 0 && w.close.compareTo(time) > 0));
  }

  double calcDistance(){
    var loc = GeolocationCache.lastLocation();
    if (loc != null && lat != null && lng != null){
      var dist = Haversine.fromDegrees(latitude1: loc.latitude, longitude1: loc.longitude, latitude2: lat, longitude2: lng);
      return dist.distance();
    }
  }

  Duration calcTravelTime(){
    var dist = calcDistance();
    if (dist != null){
      return Duration(seconds: dist ~/ 1.3);
    }
  }

  String getCover(){
    return MainAPI.getImageUrl(coverId);
  }

  WorkingHour findWorkingHourNow(){
    String day = DateFormat('EEEE').format(DateTime.now()).toLowerCase();
    try {
      return workingHours.firstWhere((w) => (w.day == day));
    } catch (ex) {
      return null;
    }
  }

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      address: json['address'],
      lat: json['lat'],
      lng: json['lng'],
      coverId: json['cover_id'],
      currency: json['currency'],
      phone: json['phone'],
      link: json['link'],
      distance: json['distance'] != null ? json['distance'] * 1000 : null,
      openNow: json['open_now'],
      workingHours: json['working_hours'].map<WorkingHour>((w) => WorkingHour.fromJson(w)).toList(),
      //menuCategories: json['menu_categories'] != null ? json['menu_categories'].map<MenuCategory>((w) => MenuCategory.fromJson(w)).toList() : null,
    );
  }
}