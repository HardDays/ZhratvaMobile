import '../../helpers/api/main_api.dart';

class MenuItem{
  String name;
  String coverId;
  String description;
  String currency;
  double price;
  int creationTime;
  int kCal;

  MenuItem({this.name, this.description, this.price, this.currency, this.coverId, this.creationTime, this.kCal});
  
  String cover(){
    return MainAPI.getImageUrl(coverId);
  }

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      name: json['name'],
      description: json['description'],
      coverId: json['cover_id'],
      price: json['price'] / 100,
      currency: json['currency'],
      creationTime: json['creation_time'],
      kCal: json['kcal']
    );
  }
}