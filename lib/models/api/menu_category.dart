import 'menu_item.dart';

import '../../helpers/api/main_api.dart';

class MenuCategory{
  String name;
  String coverId;
  String description;

  List <MenuItem> menuItems = [];

  String cover(){
    return MainAPI.getImageUrl(coverId);
  }

  MenuCategory({this.name, this.coverId, this.description, this.menuItems});

   factory MenuCategory.fromJson(Map<String, dynamic> json) {
    return MenuCategory(
      name: json['name'],
      description: json['description'],
      coverId: json['cover_id'],
      menuItems: json['menu_items'].map<MenuItem>((x) => MenuItem.fromJson(x)).toList()
    );
  }
}