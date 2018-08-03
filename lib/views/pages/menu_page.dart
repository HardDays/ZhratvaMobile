import 'package:flutter/material.dart';
import 'menu_item_page.dart';
import 'cart_page.dart';

import '../routes/default_page_route.dart';

import '../../models/storage/cart.dart';
import '../../models/api/menu_item.dart';


class MenuPage extends StatelessWidget {

  List <MenuItem> _list = [];

  MenuPage(List<MenuItem> list){
    _list = list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu',
          style: TextStyle(
            color: Colors.white
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 247, 131, 6),
        actions: [
            (Cart.items.length > 0) ? Stack(
              children:[
                IconButton(
                  icon: Icon(Icons.shopping_cart,),
                  onPressed: () {          
                    Navigator.push(
                      context,
                      DefaultPageRoute(builder: (context) => CartPage()),
                    );
                  },
                ),
                Container(
                  width: 48.0,
                  height: 24.0,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 24.0),
                  child: Text('${Cart.items.values.map((item) => item.count).reduce((a, b) => a + b)}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red
                  )
                )
              ]
            ) :  
            IconButton(
              icon: Icon(Icons.shopping_cart,),
              onPressed: () {          
                Navigator.push(
                  context,
                  DefaultPageRoute(builder: (context) => CartPage()),
                );
              },
            ),
          ]       
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
                        DefaultPageRoute(builder: (context) => MenuItemPage(_list[index])),
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
