import 'package:flutter/material.dart';

import 'restaurant_page.dart';

import '../routes/default_page_route.dart';

import '../../models/restaurant.dart';

class RestaurantsPage extends StatefulWidget {
  @override
  RestaurantsStatePage createState() => RestaurantsStatePage();
}

class RestaurantsStatePage extends State<RestaurantsPage> with AutomaticKeepAliveClientMixin<RestaurantsPage>{

  List <Restaurant> _list = [];

  @override
  void initState() {
    super.initState();
    _list = [
      Restaurant(
        name: 'Good cafe ffds sf sf s sf sfs sddfdsassdad',
        address: 'Kazan, Rrussia',
        hours: '12:00 - 15:00',
        openNow: true,
        distance: 2000
      ),
      Restaurant(
        name: 'Nice coffee',
        address: 'Kazan, Russia, Peterburgskaya street',
        hours: '12:00 - 15:00',
        openNow: true,
        distance: 500
      ),
      Restaurant(
        name: 'Hipsto Coffee',
        address: 'Kazan, Russia',
        hours: 'Closed',
        openNow: false,
        distance: 2000
      ),
    ];
  }

  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Restaurants'),
          backgroundColor: Color.fromARGB(255, 247, 131, 6),
          actions: [
            IconButton(
              icon: Icon(Icons.add_shopping_cart),
              onPressed: () {
                
              },
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: _list.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                           Navigator.push(
                            context,
                            DefaultPageRoute(builder: (context) => RestaurantPage()),
                          );
                        },
                        child: Container(  
                          width: MediaQuery.of(context).size.width - 20.0,
                          height: MediaQuery.of(context).size.width * 0.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),   
                            image: DecorationImage(
                              image: ExactAssetImage('assets/images/placeholder.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    width: MediaQuery.of(context).size.width * 1.0,
                    child: Text(_list[index].name,
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
                    children: <Widget> [
                      Container(
                        margin: const EdgeInsets.only(top: 5.0),
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(_list[index].address,
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 2.0),
                              child:Text(_list[index].openNow ? 'Open now' : 'Closed',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: _list[index].openNow ? Color.fromARGB(128, 0, 163, 24) : Color.fromARGB(128, 181, 42, 42)
                                ),
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5.0),
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: 32.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)), 
                          border: Border.all(
                            color: Colors.grey
                          )
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(top: 8.0),
                          child: Text('${_list[index].distance} km',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}