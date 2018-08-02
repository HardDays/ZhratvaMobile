import 'menu_category.dart';

class Restaurant{
  String name;
  String cover;
  String address;
  String hours;
  String description;

  bool openNow;
  int distance;
  double rating;

  List <MenuCategory> menuCategories = [];

  Restaurant({this.name, this.address, this.hours, this.openNow, this.distance, this.description, this.rating, this.menuCategories});

}