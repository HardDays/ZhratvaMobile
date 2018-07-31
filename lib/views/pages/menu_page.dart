import 'package:flutter/material.dart';
import 'menu_item_page.dart';
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
      name: 'Оочень Большой Пельмень', 
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
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 247, 131, 6),
        actions: [
            IconButton(
              icon: Icon(Icons.add_shopping_cart),
              onPressed: () {
                
              },
            ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        children: List.generate(_list.length, (index) {
          return Container(
            margin: EdgeInsets.all(5.0),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.width * 0.53,
                  child: Card( 
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 15.0),
                            width:  MediaQuery.of(context).size.width * 0.27,
                            height: MediaQuery.of(context).size.width * 0.27,
                            decoration: BoxDecoration(
                            shape: BoxShape.circle,
                              image: DecorationImage(
                                image: ExactAssetImage('assets/images/placeholder.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 3.0)),
                          Text(_list[index].name,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 3.0)),
                          Text('${_list[index].price} р',
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black
                            ),
                          ),
                        ]
                      ),
                    ),
                  )
                ),
                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.52 - 20),
                  child: FlatButton(
                    color: Color.fromARGB(255, 247, 131, 6),
                    onPressed: (){
                      Navigator.push(
                        context,
                        DefaultPageRoute(builder: (context) => MenuItemPage()),
                      );
                    },
                    child: Text('Buy',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))
                  ),
                ),
              ]
            )
          );
        }),
      )
    );
  }
}
