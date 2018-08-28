import '../../helpers/api/main_api.dart';

class MenuItem{
  String id;
  String name;
  String coverId;
  String description;

  String restaurantId;

  String currency;

  double price;
  int cookingTime;
  int kCal;

  MenuItem({this.id, this.name, this.description, this.price, this.coverId, this.cookingTime, this.kCal, this.restaurantId, this.currency});
  
  String cover(){
    return MainAPI.getImageUrl(coverId);
  }

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      coverId: json['cover_id'],
      price: json['price'] / 100,
      cookingTime: json['cooking_time'],
      kCal: json['kcal'],
      restaurantId: json['restaurant_id'],
      currency: json['currency']
    );
  }
}