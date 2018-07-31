import 'package:flutter/material.dart';
import 'menu_page.dart';
import '../routes/default_page_route.dart';
import '../../models/menu_category.dart';
import '../../models/menu_item.dart';

class MenuItemPage extends StatefulWidget {
  @override
  _MenuItemPageState createState() => _MenuItemPageState();
}


class _MenuItemPageState extends State<MenuItemPage> {

  MenuItem _item = MenuItem(
    name: 'Пельмень',
    price: 228,
    description: 'Пельмень канешно неплохо, но лучше вискас или дошик надо еще что-то добавить ввлад питух и не заметит'
  );
  
  int _count = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_item.name),
        backgroundColor: Color.fromARGB(255, 247, 131, 6),
        actions: [
            IconButton(
              icon: Icon(Icons.add_shopping_cart),
              onPressed: () {
                
              },
            ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 30.0),
              width:  MediaQuery.of(context).size.width * 0.55,
              height: MediaQuery.of(context).size.width * 0.55,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: ExactAssetImage('assets/images/placeholder.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 15.0)),
            Text('${_item.price} р',
              style: TextStyle(
                color: Color.fromARGB(255, 247, 131, 6),
                fontSize: 30.0
              )
            ),
            Container(
              margin: EdgeInsets.only(top: 15.0, left: MediaQuery.of(context).size.width * 0.15, right: MediaQuery.of(context).size.width * 0.15),      
              child: Text(_item.description,
                maxLines: 3,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 30.0)),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 30.0,
                    child: FlatButton(
                      color: Color.fromARGB(255, 227, 116, 116),
                      onPressed: (){
                        if (_count > 1){
                          setState(() {
                            _count -= 1;                                                      
                          });
                        }
                      },
                      child: Text('-',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0
                        ),
                      ),
                      shape: CircleBorder()
                    ),
                  ),  
                  Text('${_count}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.0
                    )
                  ),
                  Container(
                    height: 30.0,
                    child: FlatButton(
                      color: Color.fromARGB(255, 87, 176, 60),  
                      onPressed: (){
                        if (_count < 5){
                          setState(() {
                            _count += 1;
                          });
                        }
                      },
                      child: Text('+',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0
                        ),
                      ),
                      shape: CircleBorder()
                    ),
                  ),  
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 30.0)),
            Container(
              width:  MediaQuery.of(context).size.width * 0.6,
              height: 50.0,
              child: FlatButton(
                color: Color.fromARGB(255, 247, 131, 6),
                onPressed: (){
                },
                child: Text('ADD TO CART',
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))
              ),
            ),  
          ]
        ),
      )
    );
  }
}