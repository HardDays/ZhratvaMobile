import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/api/restaurant.dart';
import '../../models/api/menu_category.dart';
import '../../models/api/user.dart';

class MainAPI {

  static const String url = 'http://192.168.1.72:3000';

  static const String images = '/images';
  static const String restaurants = '/restaurants';
  static const String menuCategories = '/menu_categories';
 
  static const String users = '/users';
  static const String me = '/me';
 
  static const String auth = '/auth';
  static const String login = '/login';

  static String token;

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
    }
  }

  static Future<User> createUser(User user) async {
    var res = await http.post(url + users, 
      body: json.encode(user.toJson()),
      headers: {
        'Content-type' : 'application/json', 
      }
    );
    if (res.statusCode == HttpStatus.CREATED){
      return User.fromJson(json.decode(res.body));
    }
  }

  static Future<User> getMe() async {
    var res = await http.get(url + users + me, headers: {'Authorization': token});
    if (res.statusCode == HttpStatus.OK){
      return User.fromJson(json.decode(res.body));
    }
  }

  static Future<User> authorize(String email, String password) async {
    var res = await http.post(url + auth + login, 
      body: {
        'email': email,
        'password': password
      }
    );
    if (res.statusCode == HttpStatus.OK){
      return User.fromJson(json.decode(res.body));
    }
  }

  

  static String getImageUrl(String id){
    return url + images + '/$id';
  }
}