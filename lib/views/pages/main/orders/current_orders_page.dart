import 'dart:async';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'order_page.dart';

import '../../../routes/default_page_route.dart';

import '../../../widgets/timer_widget.dart';

import '../../../../helpers/api/main_api.dart';
import '../../../../helpers/api/consts.dart';
import '../../../../helpers/view/formatter.dart';
import '../../../../helpers/view/localization.dart';

import '../../../../models/api/order.dart';
import '../../../../models/api/order_menu_item.dart';
import '../../../../models/storage/cache.dart';

class CurrentOrdersPage extends StatefulWidget {
  
  //BuildContext parentContext;

  //CurrentOrdersPage({this.parentContext}){}

  @override
  CurrentOrdersPageState createState() => CurrentOrdersPageState();
}

class CurrentOrdersPageState extends State<CurrentOrdersPage> with AutomaticKeepAliveClientMixin {
  Timer timer;

  GlobalKey<RefreshIndicatorState> refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    if (Cache.currentOrders == null){
      MainAPI.getMyCurrentOrders().then(
        (res){
          setState(() {
            Cache.currentOrders = res;      
            timer = Timer.periodic(Duration(minutes: 1), onTimer);        
          });        
        }     
      );
    } else if (Cache.currentOrders.isNotEmpty){
      timer = Timer.periodic(Duration(minutes: 1), onTimer);        
    }
  }

  @override
  void dispose(){
    super.dispose();
    if (timer != null){
      timer.cancel();
      timer = null;
    }
  }

  void onTimer(Timer timer){
    setState(
      () {
      }
    );
  }

  Future<Null> onRefresh(){
    return MainAPI.getMyCurrentOrders().then(
      (res){
        setState(() {
          Cache.currentOrders = res;      
          timer = Timer.periodic(Duration(minutes: 1), onTimer);        
        });        
      }     
    );
  }

  Widget buildTimer(Order order){
    if (order.orderStatus == Consts.noPayment){
      return Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: 40.0,
        child: FlatButton(
          color: Color.fromARGB(255, 247, 131, 6),
          onPressed: (){   
          },
          child: Text(Localization.buttonPay,
            style: TextStyle(
              color: Colors.white
            ),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))
        ),
      );
    } else if (order.orderStatus == Consts.ready){
      return Container();
    } else if (order.orderStatus == Consts.inProcess) {
      Duration left = order.timeLeft();
      if (left.isNegative){
        return Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: 40.0,
          child: FlatButton(
            color: Color.fromARGB(255, 247, 131, 6),
            onPressed: (){    
              setState(
                () {
                  Cache.currentOrders.remove(order);      
                  Cache.statistics = null;          
                }
              );
            },
            child: Text(Localization.buttonFinishOrder,
              style: TextStyle(
                color: Colors.white
              ),
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))
          ),
        );
      } else {
        return Column(
          children:[
            Divider(),
            Text(Localization.textOrderReady,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey
              )
            ),
            Text(Formatter.longDuration(order.timeLeft()),
              style: TextStyle(
                fontSize: 28.0,
                color: Color.fromARGB(255, 247, 131, 6)
              )
            )
          ]         
        );
      }
    } 
  }

  Widget buildOrderStatus(Order order){
    String text;
    Color color;
    if (order.orderStatus == Consts.noPayment){
      text = Localization.textNotPayed;
      color = Color.fromARGB(255, 227, 116, 116);
    } else if (order.orderStatus == Consts.inProcess) {
      text = Localization.textInProcess;
      color = Color.fromARGB(255, 190, 190, 0);
    } else if (order.orderStatus == Consts.ready) {
      text = Localization.textReady;
      color = Color.fromARGB(255, 0, 150, 0);
    }
    return Container(
      width: MediaQuery.of(context).size.width * 0.25,
      height: 25.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)), 
        border: Border.all(
          color: color
        )
      ),
      child: Container(
        margin: const EdgeInsets.only(top: 4.0),
        child: Text(text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: color
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Cache.currentOrders.first.orderStatus = 'in_process';
    if (Cache.currentOrders == null){
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(Localization.titleOrders),
            backgroundColor: Color.fromARGB(255, 247, 131, 6),     
          ),
          body: Center(
            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Color.fromARGB(255, 247, 131, 6))),            
          ),
        )
      );
    }
    if (Cache.currentOrders.isEmpty){
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
              title: Text(Localization.titleOrders,
            ),
            backgroundColor: Color.fromARGB(255, 247, 131, 6),     
          ),
          body: RefreshIndicator(
            onRefresh: onRefresh,
            key: refreshIndicatorKey,
            color: Color.fromARGB(255, 247, 131, 6),
            child: Center(
              child: Text(Localization.textNoOrders,
                style: TextStyle(fontSize: 25.0, color: Color.fromARGB(160, 0, 0, 0)),
              )
            ),
          )
        )
      );
    }
    return MaterialApp(
      title: Localization.titleOrders,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(Localization.titleOrders,
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
        body: RefreshIndicator(
          onRefresh: onRefresh,
          key: refreshIndicatorKey,
          color: Color.fromARGB(255, 247, 131, 6),
          child: ListView.builder(
          itemCount: Cache.currentOrders.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  DefaultPageRoute(builder: (context) => OrderPage(order: Cache.currentOrders[index])),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
                width: MediaQuery.of(context).size.width * 1.0,
                child: Card(
                  child:  Container(
                    margin: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 1.0,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            Padding(padding: EdgeInsets.only(top: 0.0)),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:[
                                Text('${Localization.textOrder} №${Cache.currentOrders[index].id.substring(0, 8)}',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black
                                  ),
                                ),
                                buildOrderStatus(Cache.currentOrders[index]),             
                              ]
                            ),
                            Padding(padding: EdgeInsets.only(top: 2.0)),
                            Text('${Localization.textOrderedAt} ${DateFormat('HH:mm dd.MM.y').format(Cache.currentOrders[index].createdAt)}',
                              style: TextStyle(
                                color: Colors.grey
                              ),
                            ), 
                            Padding(padding: EdgeInsets.only(top: 15.0)),
                            Row(
                              children: [
                                Icon(Icons.location_on,
                                  size: 20.0,
                                  color: Color.fromARGB(160, 0, 0, 0)
                                ),
                                Padding(padding: EdgeInsets.only(right: 5.0)),
                                Expanded(
                                  child: Text('${Cache.currentOrders[index].restaurant.name} (${Cache.currentOrders[index].restaurant.address})',
                                    style: TextStyle(
                                      color: Color.fromARGB(160, 0, 0, 0)
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Padding(padding: EdgeInsets.only(top: 10.0)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.view_headline,
                                  size: 20.0,
                                  color: Color.fromARGB(160, 0, 0, 0)
                                ),
                                Padding(padding: EdgeInsets.only(right: 5.0)),
                                Text(
                                  Cache.currentOrders[index].orderMenuItems.map((item) => '${item.menuItem.name} x ${item.count}').join('\n'),
                                  overflow: TextOverflow.fade,
                                  maxLines: 3,
                                  style: TextStyle(
                                    color: Color.fromARGB(160, 0, 0, 0)
                                  ),
                                )
                              ]
                            ),
                            Padding(padding: EdgeInsets.only(top: 10.0)),
                            Row(
                              children: [
                                Icon(Icons.attach_money,
                                  size: 20.0,
                                  color: Color.fromARGB(160, 0, 0, 0)
                                ),
                                Padding(padding: EdgeInsets.only(right: 5.0)),
                                Text('${Cache.currentOrders[index].price} ${Localization.textRUB}',
                                  style: TextStyle(
                                    color: Color.fromARGB(160, 0, 0, 0)
                                  ),
                                ),
                              ],
                            ),
                            Padding(padding: EdgeInsets.only(top: 10.0)),
                            Row(
                              children: [
                                Icon(Icons.timer,
                                  size: 20.0,
                                  color: Color.fromARGB(160, 0, 0, 0)
                                ),
                                Padding(padding: EdgeInsets.only(right: 5.0)),
                                Text(DateFormat('HH:mm dd.MM.y').format(Cache.currentOrders[index].date),
                                  style: TextStyle(
                                    color: Color.fromARGB(160, 0, 0, 0)
                                  ),
                                ),
                              ],
                            ),
                            Padding(padding: EdgeInsets.only(top: 5.0)),
                            Container(
                              alignment: Alignment.center,
                              child: buildTimer(Cache.currentOrders[index])
                            )
                          ]
                        ),
                      ),    
                    )
                  )
                ),
              );
            }
          ),
        ), 
      )     
    );
  }
}
