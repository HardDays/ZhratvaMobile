import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../../models/api/restaurant.dart';
import '../../models/api/menu_category.dart';
import '../../models/api/user.dart';
import '../../models/api/order.dart';
import '../../models/api/statistics.dart';

class MainAPI {

  static const String url = 'http://35.224.230.2:3000';

  static const String images = '/images';
  static const String restaurants = '/restaurants';
  static const String menuCategories = '/menu_categories';
 
  static const String users = '/users';
  static const String me = '/me';
 
  static const String orders = '/orders';
  static const String current = '/current';
  static const String past = '/past';
  static const String statistics = '/statistics';

  static const String auth = '/auth';
  static const String login = '/login';

  static String token;

  static Future<List<Restaurant>> getRestaurants(DateTime date, [double lat, double lng]) async {
    String dt = DateFormat('dd.MM.y HH:mm').format(date);
    var formedUrl = url + restaurants + '?date=$dt';
    if (lat != null && lng != null){
      formedUrl += '&lat=$lat&lng=$lng';
    }

    var res = await http.get(formedUrl);
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

  static  Future<List<Order>> getMyCurrentOrders() async {
    String date = DateFormat('dd.MM.y HH:mm').format(DateTime.now());
    var res = await http.get(url + users + me + orders + current + '?date=$date', headers: {'Authorization': token});
    if (res.statusCode == HttpStatus.OK){
      List body = json.decode(res.body);
      return body.map<Order>((x) => Order.fromJson(x)).toList();
    }
  }

  static  Future<List<Statistics>> getMyStatistics(List<Duration> periods) async {
    String durs = '?periods=';
    String now = DateFormat('dd.MM.y HH:mm').format(DateTime.now());
    for (var duration in periods){
      String date = DateFormat('dd.MM.y HH:mm').format(DateTime.now().subtract(duration));
      durs += '${date}-${now},';
    }
    var res = await http.get(url + users + me + statistics + durs, headers: {'Authorization': token});
    if (res.statusCode == HttpStatus.OK){
      List body = json.decode(res.body);
      return body.map<Statistics>((x) => Statistics.fromJson(x)).toList();
    }
  }

  static  Future<List<Order>> getMyPastOrders([int limit, int offset]) async {
    String date = DateFormat('dd.MM.y HH:mm').format(DateTime.now());
    var formedUrl = url + users + me + orders + past;
    if (limit != null && offset != null){
      formedUrl += '?limit=$limit&offset=$offset&date=$date';
    }
    var res = await http.get(formedUrl, headers: {'Authorization': token});
    if (res.statusCode == HttpStatus.OK){
      List body = json.decode(res.body);
      return body.map<Order>((x) => Order.fromJson(x)).toList();
    }
  }

  static  Future<Order> createOrder(Order order) async {
    var res = await http.post(url + users + me + orders, 
      body: json.encode(order.toJson()),
      headers: {
        'Content-type' : 'application/json', 
        'Authorization': token
      }
    );
    if (res.statusCode == HttpStatus.CREATED){
      return Order.fromJson(json.decode(res.body));
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