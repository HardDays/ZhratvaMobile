import 'dart:async';
import 'package:flutter/material.dart';

import 'start_page.dart';
import 'order_history_page.dart';

import '../routes/default_page_route.dart';

import '../../helpers/api/main_api.dart';
import '../../helpers/view/localization.dart';

import '../../models/storage/cache.dart';
import '../../models/storage/database.dart';

class ProfilePage extends StatefulWidget {
  //BuildContext parentContext;

  //ProfilePage({this.parentContext});

  @override
  ProfilePageState createState() => new ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> with TickerProviderStateMixin {
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  TabController tabController;
  
  ProfilePageState(){
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void initState(){
    super.initState();
    if (Cache.statistics == null){
      loadStatistics();
    }
  }

  Future<Null> onRefresh(){
    Cache.statistics = null;
    return loadStatistics();
  }


   Future<Null> loadStatistics(){
    MainAPI.getMyStatistics([Duration(days: 7), Duration(days: 30), Duration(days: 180)]).then(
      (res){
        setState(
          () {
            Cache.statistics = res;    
          }
        );        
      }     
    );
  }

  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Localization.word('Profile'),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(Localization.word('Profile')),
          backgroundColor: Color.fromARGB(255, 247, 131, 6),     
            actions:[ 
              PopupMenuButton<int>(         
                onSelected: (value){
                  if (value == 0){
                    Navigator.push(
                      context, 
                      DefaultPageRoute(builder: (ctx) => OrderHistoryPage())
                    );
                  } else if (value == 1){
                    Cache.currentUser = null;
                    Database.deleteCurrentUser(); 
                    Navigator.pushReplacement(
                      context, 
                      DefaultPageRoute(builder: (context) => StartPage())
                    );
                  }
                },
                itemBuilder:  (BuildContext context) => [
                  PopupMenuItem<int>(child: Text(Localization.word('History')), value: 0),
                  PopupMenuItem<int>(child: Text(Localization.word('Logout')), value: 1)
                ],
            )
          ]
        ),
        body: SingleChildScrollView(
          child: 
           RefreshIndicator(
          onRefresh: onRefresh,
          key: refreshIndicatorKey,
          color: Color.fromARGB(255, 247, 131, 6),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(5.0),
                  height: MediaQuery.of(context).size.width * 0.4,
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(  
                            width: MediaQuery.of(context).size.width * 0.4 - 50.0,
                            height: MediaQuery.of(context).size.width * 0.4 - 50.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: ExactAssetImage('assets/images/placeholder.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),   
                          Padding(padding: EdgeInsets.only(left: 30.0),),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${Cache.currentUser.firstName} ${Cache.currentUser.lastName}',
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                    fontSize: 25.0
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(top: 5.0)),
                                Text('${Cache.currentUser.phone}',
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                    fontSize: 16.0
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(top: 5.0)),
                                Text('${Cache.currentUser.email}',
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                    fontSize: 16.0
                                  ),
                                )
                              ],
                            )
                          )
                        ]
                      )
                    )
                  )
                ),
                Padding(padding: EdgeInsets.only(top: 10.0)),
                Container(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(Localization.word('Statistics'),
                    style: TextStyle(
                      fontSize: 18.0
                    )
                  ),
                ),            
                Padding(padding: EdgeInsets.only(top: 10.0)),
                Cache.statistics != null && Cache.statistics?.length == 3 ? Theme(
                  data: ThemeData(
                    accentColor: Color.fromARGB(255, 247, 131, 6),
                    primaryColor: Colors.black,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(5.0),
                    child: Container(
                      child: DefaultTabController(
                        length: 3,
                        child: Column(
                          children: [   
                            Padding(    
                              padding: EdgeInsets.only(left: 5.0, right: 5.0),
                              child:Divider(height: 0.0)
                            ),    
                            Container(
                              color: Colors.white,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(left: 5.0, right: 5.0),
                              child: TabBar(
                                labelColor: Colors.black,
                                tabs: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 40.0, 
                                    child: Text(Localization.word('Week')),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 40.0, 
                                    child: Text(Localization.word('Month')),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 40.0, 
                                    child: Text(Localization.word('Total')),
                                  ),
                                ],
                              ),
                            ),  
                            Padding(    
                              padding: EdgeInsets.only(left: 5.0, right: 5.0),
                              child:Divider(height: 0.0)
                            ),
                            Container(
                              height: 175.0,
                              child: TabBarView(
                                physics: NeverScrollableScrollPhysics(),
                                key: PageStorageKey<Type>(TabBarView),
                                children: List.generate(Cache.statistics.length, (index){
                                   return Card(
                                    child: Container(
                                      padding: EdgeInsets.all(15.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context).size.width * 0.4,
                                                child: Column(
                                                  children: [   
                                                    Text('${Cache.statistics[index].visitedPlaces}',
                                                      style: TextStyle(
                                                        fontSize: 25.0,
                                                        color: Color.fromARGB(255, 247, 131, 6),
                                                      ),                                                      
                                                    ),
                                                    Text(Localization.word('Visited places'),
                                                      style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: Color.fromARGB(160, 0, 0, 0)
                                                      ),                                                      
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context).size.width * 0.4,
                                                child: Column(
                                                  children: [   
                                                    Text('${Cache.statistics[index].itemsOrdered}',
                                                      style: TextStyle(
                                                        fontSize: 25.0,
                                                        color: Color.fromARGB(255, 247, 131, 6),
                                                      ),                                                      
                                                    ),
                                                    Text(Localization.word('Items ordered'),
                                                      style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: Color.fromARGB(160, 0, 0, 0)
                                                      ),                                                      
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ]
                                          ),
                                           Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context).size.width * 0.4,
                                                child: Column(
                                                  children: [   
                                                    Text('${Cache.statistics[index].moneySpent.toStringAsFixed(1)}',
                                                      style: TextStyle(
                                                        fontSize: 25.0,
                                                        color: Color.fromARGB(255, 247, 131, 6),
                                                      ),                                                      
                                                    ),
                                                    Text(Localization.word('Money spent'),
                                                      style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: Color.fromARGB(160, 0, 0, 0)
                                                      ),                                                      
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context).size.width * 0.4,
                                                child: Column(
                                                  children: [   
                                                    Text('${Cache.statistics[index].moneySaved.toStringAsFixed(1)}',
                                                      style: TextStyle(
                                                        fontSize: 25.0,
                                                        color: Color.fromARGB(255, 247, 131, 6),
                                                      ),                                                      
                                                    ),
                                                    Text(Localization.word('Money saved'),
                                                      style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: Color.fromARGB(160, 0, 0, 0)
                                                      ),                                                      
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ]
                                           )
                                        ],
                                      ),
                                    )                                    
                                    );
                                  }
                                )
                              )
                            )
                          ],
                        )
                      )
                    ),
                  ),
                ): 
                Center(
                  child: Container(
                    padding: EdgeInsets.only(top: 100.0, bottom: 10.0),  
                    child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Color.fromARGB(255, 247, 131, 6))),      
                  )      
                ),   
              ]
            ),
          )
        ),
      )
      ),     
    );
  }
}