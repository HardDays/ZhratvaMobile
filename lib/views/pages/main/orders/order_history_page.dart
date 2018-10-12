import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'dart:async';

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

class OrderHistoryPage extends StatefulWidget {
  
  BuildContext parentContext;

  OrderHistoryPage({this.parentContext}){
  }

  @override
  OrderHistoryPageState createState() => OrderHistoryPageState();
}

class OrderHistoryPageState extends State<OrderHistoryPage> with AutomaticKeepAliveClientMixin {
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  int limit = 25;
  int offset = 0;
  bool loadingScrolled = false;
  bool full = false;

  List <Order> orders;
  ScrollController scrollController;
  
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    if (orders == null){
      loadOrders();
    } 
    scrollController = ScrollController();
    scrollController.addListener(onScroll);
  }

  @override
  void dispose() {
    scrollController.removeListener(onScroll);
    super.dispose();
  }

  void onScroll(){
    if (!loadingScrolled){
      if (scrollController.position.extentAfter < 500 && !full){
        loadingScrolled = true;
        loadOrders();
      }
    }
  }

  Future<Null> onRefresh(){
    orders = null;
    offset = 0;
    return loadOrders();
  }

  Future<Null> loadOrders(){
    return MainAPI.getMyPastOrders(limit, offset).then(
      (res){
        setState(() {
          if (orders == null) {
            orders = [];
          }
          orders.addAll(res);
          offset += limit;
          loadingScrolled = false;
          full = res.length < limit;
        });        
      }     
    );
  }

  Widget buildOrderStatus(Order order){
    String text;
    Color color;
    if (order.orderStatus == Consts.noPayment){
      text = Localization.textNotPayed;
      color = Color.fromARGB(255, 227, 116, 116);
    } else if (order.orderStatus == Consts.inProcess || order.orderStatus == Consts.finished) {
      text = Localization.textFinished;
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
    if (orders == null){
      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(Localization.titleOrderHistory,
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Color.fromARGB(255, 247, 131, 6),   
            iconTheme: IconThemeData(
              color: Colors.white
            ),  
          ),
          body: Center(
            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Color.fromARGB(255, 247, 131, 6))),            
          ),
      );
    }
    if (orders.isEmpty){
      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(Localization.titleOrderHistory, 
              style: TextStyle(color: Colors.white)
            ),
            backgroundColor: Color.fromARGB(255, 247, 131, 6),     
            iconTheme: IconThemeData(
              color: Colors.white
            ),
          ),
          body: RefreshIndicator(
            onRefresh: onRefresh,
            key: refreshIndicatorKey,
            color: Color.fromARGB(255, 247, 131, 6),
              child:Center(
                child: Text(Localization.textNoOrders,
                  style: TextStyle(fontSize: 25.0, color: Color.fromARGB(160, 0, 0, 0)),)
              ),
            )
        
      );
    }
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(Localization.titleOrderHistory,
            style: TextStyle(
              color: Colors.white
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.white
          ),
          backgroundColor: Color.fromARGB(255, 247, 131, 6),
        ),
        body: RefreshIndicator(
          onRefresh: onRefresh,
          key: refreshIndicatorKey,
          color: Color.fromARGB(255, 247, 131, 6),
          child: ListView.builder(
          itemCount: orders.length,
          controller: scrollController,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  DefaultPageRoute(builder: (context) => OrderPage(order: orders[index])),
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
                                  Text('${Localization.textOrder} №${orders[index].id.substring(0, 8)}',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.black
                                    ),
                                  ),
                                  buildOrderStatus(orders[index]),             
                                ]
                              ),
                              Padding(padding: EdgeInsets.only(top: 2.0)),
                              Text('${Localization.textOrderedAt} ${DateFormat('HH:mm dd.MM.y').format(orders[index].createdAt)}',
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
                                    child: Text('${orders[index].restaurant.name} (${orders[index].restaurant.address})',
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
                                    orders[index].orderMenuItems.map((item) => '${item.menuItem.name} x ${item.count}').join('\n'),
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
                                  Text('${orders[index].price} ${Localization.textRUB}',
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
                                  Text(DateFormat('HH:mm dd.MM.y').format(orders[index].date),
                                    style: TextStyle(
                                      color: Color.fromARGB(160, 0, 0, 0)
                                    ),
                                  ),
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(top: 5.0)),
                            ]
                          ),
                        ),    
                    )
                  ),
                )
              );
            }
          ),
        ), 
          
    );
  }
}
