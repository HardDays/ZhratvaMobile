import 'menu_item.dart';

class MenuCategory{
  String name;
  String cover;
  String description;

  List <MenuItem> menuItems = [];

  MenuCategory({this.name, this.cover, this.description, this.menuItems});
}