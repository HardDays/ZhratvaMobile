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

class PaymentPage extends StatefulWidget {
  
  PaymentPage(){
  }

  @override
  PaymentPageState createState() => PaymentPageState();
}
  
class PaymentPageState extends State<PaymentPage> with SingleTickerProviderStateMixin {
  Order order;
  TimeOfDay time;
  DateTime beginDate;
  bool loading;   

  @override
  void initState(){
    super.initState();
    setState(
      () {
        loading = false;
        order = Order(carryOption: 'with_me', peopleCount: 1);   

        int maxCnt = 14;
        bool canNow = false;
        try {
          String day = DateFormat('EEEE').format(DateTime.now()).toLowerCase();
          var wh = Cart.restaurant().workingHours.firstWhere((w) => (w.day == day));
          var curTime = DateFormat('HH:mm').format(DateTime.now().add(Duration(seconds: max(300, Cart.totalCookingTime()))));
          canNow = wh.open.compareTo(curTime) < 0 && wh.close.compareTo(curTime) > 0;
        } catch (ex) {
        }

        beginDate = DateTime.now();

        if (!canNow){
          for (int i = 1; i < maxCnt; i++){
            try {
              var date = DateTime.now().add(Duration(days: i));
              String day = DateFormat('EEEE').format(date).toLowerCase();
              Cart.restaurant().workingHours.firstWhere((w) => (w.day == day));
              beginDate = date;
              break;
            } catch (ex) {
            }
          }
        }
        order.date = beginDate;

        String day = DateFormat('EEEE').format(order.date).toLowerCase();
        var wh = Cart.restaurant().workingHours.firstWhere((w) => (w.day == day));
                  
        var firstTime = wh.open;
        
        if (order.date.day == DateTime.now().day){
          firstTime = DateFormat('HH:mm').format(DateTime.now().add(Duration(seconds: max(300, Cart.totalCookingTime()))));
        }
        time = TimeOfDay.fromDateTime(DateTime.parse('1970-01-01 ${firstTime}'));
      }
    );
  }

  void onPlus(){
    if (order.peopleCount < 5){
      setState(() {
        order.peopleCount += 1;      
      });
    }
  }

  void onMinus(){
    if (order.peopleCount > 1){
      setState(() {
        order.peopleCount -= 1;
      });
    }
  }

  void showDate(){
    showDatePicker(
      context: context,
      firstDate: beginDate,
      lastDate: DateTime.now().add(Duration(days: 14)),
      initialDate: beginDate,
      //locale: Locale('ru', 'RU'),
      selectableDayPredicate: (date) {
        String day = DateFormat('EEEE').format(date).toLowerCase();
        try {
          Cart.restaurant().workingHours.firstWhere((w) => (w.day == day));
          return true;
        } catch (ex) {
          return false;
        }
      }
    ).then(
      (date){
        setState(
          () {
            if (date != null){
              time = null;
              order.date = date;
            }
          }
        );
      }
    );
  }

  void showTime(){
    if (order.date == null){
      showDialog(context: context, 
        child: AlertDialog(
          title: Text(Localization.word('No date')),
          content: Text(Localization.word('Please, select the date')),
           actions: [
            FlatButton(
              child: Text(Localization.word('OK')),
              onPressed: () {  
                Navigator.pop(context);             
              }
            ),
          ],
        )
      );
      } else {
        String day = DateFormat('EEEE').format(order.date).toLowerCase();
        var wh = Cart.restaurant().workingHours.firstWhere((w) => (w.day == day));
                  
        var firstTime = wh.open;
        var secondTime = wh.close;
        
        if (order.date.day == DateTime.now().day){
          firstTime = DateFormat('HH:mm').format(DateTime.now().add(Duration(seconds: max(300, Cart.totalCookingTime()))));
        }
        showTimePicker(
          initialTime: TimeOfDay.fromDateTime(DateTime.parse('1970-01-01 ${firstTime}')),
          context: context,
        ).then(
          (time){
            setState(
              () {
                if (time != null){
                  var date = DateTime(order.date.year, order.date.month, order.date.day, time.hour, time.minute);      
                  var selectedTime = DateFormat('HH:mm').format(date); 

                  if (firstTime.compareTo(selectedTime) > 0 || secondTime.compareTo(selectedTime) < 0){
                    showDialog(context: context, 
                      child: AlertDialog(
                        title: Text(Localization.word('Wrong time')),
                        content: Text('${Localization.word('Please, select time in range')} ${firstTime} - ${secondTime}'),
                        actions: [
                          FlatButton(
                            child: Text(Localization.word('OK')),
                            onPressed: () {  
                              Navigator.pop(context);             
                            }
                          ),
                        ],
                      )
                    );
                  } else {
                    this.time = time;
                    order.date = date;
                  }
                }
              }
            );
          }
      );
    }
  }

  void pay(){
    if (order.date == null || time == null){
      showDialog(context: context, 
        child: AlertDialog(
          title: Text(Localization.word('No date or time')),
          content: Text(Localization.word('Please, select date and time')),
          actions: [
            FlatButton(
              child: Text(Localization.word('OK')),
              onPressed: () {  
                Navigator.pop(context);             
              }
            ),
          ],
        )
      );
    }else{
      order.date = DateTime(order.date.year, order.date.month, order.date.day, time.hour, time.minute);
      order.orderMenuItems = Cart.items();
      setState(() {
         loading = true;     
      });
      MainAPI.createOrder(order).then(
        (res){
          setState(
            () {
              loading = false;     
            }
          );
          if (res == null){
            showDialog(context: context, 
              child: AlertDialog(
                title: Text(Localization.word('Error')),
                content: Text(Localization.word('Please, try again later')),
                actions: [
                  FlatButton(
                    child: Text(Localization.word('OK')),
                    onPressed: () {  
                      Navigator.pop(context);             
                    }
                  ),
                ],
              )
            );  
          }else{
            showDialog(context: context, 
              child: AlertDialog(
                title: Text(Localization.word('Success')),
                content: Text(Localization.word('Your order was created')),
                actions: [
                  FlatButton(
                    child: Text(Localization.word('OK')),
                    onPressed: () {  
                      Cart.clear();
                      Cache.currentOrders = null;
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        DefaultPageRoute(builder: (context) => MainPage(index: 0)),
                      );
                    }
                  ),
                ],
              )
            );
          } 
        }     
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading){
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(Localization.word('Order details')),
            backgroundColor: Color.fromARGB(255, 247, 131, 6),     
          ),
          body: Center(
            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Color.fromARGB(255, 247, 131, 6))),            
          ),
        )
      );
    }
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
                            child: Text('${Cart.restaurant().name} (${Cart.restaurant().address})',
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
                        children: List.generate(Cart.items().length, 
                          (index) {
                            OrderMenuItem item = Cart.items()[index];
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
                  Padding(padding: EdgeInsets.only(top: 15.0)),
                  Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Text(Localization.word('Variants'),
                      style: TextStyle(
                        fontSize: 20.0  
                      ),
                    )
                  ),
                  Padding(padding: EdgeInsets.only(top: 10.0)),
                  Card(
                    child: Container(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0, bottom: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child:  InkWell(
                              onTap: (){
                                setState(() {
                                  order.carryOption = 'with_me';                              
                                });
                              },
                              child: Container(
                                height: 40.0,
                                decoration: BoxDecoration(
                                  color: order.carryOption == 'with_me' ? Color.fromARGB(255, 247, 131, 6) : Colors.white,
                                  border: Border.all(
                                    color: order.carryOption == 'with_me' ? Colors.white : Color.fromARGB(160, 0, 0, 0),
                                    width: 0.5
                                  ),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                child: Center(child: 
                                  Text(Localization.word('WITH ME'),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: order.carryOption == 'with_me' ? Colors.white : Color.fromARGB(160, 0, 0, 0),
                                      fontWeight: FontWeight.w600
                                    ),
                                  )
                                ), 
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child:  InkWell(
                              onTap: (){
                                setState(() {
                                  order.carryOption = 'on_place';                              
                                });
                              },
                              child: Container(
                                height: 40.0,
                                decoration: BoxDecoration(
                                  color: order.carryOption == 'on_place' ? Color.fromARGB(255, 247, 131, 6) : Colors.white,
                                  border: Border.all(
                                    color:  order.carryOption == 'on_place' ? Colors.white : Color.fromARGB(160, 0, 0, 0),
                                    width: 0.5
                                  ),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                child: Center(child: 
                                  Text(Localization.word('ON PLACE'),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: order.carryOption == 'on_place' ? Colors.white : Color.fromARGB(160, 0, 0, 0),
                                      fontWeight: FontWeight.w600
                                    ),
                                  )
                                ), 
                              ),
                            ),
                          ),
                        ],
                      )
                    )
                  ),
                  Padding(padding: EdgeInsets.only(top: 15.0)),
                  Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Text(Localization.word('People count'),
                      style: TextStyle(
                        fontSize: 20.0  
                      ),
                    )
                  ),
                  Padding(padding: EdgeInsets.only(top: 10.0)),
                  Card(
                    child: Container(
                      padding: EdgeInsets.only(top: 15.0, bottom: 15.0, right: 50.0, left: 50.0),
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
                          Text('${order.peopleCount}',
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
                      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0, bottom: 15.0),
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 40.0,
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: OutlineButton(
                              borderSide: BorderSide(
                                color: Color.fromARGB(160, 0, 0, 0)
                              ),
                              color: Colors.white,
                              onPressed: (){ 
                                showDate();
                              },
                              child: Text(order.date == null ? Localization.word('DATE') : DateFormat('dd.MM.yyy').format(order.date),
                                style: TextStyle(
                                  color: Color.fromARGB(160, 0, 0, 0)
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0)
                              )
                            ),    
                          ),
                          Container(
                            height: 40.0,
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: OutlineButton(
                              borderSide: BorderSide(
                                color: Color.fromARGB(160, 0, 0, 0)
                              ),
                              color: Colors.white,
                              onPressed: (){    
                                showTime();
                              },
                              child: Text(time == null ? Localization.word('TIME') : '${time.format(context)}',
                                style: TextStyle(
                                  color: Color.fromARGB(160, 0, 0, 0)
                                ),
                              ),
                              
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0)
                              )
                            ),               
                          )
                        ],
                      ),        
                    )
                  ),       
                  Padding(padding: EdgeInsets.only(top: 25.0)),
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
                        child: Text('${Cart.totalPrice()} ${Localization.word(Cart.items()[0].menuItem.currency)}',
                          style: TextStyle(
                            fontSize: 20.0  
                          ),
                        )
                      )
                    ]
                  ),
                  Padding(padding: EdgeInsets.only(top: 15.0)),
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(left: 5.0, right: 5.0),
                      width: MediaQuery.of(context).size.width * 1.0,
                      height: 50.0,
                      child: FlatButton(
                        color: Color.fromARGB(255, 247, 131, 6),
                        onPressed: (){                              
                          pay();
                        },
                        child: Text(Localization.word('PAY'),
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))
                      ),
                    )
                  )
                ]
              ),
            )
          );
        }
      )
    );
  }
}