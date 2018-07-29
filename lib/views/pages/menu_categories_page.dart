import 'package:flutter/material.dart';
import 'main_page.dart';
import '../routes/default_page_route.dart';
import '../../models/menu_category.dart';

class MenuCategoriesPage extends StatelessWidget {

  List <MenuCategory> _list = [
    MenuCategory(
      name: 'Кофе', 
      description: 'Вкусно',
      count: 228
    ),
    MenuCategory(
      name: 'Пельмени', 
      description: 'Очень большой',
      count: 1499
    ),
    MenuCategory(
      name: 'Борщи', 
      description: 'Вкусно',
      count: 123
    ),
    MenuCategory(
      name: 'Вискас', 
      description: 'Для байта',
      count: 228
    ),
    MenuCategory(
      name: 'Дошики', 
      description: 'Элитная пища',
      count: 228
    )
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
        backgroundColor: Color.fromARGB(255, 247, 131, 6)
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        children: List.generate(_list.length, (index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0, top: 10.0),
            child: Container(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),   
                      image: DecorationImage(
                        image: ExactAssetImage('assets/images/placeholder.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),                   
                  Text(_list[index].name,
                    style: TextStyle(
                      fontSize: 18.0,
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
