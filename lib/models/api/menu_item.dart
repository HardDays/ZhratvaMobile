import '../../helpers/api/main_api.dart';

class MenuItem{
  String name;
  String coverId;
  String description;
  String currency;
  double price;

  MenuItem({this.name, this.description, this.price, this.currency, this.coverId});
  
  String cover(){
    return MainAPI.getImageUrl(coverId);
  }

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      name: json['name'],
      description: json['description'],
      coverId: json['cover_id'],
      price: json['price'] / 100,
      currency: json['currency']
    );
  }
}