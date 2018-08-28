import 'dart:math';

import '../cart_item.dart';

import '../api/restaurant.dart';
import '../api/menu_category.dart';
import '../api/menu_item.dart';
import '../api/order_menu_item.dart';

class Cart {
  static double _totalPrice = 0.0;
  static int _totalCal = 0;
  static int _totalCookingTime = 0;
  
  static List<OrderMenuItem> _items = [];
  static Restaurant _restaurant;

  static double totalPrice (){
    return _totalPrice;
  }

  static int totalCal(){
    return _totalCal ?? 0;
  }

  static int totalCookingTime(){
    return _totalCookingTime ?? 0;
  }

  static List<OrderMenuItem> items(){
    return _items;
  }

  static void changeRestaurant(Restaurant restaurant){
    _restaurant = restaurant;
  }

  static Restaurant restaurant(){
    return _restaurant;
  }

  static void add(OrderMenuItem item){
    _items.add(item);
    _totalPrice += item.menuItem.price * item.count;
    _totalCal += item.menuItem.kCal != null ? item.menuItem.kCal * item.count : 0;
    _totalCookingTime = _items.map((a) => a.menuItem.cookingTime).reduce((a, b) => a != null && b != null ? max(a, b) : 0);
  }

  static void remove(int index){
    _totalPrice -= _items[index].menuItem.price;     
    _totalCal -= _items[index].menuItem.kCal ?? 0;   
    _items.removeAt(index);
    if (_items.length > 0){
      _totalCookingTime = _items.map((a) => a.menuItem.cookingTime).reduce((a, b) => a != null && b != null ? max(a, b) : 0);
    }
  }
  
  static void incCount(int index){
    if (_items[index].count < 5){
      _items[index].count += 1;
      _totalPrice += _items[index].menuItem.price ?? 0.0;     
      _totalCal += _items[index].menuItem.kCal  ?? 0;   
    }
  }

  static void decCount(int index){
    if (_items[index].count > 1){
      _items[index].count -= 1;
      _totalPrice -= _items[index].menuItem.price;     
      _totalCal -= _items[index].menuItem.kCal ?? 0;   
    }
  }

  static void clear(){
    _items = [];
    _totalCal = 0;
    _totalCookingTime = 0;
    _totalPrice = 0.0;
    _restaurant = null;
  }

  static bool canAdd(MenuItem item){
    return _items.length == 0 || _items[0].menuItem.restaurantId == item.restaurantId;
  }
}