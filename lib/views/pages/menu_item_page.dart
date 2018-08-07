import 'package:flutter/material.dart';

import '../widgets/cart_widget.dart';

import '../../models/cart_item.dart';
import '../../models/storage/cart.dart';
import '../../models/api/menu_item.dart';

class MenuItemPage extends StatefulWidget {
  
  MenuItem item;

  MenuItemPage({this.item}){
  }

  @override
  _MenuItemPageState createState() => _MenuItemPageState();
}
  
class _MenuItemPageState extends State<MenuItemPage> with SingleTickerProviderStateMixin {

  CartWidget _cart;

  int _count = 1;

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
      content: new Text('${widget.item.name} added to your cart'),
    ));
    Cart.items.add(CartItem(
      count: _count,
      item: widget.item
    ));
    setState(() {          
    });
  }

  @override
  Widget build(BuildContext context) {
    _cart = CartWidget();
    return Scaffold(  
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.item.name,
          style: TextStyle(
            color: Colors.white
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        backgroundColor: Color.fromARGB(255, 247, 131, 6),
        actions: [
          _cart
        ]           
      ),
      body: Builder(
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Container(
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
                        image: NetworkImage(widget.item.cover()),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 35.0)),
                  Text('${widget.item.price} р',
                    style: TextStyle(
                      color: Color.fromARGB(255, 247, 131, 6),
                      fontSize: 30.0
                    )
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 35.0, left: MediaQuery.of(context).size.width * 0.15, right: MediaQuery.of(context).size.width * 0.15),      
                    child: Text(widget.item.description,
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 25.0)),
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
                  Padding(padding: EdgeInsets.only(top: 25.0)),
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
            )
          );
        }
      )
    );
  }
}