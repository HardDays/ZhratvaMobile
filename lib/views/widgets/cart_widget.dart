import 'package:flutter/material.dart';

import '../../models/storage/cart.dart';

import '../pages/cart_page.dart';

import '../routes/menu_page_route.dart';

class CartWidget extends StatefulWidget {

  BuildContext parentContext;

  CartWidget({this.parentContext}){
  }

  @override
  CartWidgetState createState() => CartWidgetState();
}

class CartWidgetState extends State<CartWidget> with SingleTickerProviderStateMixin {

  void _onCart(BuildContext context){
    var ctx = widget.parentContext != null ? widget.parentContext : context;
    
    if (Cart.items.isEmpty){
      showDialog(context: ctx, 
        child: AlertDialog(
          title: new Text("Empty cart"),
          content: new Text("Please, add some items to your cart"),
        )
      );
    }else{
      Navigator.push(
        ctx,
        MenuPageRoute(builder: (ctx) => CartPage()),
      );
    }
  }

  @override 
  Widget build(BuildContext context) {
    if (Cart.items.isNotEmpty) {
      return GestureDetector(
        onTap: (){
          _onCart(context);
        },
        child: Stack(
          children:[
            Container(
              margin: EdgeInsets.only(left: 10.0),
              child: IconButton(
                icon: Icon(Icons.shopping_cart,),
                onPressed: () {          
                  _onCart(context);
                },
              )
            ),
            Container(
              width: 48.0,
              height: 20.0,
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 25.0),
              child: Text('${Cart.items.map((item) => item.count).reduce((a, b) => a + b)}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 11.0
                ),
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red
              )
            )
          ]
        )
      );
    }
    else{
      return IconButton(
        icon: Icon(Icons.shopping_cart,),
        onPressed: () {          
          _onCart(context);
        },
      );
    }
  }
}