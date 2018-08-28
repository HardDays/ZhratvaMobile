import '../api/restaurant.dart';
import '../api/menu_category.dart';
import '../api/user.dart';
import '../api/order.dart';
import '../api/statistics.dart';

class Cache {
  static List<Restaurant> restaurants;
  static List<Order> currentOrders;

  static User currentUser;
  static List<Statistics> statistics;

  static void flush(){
    restaurants = null;
    currentOrders = null;
    statistics = null;
    currentUser = null;
  }
}