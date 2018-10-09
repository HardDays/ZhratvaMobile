import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';

import 'main_page.dart';
import 'restaurant_page.dart';
import 'restaurants_filters_page.dart';

import '../widgets/cart_widget.dart';

import '../routes/default_page_route.dart';
import '../routes/left_page_route.dart';
import '../routes/no_animation_route.dart';

import '../../helpers/util/geolocation_cache.dart';
import '../../helpers/view/localization.dart';
import '../../helpers/view/formatter.dart';


import '../../models/storage/cache.dart';
import '../../models/api/restaurant.dart';

class RestaurantsMapPage extends StatefulWidget {

  @override
  RestaurantsMapPageState createState() => RestaurantsMapPageState();
}


class RestaurantsMapPageState  extends State<RestaurantsMapPage> {
  MapController mapController;

  LatLng lastLocation;

  @override
  void initState() {
    super.initState();
    mapController = MapController();

    mapController.onReady.then((val){
      Geolocator().getCurrentPosition().timeout(Duration(seconds: 5)).then(
        (p){
          if (p != null){
            setState(() {
              lastLocation = LatLng(p.latitude, p.longitude);
              mapController.move(lastLocation, mapController.zoom);
            });
          }
        }
      );
    });
  }
  
  void onMarker(int index){
    setState(
      () {
        mapController.move(LatLng(Cache.restaurants[index].lat + 0.01, Cache.restaurants[index].lng), 13.0);   
      }
    );
    showDialog(
      context: context,
      child: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.2,
          bottom: MediaQuery.of(context).size.height * 0.35,
          right: MediaQuery.of(context).size.width * 0.07,
          left: MediaQuery.of(context).size.width * 0.07
        ),
        child: Card(
          child: Container(
            margin: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
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
                        width: MediaQuery.of(context).size.width * 0.86 - 20.0,
                        height: MediaQuery.of(context).size.height * 0.25,
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
                      width: MediaQuery.of(context).size.width * 0.25,
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(Localization.word('Map'),
          style: TextStyle(
            color: Colors.white
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        backgroundColor: Color.fromARGB(255, 247, 131, 6),
        leading: IconButton(
            icon: Icon(Icons.list, size: 30.0),
            onPressed: () {          
              Navigator.pushReplacement(
                context,
                NoAnimationPageRoute(builder: (context) => MainPage(showMap: false)),
              );
            },
          ),/*IconButton(
          icon: Icon(Icons.filter_list),
          onPressed: () {          
            Navigator.push(
              context,
              LeftPageRoute(builder: (context) => RestaurantsFiltersPage()),
            );
          },
        ),*/
        actions: [
          CartWidget()
        ]       
      ),
      body: Container(
        child: Stack(
          children: [
            FlutterMap(
              mapController: mapController,
              options: MapOptions(
                center: LatLng(55.8, 49.15),
                zoom: 12.0,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate: "https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
                  additionalOptions: {
                    'accessToken': 'pk.eyJ1Ijoidm92YW4xMjMiLCJhIjoiY2o3aXNicTFhMW9jbDJxbWw3bHNqMW92MCJ9.N1hCLnBrJjdX0JmYuA8bOw',
                    'id': 'mapbox.streets',
                  },
                ),
                MarkerLayerOptions(
                  markers: List.generate(Cache.restaurants.length, 
                    (index){
                      var point = LatLng(Cache.restaurants[index].lat, Cache.restaurants[index].lng);
                      return Marker(
                        width: 80.0,
                        height: 80.0,
                        point: point,
                        builder: (ctx) =>
                        Container(
                          child: IconButton(
                            icon: Icon(Icons.location_on,
                              size: 40.0,
                              color: Color.fromARGB(255, 247, 131, 6),
                            ),
                            onPressed: () {          
                              onMarker(index);
                            },
                          )
                        ),
                      );
                    }
                  )..add(
                    lastLocation != null ? Marker(
                    width: 15.0, 
                    height: 15.0,
                    point: lastLocation,
                    builder: (ctx) => 
                      Container(
                        width: 25.0,
                        height: 25.0,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent.withAlpha(200),
                          shape: BoxShape.circle
                        ),
                      )
                    ): Marker(point: LatLng(0.0, 0.0))
                  )  
                ),
              ],
            ),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 40.0,
                      height: 40.0,
                      decoration:  BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(170, 255, 255, 255),
                      ),
                      child: IconButton(
                        iconSize: 20.0,
                        icon: Icon(Icons.zoom_in),
                        color: Color.fromARGB(160, 0, 0, 0),
                        onPressed: () {
                          setState(() {
                            mapController.move(mapController.center, mapController.zoom + 1);             
                          });
                        },
                      )
                    ),
                    Padding(padding: EdgeInsets.only(top: 5.0)),
                    Container(
                      width: 40.0,
                      height: 40.0,
                      decoration:  BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(170, 255, 255, 255),
                      ),
                      child: IconButton(
                        iconSize: 20.0,
                        icon: Icon(Icons.zoom_out),
                        color: Color.fromARGB(160, 0, 0, 0),
                        onPressed: () {
                          setState(() {
                            mapController.move(mapController.center, mapController.zoom - 1);             
                          });
                        },
                      )
                    ),
                    Padding(padding: EdgeInsets.only(top: 5.0)),
                    Container(
                      width: 40.0,
                      height: 40.0,
                      decoration:  BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(170, 255, 255, 255),
                      ),
                      child: IconButton(
                        iconSize: 20.0,
                        icon: Icon(Icons.center_focus_strong),
                        color: Color.fromARGB(160, 0, 0, 0),
                        onPressed: () {
                             Geolocator().getCurrentPosition().timeout(Duration(seconds: 5)).then(
                              (p){
                                if (p != null){
                                  setState(() {
                                    lastLocation = LatLng(p.latitude, p.longitude);
                                    mapController.move(lastLocation, mapController.zoom);
                                  }
                                );
                              }
                            }
                          );  
                        },
                      )
                    )
                  ]
                )
              )
          ]
        )
      )
    );
  }
} 