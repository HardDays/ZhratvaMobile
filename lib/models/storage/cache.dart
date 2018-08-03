import '../api/restaurant.dart';
import '../api/menu_category.dart';
import '../api/menu_item.dart';

class Cache {
  static List<Restaurant> restaurants = [
      Restaurant(
        name: 'Good coffee',
        address: 'Kazan, Russia',
        hours: '12:00 - 15:00',
        openNow: true,
        distance: 2,
        rating: 5.0,
        description: 'Restaurant desciption asas ad sasdadasas aksjkasjaskjsa ksjaskjsdkdajskaj aksjaskasjksjakasjkas',
        menuCategories: [
          MenuCategory(
            name: 'Coffee', 
            cover: 'assets/images/coffee.jpg',
            description: '',
            menuItems: [
              MenuItem(
                id: 1,
                name: 'Americano',
                description: 'Natural tasty coffee',
                price: 70.0
              ),
              MenuItem(
                id: 2,
                name: 'Cappuccino',
                description: 'Natural tasty coffee Natural tasty coffee Natural tasty coffee Natural tasty coffee ',
                price: 90.0
              ),
              MenuItem(
                id: 3,
                name: 'Expresso',
                description: 'Natural tasty coffee',
                price: 50.0
              )
            ]
          ),
          MenuCategory(
            name: 'Dessert', 
            cover: 'assets/images/dessert.jpg',
            menuItems: [
              MenuItem(
                id: 4,
                name: 'Cherry pie',
                description: 'Hot pie',
                price: 50.0
              ),
              MenuItem(
                id: 5,
                name: 'Apple pie',
                description: 'Hot pie',
                price: 50.0
              ),
              MenuItem(
                id: 6,
                name: 'Cake',
                description: '',
                price: 40.0
              ),
              MenuItem(
                id: 7,
                name: 'Brownie',
                description: 'Coffee taste',
                price: 50.0
              )
            ]
          ),
        ]
      ),
      Restaurant(
        name: 'Nice coffee',
        address: 'Kazan, Russia',
        hours: '12:00 - 15:00',
        openNow: true,
        distance: 5,
        rating: 4.5,
        description: 'Restaurant desciption',
        menuCategories: [
          MenuCategory(
            name: 'Coffee', 
            cover: 'assets/images/coffee.jpg',
            description: '',
            menuItems: [
              MenuItem(
                id: 8,
                name: 'Americano',
                description: 'Natural tasty coffe',
                price: 70.0
              ),
              MenuItem(
                id: 9,
                name: 'Cappuccino',
                description: 'Natural tasty coffe',
                price: 90.0
              ),
              MenuItem(
                id: 10,
                name: 'Expresso',
                description: 'Natural tasty coffe',
                price: 50.0
              )
            ]
          ),
          MenuCategory(
            name: 'Dessert', 
            cover: 'assets/images/dessert.jpg',
            menuItems: [
              MenuItem(
                id: 11,
                name: 'Cherry pie',
                description: 'Hot pie',
                price: 50.0
              ),
              MenuItem(
                id: 12,
                name: 'Apple pie',
                description: 'Hot pie',
                price: 50.0
              ),
              MenuItem(
                id: 13,
                name: 'Cake',
                description: '',
                price: 40.0
              ),
              MenuItem(
                id: 14,
                name: 'Brownie',
                description: 'Coffee taste',
                price: 50.0
              )
            ]
          ),
        ]
      ),
      Restaurant(
        name: 'Tasty coffee',
        address: 'Kazan, Russia, Peterburgskaya street',
        hours: '12:00 - 15:00',
        openNow: false,
        distance: 10,
        rating: 4.3,
        description: 'Restaurant desciption',
        menuCategories: [
          MenuCategory(
            name: 'Coffee', 
            cover: 'assets/images/coffee.jpg',
            description: '',
            menuItems: [
              MenuItem(
                id: 15,
                name: 'Americano',
                description: 'Natural tasty coffe',
                price: 70.0
              ),
              MenuItem(
                id: 16,
                name: 'Cappuccino',
                description: 'Natural tasty coffe',
                price: 90.0
              ),
              MenuItem(
                id: 17,
                name: 'Expresso',
                description: 'Natural tasty coffe',
                price: 50.0
              )
            ]
          ),
          MenuCategory(
            name: 'Dessert', 
            cover: 'assets/images/dessert.jpg',
            menuItems: [
              MenuItem(
                id: 18,
                name: 'Cherry pie',
                description: 'Hot pie',
                price: 50.0
              ),
              MenuItem(
                id: 19,
                name: 'Apple pie',
                description: 'Hot pie',
                price: 50.0
              ),
              MenuItem(
                id: 20,
                name: 'Cake',
                description: '',
                price: 40.0
              ),
              MenuItem(
                id: 21,
                name: 'Brownie',
                description: 'Coffee taste',
                price: 50.0
              )
            ]
          ),
        ]
      ),
    ];
}