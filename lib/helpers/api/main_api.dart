import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/api/restaurant.dart';
import '../../models/api/menu_category.dart';

class MainAPI {

  static const String url = 'http://192.168.1.72:3000';

  static const String images = '/images';
  static const String restaurants = '/restaurants';
  static const String menuCategories = '/menu_categories';

  static Future<List<Restaurant>> getRestaurants() async {
    var res = await http.get(url + restaurants);
     
    if (res.statusCode == HttpStatus.OK){
      List body = json.decode(res.body);
      return body.map<Restaurant>((x) => Restaurant.fromJson(x)).toList();
    }else{
      return List<Restaurant>();
    }
  }

  static Future<List<MenuCategory>> getRestaurantMenu(String id) async {
    var res = await http.get(url + restaurants + '/{$id}' + menuCategories);
    if (res.statusCode == HttpStatus.OK){
      List body = json.decode(res.body);
      return body.map<MenuCategory>((x) => MenuCategory.fromJson(x)).toList();
    }else{
      return null;
    }
  }

  static String getImageUrl(String id){
    return url + images + '/$id';
  }
}