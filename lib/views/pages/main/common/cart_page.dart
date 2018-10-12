import 'package:flutter/material.dart';

import '../orders/payment_page.dart';

import '../../../routes/default_page_route.dart';

import '../../../../helpers/view/formatter.dart';
import '../../../../helpers/view/localization.dart';
import '../../../../helpers/view/dialogs.dart';

import '../../../../models/storage/cart.dart';
import '../../../../models/cart_item.dart';

class CartPage extends StatefulWidget {
  
  @override
  CartPageState createState() => CartPageState();
}
  
class CartPageState extends State<CartPage> with SingleTickerProviderStateMixin {

  CartPageState(){
;
  }

  void onMinus(int index){
    if (Cart.items()[index].count > 1){
      setState(() {
        Cart.decCount(index);                        
      });
    }else{
      showDialog(context: context, 
        child: AlertDialog(
          title: Text(Localization.textRemove),
          content: Text(Localization.textRemoveFromCart),
          actions: [
            FlatButton(
              child: Text(Localization.buttonNo),
              onPressed: () {
                Navigator.pop(context);
              }
            ),
            FlatButton(
              child: Text(Localization.buttonYes),
              onPressed: () { 
                setState(() {
                  Cart.remove(index);             
                  Navigator.pop(context);     
                });
                if (Cart.items().isEmpty){
                  Navigator.pop(context);
                }
              }
            ),
          ],
        )
      );
    }
  }

  void onPlus(int index){
    setState(() {
      Cart.incCount(index);       
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(Localization.titleCart,
          style: TextStyle(
            color: Colors.white
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        backgroundColor: Color.fromARGB(255, 247, 131, 6),
        actions: [
        ],
      ),
      body: Column( 
        children: [ 
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
                alignment: Alignment.center,
                child: ListView(
                  children:  List.generate(Cart.items().length, (index){
                    return Container(
                          margin: EdgeInsets.only(left: 10.0, right: 10.0),
                          width: MediaQuery.of(context).size.width * 1.0,
                          height: MediaQuery.of(context).size.height * 0.15,
                          child: Card(
                            child: Container(
                              margin: EdgeInsets.all(10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.height * 0.10,
                                    height: MediaQuery.of(context).size.height * 0.10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: NetworkImage(Cart.items()[index].menuItem.cover()),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.3,
                                    margin: EdgeInsets.only(left: 15.0, top: 12.0, right: 10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(Cart.items()[index].menuItem.name,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 16.0
                                          ),
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 3.0)),
                                        Text('${Cart.items()[index].menuItem.price} ${Localization.textRUB}',
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: Color.fromARGB(255, 247, 131, 6)
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),           
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    width: MediaQuery.of(context).size.width * 0.3,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          width: 32.0,
                                          height: 24.0,
                                          child: FlatButton(  
                                            color: Color.fromARGB(255, 227, 116, 116),
                                            onPressed: (){
                                              onMinus(index);
                                            },
                                            child: Text('-',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.0
                                              ),
                                            ),
                                            shape: CircleBorder()
                                          ),
                                        ),  
                                        Text('${Cart.items()[index].count}',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 25.0
                                          )
                                        ),
                                        Container(
                                          width: 32.0,
                                          height: 24.0,
                                          child: FlatButton(
                                            color: Color.fromARGB(255, 87, 176, 60),  
                                            onPressed: (){
                                              onPlus(index);
                                            },
                                            child: Text('+',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.0
                                              ),
                                            ),
                                            shape: CircleBorder()
                                          ),
                                        ),  
                                      ],
                                    ),
                                  )
                                ]
                              )
                            ) 
                          ), 
                        );
                      }),
                    ),
          ),
          Divider(
            color: Colors.grey, 
            height: 1.0,
          ),
        /*  Padding(padding: EdgeInsets.only(top: 5.0)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [              
              Text('${_totalPrice} р',
                style: TextStyle(
                  fontSize: 25.0,
                  color: Color.fromARGB(255, 247, 131, 6)
                ),
              ),  
            ] 
          ),*/
          Expanded(
            child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Container(
              margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
              color: Colors.white,
              child: Column(
                children: [
                    Container(
                      alignment: Alignment.topCenter,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.attach_money,
                                color: Color.fromARGB(160, 0, 0, 0),
                                size: 20.0,
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 10.0, left: 3.0),
                                child: Text(Cart.items().isNotEmpty ? '${Cart.totalPrice()} ${Localization.textRUB}' : '',
                                  maxLines: 3,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Color.fromARGB(160, 0, 0, 0)
                                  ),
                                ) 
                              )
                            ]
                          ),
                          Row(
                            children: [
                              Icon(Icons.timer,
                                color: Color.fromARGB(160, 0, 0, 0),
                                size: 20.0,
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 10.0, left: 3.0),
                                child: Text(Cart.items().isNotEmpty ? '${Formatter.shortDuration(Duration(seconds: Cart.totalCookingTime()))}' : '',
                                  maxLines: 3,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Color.fromARGB(160, 0, 0, 0)
                                  ),
                                ) 
                              )
                            ]
                          ),
                          Row(
                            children: [
                              Icon(Icons.flash_on,
                                color: Color.fromARGB(160, 0, 0, 0),
                                size: 20.0,
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 10.0),
                                child: Text(Cart.items().isNotEmpty ? '${Cart.totalCal()} ${Localization.textKcal}' : '',
                                  maxLines: 3,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Color.fromARGB(160, 0, 0, 0)
                                  ),
                                ) 
                              )
                            ]
                          )
                        ],
                      )
                    ),
                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: 50.0,
                      child: FlatButton(
                        color: Color.fromARGB(255, 247, 131, 6),
                        onPressed: (){    
                           Navigator.push(
                            context,
                            DefaultPageRoute(builder: (context) => PaymentPage()),
                          );
                        },
                        child: Text(Localization.buttonProcessOrder,
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))
                      ),
                    )
                  ],
                )  
              ),
            )
          )
        ]
      )
    );
  }
}