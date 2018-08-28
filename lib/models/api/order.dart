import 'package:intl/intl.dart';

import 'order_menu_item.dart';
import 'restaurant.dart';

class Order {
  String id;
  String restaurantId;
  String userId;
  String orderStatus;

  int peopleCount;
  double price;
  String carryOption;
  String currency;
  DateTime date;
  DateTime createdAt;

  Restaurant restaurant;
  List <OrderMenuItem> orderMenuItems;

  Order({this.id, this.restaurantId, this.userId, this.currency, this.orderStatus, this.price, this.carryOption, this.peopleCount, this.orderMenuItems, this.date, this.restaurant, this.createdAt});

  Map <String, dynamic> toJson(){
    return {
      'order_menu_items': orderMenuItems.map<Map <String, dynamic>>((item) => item.toJson()).toList(),
      'date': DateFormat('dd.MM.y HH:mm').format(date),
      'carry_option': carryOption,
      'people_count': peopleCount
    };
  }

  Duration timeLeft(){
    return date.difference(DateTime.now());
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    var date = DateTime.parse(json['date']);
    return Order(
      id: json['id'],
      restaurantId: json['restaurantId'],
      userId: json['user_id'],
      currency: json['currency'],
      price: json['price'] / 100.0,
      peopleCount: json['people_count'],
      carryOption: json['carry_option'],
      date: DateTime(date.year, date.month, date.day, date.hour, date.minute),
      createdAt: DateTime.parse(json['created_at']),
      restaurant: Restaurant.fromJson(json['restaurant']),
      orderStatus: json['order_status'],
      orderMenuItems: json['order_menu_items'].map<OrderMenuItem>((w) => OrderMenuItem.fromJson(w)).toList(),
    );
  }

}