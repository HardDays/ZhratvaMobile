import 'menu_item.dart';

class OrderMenuItem {
  String id;
  String menuItemId;
  String orderId;

  String currency;
  int count;
  double price;

  MenuItem menuItem;

  OrderMenuItem({this.id, this.menuItemId, this.orderId, this.currency, this.count, this.price, this.menuItem});

  Map <String, dynamic> toJson(){
    return {
      'menu_item_id': menuItemId,
      'count': count
    };
  }

  factory OrderMenuItem.fromJson(Map<String, dynamic> json) {
    return OrderMenuItem(
      id: json['id'],
      menuItemId: json['menu_item_id'],
      orderId: json['order_id'],
      currency: json['currency'],
      count: json['count'],
      price: json['price'] / 100.0,
      menuItem: MenuItem.fromJson(json['menu_item'])
    );
  }
}