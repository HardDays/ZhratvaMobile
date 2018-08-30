import 'dart:async';
import 'package:flutter/material.dart';

import 'restaurant_page.dart';
import 'restaurants_filters_page.dart';
import 'main_page.dart';

import '../routes/default_page_route.dart';
import '../routes/left_page_route.dart';
import '../routes/no_animation_route.dart';

import '../widgets/cart_widget.dart';

import '../../helpers/util/geolocation_cache.dart';
import '../../helpers/api/main_api.dart';
import '../../helpers/view/formatter.dart';
import '../../helpers/view/localization.dart';

import '../../models/api/restaurant.dart';
import '../../models/api/working_hour.dart';
import '../../models/storage/cache.dart';

class RestaurantsPage extends StatefulWidget {

  RestaurantsPage(){
  }

  @override
  RestaurantsPageState createState() => RestaurantsPageState();
}

class RestaurantsPageState extends State<RestaurantsPage> with AutomaticKeepAliveClientMixin  {
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  Future<Null> loadRestaurants(){
    var loc = GeolocationCache.lastLocation();
    return MainAPI.getRestaurants(DateTime.now(), loc?.latitude, loc?.longitude).then(
      (res){
        setState(
          () {
            Cache.restaurants = res;          
            /*
            double maxDist = 20000.0;
            Cache.restaurants.sort((first, second) => (first.distance ?? maxDist).compareTo(second.distance ?? maxDist));
            Cache.restaurants.sort(
              (first, second) {
                if ((first.distance ?? maxDist) <= maxDist && (second.distance ?? maxDist) <= maxDist){
                  if (first.openNow){
                    return -1;
                  }else if (second.openNow){
                    return 1;
                  }else {
                    return 0;
                  }
                }else{
                  return 0;
                }
              }
            );*/
          }
        );        
      }     
    );
  }

  @override
  void initState() {
    super.initState();
    if (Cache.restaurants == null){
      loadRestaurants();
    }
  }

  Future<Null> onRefresh(){
    return loadRestaurants();
  }

  @override 
  Widget build(BuildContext ctx) {
    if (Cache.restaurants == null){
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(Localization.word('Restaurants')),
            backgroundColor: Color.fromARGB(255, 247, 131, 6),
            actions: [
              CartWidget()
            ]       
          ),
          body: Center(
            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Color.fromARGB(255, 247, 131, 6))),            
          ),
        )
      );
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(Localization.word('Restaurants')),
          backgroundColor: Color.fromARGB(255, 247, 131, 6),
          leading: IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {          
              Navigator.push(
                context,
                LeftPageRoute(builder: (context) => RestaurantsFiltersPage()),
              );
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.location_on,),
              onPressed: () {          
                Navigator.pushReplacement(
                  context,
                  NoAnimationPageRoute(builder: (context) => MainPage(showMap: true)),
                );
              },
            ),
            CartWidget(parentContext: this.context)
          ]       
        ),
        body: RefreshIndicator(
          onRefresh: onRefresh,
          key: refreshIndicatorKey,
          color: Color.fromARGB(255, 247, 131, 6),
          child: ListView.builder(
          itemCount: Cache.restaurants.length,
          itemBuilder: (ctx, index) {
            return Container(
              child: Card(
                margin: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                child: Container(
                  margin: const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                this.context,
                                DefaultPageRoute(builder: (context) => RestaurantPage(restaurant: Cache.restaurants[index])),
                              );
                            },
                            child: Container(  
                              width: MediaQuery.of(context).size.width - 40.0,
                              height: MediaQuery.of(context).size.width * 0.5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),   
                                image: DecorationImage(
                                  image: NetworkImage(Cache.restaurants[index].cover),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5.0, left: 3.0),
                        width: MediaQuery.of(context).size.width * 1.0,
                        child: Text(Cache.restaurants[index].name,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black
                          ),
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10.0),
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.location_on,
                                      size: 18.0,
                                      color: Color.fromARGB(160, 0, 0, 0)
                                    ),
                                    Padding(padding: EdgeInsets.only(right: 5.0)),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.5 - 40.0,
                                      child: Text(Cache.restaurants[index].address,
                                        style: TextStyle(
                                          color: Color.fromARGB(160, 0, 0, 0)
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    )
                                  ],
                                ),
                                Padding(padding: EdgeInsets.only(bottom: 3.0),),
                                Row(
                                  children: [
                                    Icon(Icons.timer,
                                      size: 18.0,
                                      color: Cache.restaurants[index].openNow ? Color.fromARGB(128, 0, 163, 24) : Color.fromARGB(128, 181, 42, 42)
                                    ),
                                    Padding(padding: EdgeInsets.only(right: 5.0)),
                                    Text(Cache.restaurants[index].openNow ? Localization.word('Open now') : Localization.word('Closed now'),
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Cache.restaurants[index].openNow ? Color.fromARGB(128, 0, 163, 24) : Color.fromARGB(128, 181, 42, 42)
                                      ),
                                      overflow: TextOverflow.clip,
                                    ),
                                  ],
                                ),       
                                Padding(padding: EdgeInsets.only(bottom: 10.0),)
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10.0),
                            width: MediaQuery.of(context).size.width * 0.35,
                            alignment: Alignment.center,
                            height: 36.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)), 
                              border: Border.all(
                                color: Colors.grey
                              )
                            ),
                            child: Container(
                              margin: const EdgeInsets.only(top: 0.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [                             
                                  Text(Cache.restaurants[index].distance != null ? Formatter.distance(Cache.restaurants[index].distance.floor()) : Localization.word('Far away'),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16.0
                                    ),
                                  ),
                                ]
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              )
            );
          },
        ),
        )
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}