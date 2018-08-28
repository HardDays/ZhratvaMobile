import 'dart:math';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'main_page.dart';

import '../widgets/cart_widget.dart';

import '../../helpers/view/localization.dart';
import '../../helpers/view/formatter.dart';
import '../../helpers/api/main_api.dart';

import '../../models/storage/cache.dart';
import '../../models/storage/cart.dart';

import '../../models/api/menu_item.dart';
import '../../models/api/order.dart';
import '../../models/api/order_menu_item.dart';

import '../routes/default_page_route.dart';

class OrderPage extends StatefulWidget {
  Order order;

  OrderPage({this.order}){
  }

  @override
  OrderPageState createState() =>OrderPageState();
}
  
class OrderPageState extends State<OrderPage> with SingleTickerProviderStateMixin {
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      appBar: AppBar(
        centerTitle: true,
        title: Text(Localization.word('Order details'),
          style: TextStyle(
            color: Colors.white
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        backgroundColor: Color.fromARGB(255, 247, 131, 6),
        actions: [
        ]           
      ),
      body: Builder(
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5.0, top: 5.0),
                    child: Text(Localization.word('Address'),
                      style: TextStyle(
                        fontSize: 20.0  
                      ),
                    )
                  ),
                  Padding(padding: EdgeInsets.only(top: 10.0)),
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Icon(Icons.location_on,
                            size: 24.0,
                            color: Color.fromARGB(160, 0, 0, 0),
                          ),
                          Padding(padding: EdgeInsets.only(right: 5.0)),
                          Expanded (
                            child: Text('${widget.order.restaurant.name} (${widget.order.restaurant.address})',
                              style: TextStyle(
                                color: Color.fromARGB(160, 0, 0, 0),
                                fontSize: 16.0
                              ),
                            )
                          )
                        ],
                      ), 
                    )
                  ),
                  Padding(padding: EdgeInsets.only(top: 15.0)),
                  Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Text(Localization.word('When'),
                      style: TextStyle(
                        fontSize: 20.0  
                      ),
                    )
                  ), 
                  Padding(padding: EdgeInsets.only(top: 10.0)),
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today,
                            size: 20.0,
                            color: Color.fromARGB(160, 0, 0, 0),
                          ),
                          Padding(padding: EdgeInsets.only(right: 10.0)),
                          Expanded (
                            child: Text(DateFormat('HH:mm dd.MM.yyy').format(widget.order.date),
                              style: TextStyle(
                                color: Color.fromARGB(160, 0, 0, 0),
                                fontSize: 16.0
                              ),
                            )
                          )
                        ],
                      ), 
                    )
                  ),
                  Padding(padding: EdgeInsets.only(top: 15.0)),
                  Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Text(Localization.word('My order'),
                      style: TextStyle(
                        fontSize: 20.0  
                      ),
                    )
                  ),
                  Padding(padding: EdgeInsets.only(top: 10.0)),
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: List.generate(widget.order.orderMenuItems.length, 
                          (index) {
                            OrderMenuItem item = widget.order.orderMenuItems[index];
                            return Container(
                              padding: EdgeInsets.only(top: 5.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.45,
                                    child: Text(item.menuItem.name,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                      color: Color.fromARGB(160, 0, 0, 0),
                                        fontSize: 16.0
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width * 0.1,
                                    child: Text('x ${item.count}',
                                      style: TextStyle(
                                      color: Color.fromARGB(160, 0, 0, 0),
                                        fontSize: 16.0
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topRight,
                                    width: MediaQuery.of(context).size.width * 0.3,
                                    child: Text('${item.count * item.menuItem.price} ${Localization.word(item.menuItem.currency)}',
                                      style: TextStyle(
                                      color: Color.fromARGB(160, 0, 0, 0),
                                        fontSize: 16.0
                                      ),
                                    ),
                                  )
                                ],
                              )
                            );
                          }
                        ),
                      ),
                    )
                  ),     
                  Padding(padding: EdgeInsets.only(top: 20.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text(Localization.word('Total price'),
                          style: TextStyle(
                            fontSize: 20.0  
                          ),
                        )
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 5.0),
                        child: Text('${widget.order.price} ${Localization.word(widget.order.currency)}',
                          style: TextStyle(
                            fontSize: 20.0  
                          ),
                        )
                      )
                    ]
                  ),
                  Padding(padding: EdgeInsets.only(top: 20.0)),             
                ]
              ),
            )
          );
        }
      )
    );
  }
}