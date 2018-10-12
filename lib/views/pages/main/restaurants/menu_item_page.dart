import 'package:flutter/material.dart';

import '../../../widgets/cart_widget.dart';

import '../../../../helpers/view/formatter.dart';
import '../../../../helpers/view/localization.dart';
import '../../../../helpers/view/dialogs.dart';

import '../../../../models/storage/cart.dart';

import '../../../../models/api/order_menu_item.dart';
import '../../../../models/api/menu_item.dart';
import '../../../../models/api/restaurant.dart';


class MenuItemPage extends StatefulWidget {
  
  MenuItem item;
  Restaurant restaurant;

  MenuItemPage({this.item, this.restaurant}){
  }

  @override
  MenuItemPageState createState() => MenuItemPageState();
}
  
class MenuItemPageState extends State<MenuItemPage> with SingleTickerProviderStateMixin {

  CartWidget cart;

  int count = 1;
  
  void onMinus(){
    if (count > 1){
      setState(() {
        count -= 1;                                                      
      });
    }
  }

  void onPlus(){
    if (count < 5){
        setState(() {
        count += 1;
      });
    }
  }

  void onAdd(BuildContext context){
    if (Cart.canAdd(widget.item)){
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: Text('${widget.item.name} ${Localization.textAddedToCart}'),
      ));
      setState(() {          
        Cart.add(OrderMenuItem(
          count: count,
          menuItem: widget.item,
          menuItemId: widget.item.id
        ));
        Cart.changeRestaurant(widget.restaurant);
      });
    }else{
      Dialogs.showMessage(context, Localization.textWrongItem, Localization.textFullCart, Localization.buttonOk);
    }
  }

  @override
  Widget build(BuildContext context) {
    cart = CartWidget();
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
          cart
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
                    width:  MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(widget.item.cover()),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 30.0)),
                  Text('${widget.item.price} ${Localization.textRUB}',
                    style: TextStyle(
                      color: Color.fromARGB(255, 247, 131, 6),
                      fontSize: 30.0
                    )
                  ),
                  Padding(padding: EdgeInsets.only(top: 25.0)),
                  Container(
                    alignment: Alignment.topCenter,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        widget.item.cookingTime != null ? 
                        Row(
                          children: [
                            Icon(Icons.timer,
                              color: Color.fromARGB(160, 0, 0, 0),
                              size: 20.0,
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 10.0, left: 3.0),
                              child: Text('${Formatter.shortDuration(Duration(seconds: widget.item.cookingTime))}',
                                maxLines: 3,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Color.fromARGB(160, 0, 0, 0)
                                ),
                              ) 
                            )
                          ]
                        ): Container(),
                        widget.item.kCal != null ? 
                        Row(
                          children: [
                            Icon(Icons.flash_on,
                              color: Color.fromARGB(160, 0, 0, 0),
                              size: 20.0,
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 10.0),
                              child: Text('${widget.item.kCal} ${Localization.textKcal}',
                                maxLines: 3,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Color.fromARGB(160, 0, 0, 0)
                                ),
                              ) 
                            )
                          ]
                        ) : Container(),
                      ],
                    )
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15.0, left: MediaQuery.of(context).size.width * 0.15, right: MediaQuery.of(context).size.width * 0.15),      
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
                              onMinus();
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
                        Text('${count}',
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
                              onPlus();
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
                          onAdd(context);
                        },
                        child: Text(Localization.buttonAddToCart,
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