import 'package:flutter/material.dart';

import 'cart_page.dart';

import '../routes/default_page_route.dart';
import '../../models/cart_item.dart';
import '../../models/storage/cart.dart';
import '../../models/api/menu_item.dart';

class MenuItemPage extends StatefulWidget {
  
  MenuItem _item;

  MenuItemPage(MenuItem item){
    _item = item;
  }

  @override
  _MenuItemPageState createState() => _MenuItemPageState(_item);
}
  
class _MenuItemPageState extends State<MenuItemPage> with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;

  MenuItem _item;  
  int _count = 1;

  _MenuItemPageState(MenuItem item){
    _item = item;
    _controller = AnimationController(duration: const Duration(milliseconds: 100), vsync: this);
    _animation = Tween(begin: 24.0, end: 34.0).animate(_controller)..addListener(() {
      setState(() {
      });
    });
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });
  }

  void _onMinus(){
    if (_count > 1){
      setState(() {
        _count -= 1;                                                      
      });
    }
  }

  void _onPlus(){
    if (_count < 5){
        setState(() {
        _count += 1;
      });
    }
  }

  void _onAdd(BuildContext context){
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text('${_item.name} added to your cart'),
    ));
    _controller.forward();
    Cart.items.add(CartItem(
      count: _count,
      item: _item
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      appBar: AppBar(
        centerTitle: true,
        title: Text(_item.name,
          style: TextStyle(
            color: Colors.white
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white
        ),
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
                  child: Text('${Cart.items.map((item) => item.count).reduce((a, b) => a + b)}',
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
      body: Builder(
        builder: (BuildContext context) {
          return Container(
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
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 40.0,
                        width: 40.0,
                        child: FlatButton(
                          color: Color.fromARGB(255, 227, 116, 116),
                          onPressed: (){
                            _onMinus();
                          },
                          child: Text('-',
                            textAlign: TextAlign.center,
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
                        height: 40.0,
                        width: 40.0,
                        child: FlatButton(
                          color: Color.fromARGB(255, 87, 176, 60),  
                          onPressed: (){
                            _onPlus();
                          },
                          child: Text('+',
                            textAlign: TextAlign.center,
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
                  child: 
                    FlatButton(
                      color: Color.fromARGB(255, 247, 131, 6),
                      onPressed: (){
                        _onAdd(context);
                      },
                      child: Text('ADD TO CART',
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))
                    )
                ),  
              ]
            ),
          );
        }
      )
    );
  }
}