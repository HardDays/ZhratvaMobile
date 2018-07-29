import 'package:flutter/material.dart';
import 'main_page.dart';
import '../routes/default_page_route.dart';
import '../../models/menu_item.dart';

class MenuPage extends StatelessWidget {

  List <MenuItem> _list = [
    MenuItem(
      name: 'Пельмень', 
      description: 'Вкусно',
      price: 228
    ),
    MenuItem(
      name: 'Большой Пельмень', 
      description: 'Очень большой',
      price: 1499
    ),
    MenuItem(
      name: 'Борщ', 
      description: 'Вкусно',
      price: 123
    ),
    MenuItem(
      name: 'Вискас', 
      description: 'Для байта',
      price: 228
    ),
    MenuItem(
      name: 'Дошик', 
      description: 'Элитная пища',
      price: 228
    )
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        children: List.generate(_list.length, (index) {
          return Card(
            child: Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Image.asset('assets/images/placeholder.jpg',
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.width * 0.5,
                        fit: BoxFit.cover,  
                      ),
                    ]
                  ),
                  Text(_list[index].name,
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black
                    ),
                  ),
                ]
              ),
            ),
          );
        }),
      )
    );
  }
}
