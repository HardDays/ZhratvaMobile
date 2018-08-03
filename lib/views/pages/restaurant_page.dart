import 'package:flutter/material.dart';
import 'menu_page.dart';
import 'cart_page.dart';

import '../routes/default_page_route.dart';
import '../../models/storage/cart.dart';
import '../../models/api/restaurant.dart';

class RestaurantPage extends StatelessWidget {

  Restaurant _restaurant;

  RestaurantPage(Restaurant restaurant){
    _restaurant = restaurant;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_restaurant.name,
          style: TextStyle(
            color: Colors.white
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        backgroundColor: Color.fromARGB(255, 247, 131, 6),
        actions: [
            (Cart.items.length > 0) ? Stack(
              children:[
                IconButton(
                  icon: Icon(Icons.shopping_cart,),
                  onPressed: () {          
                    Navigator.push(
                      context,
                      DefaultPageRoute(builder: (context) => CartPage()),
                    );
                  },
                ),
                Container(
                  width: 48.0,
                  height: 24.0,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 24.0),
                  child: Text('${Cart.items.map((item) => item.count).reduce((a, b) => a + b)}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red
                  )
                )
              ]
            ) :  
            IconButton(
              icon: Icon(Icons.shopping_cart,),
              onPressed: () {          
                Navigator.push(
                  context,
                  DefaultPageRoute(builder: (context) => CartPage()),
                );
              },
            ),
          ]       
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index){
              return Container(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[ 
                    Container(  
                      margin: const EdgeInsets.only(top: 0.0, left: 0.0, right: 0.0),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(0.0)),   
                        image: DecorationImage(
                          image: ExactAssetImage('assets/images/placeholder.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.95, 
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
                      child: Card(
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                            top: 10.0, 
                            left: 10.0, 
                            right: 10.0, 
                            bottom: 10.0
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_restaurant.name,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black
                                ),  
                              ),
                              Padding(padding: EdgeInsets.only(top: 2.0)),
                              Container(
                                height: 15.0,
                                child: Row(
                                  children: [
                                    Text('${_restaurant.rating}',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 247, 131, 6)
                                      ),
                                    ),
                                    Row(
                                      children: List.generate(_restaurant.rating.floor(), 
                                        (index) {
                                          return Icon(Icons.star, color: Color.fromARGB(255, 247, 131, 6), size: 15.0,);
                                        }
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: 7.0)),
                              Text(_restaurant.address,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey
                                ),  
                              ),  
                              Padding(padding: EdgeInsets.only(top: 7.0)),
                              Text('Open till 18:00',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey
                                ),  
                              ),  
                              Padding(padding: EdgeInsets.only(top: 10.0)),
                              Container(
                                child: Text(_restaurant.description,
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey
                                  ),  
                                ),    
                              ),     
                              Padding(padding: EdgeInsets.only(top: 10.0)),
                              InkWell(
                                onTap: (){
                                },
                                child: Text('Show more',),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ]
                )
              );
            },
            childCount: 1
            ),
          ),
          SliverPadding(padding: EdgeInsets.only(top: 10.0)),
          SliverFixedExtentList(
            itemExtent: 10.0,
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                print(_restaurant.menuCategories[index].cover);
                return Container(
                  margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04),
                  alignment: Alignment.topLeft,
                  child: Text('Menu',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                );
              },
              childCount: 1
            ),
          ),
          SliverPadding(padding: EdgeInsets.only(top: 20.0)),
          SliverFixedExtentList(
            itemExtent: MediaQuery.of(context).size.height * 0.15,
            delegate: SliverChildBuilderDelegate((context, index) {
              return Container(
                margin: EdgeInsets.only(
                  left: 10.0, 
                  right: 10.0, 
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      DefaultPageRoute(builder: (context) => MenuPage(_restaurant.menuCategories[index].menuItems)),
                    );
                  },
                  child: Card(                 
                    child: Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10.0),
                            width: MediaQuery.of(context).size.height * 0.10,
                            height: MediaQuery.of(context).size.height * 0.10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: ExactAssetImage(_restaurant.menuCategories[index].cover),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 15.0),
                            height: 50.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_restaurant.menuCategories[index].name,
                                  maxLines: 1,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black
                                  ),  
                                ), 
                                Padding(padding: EdgeInsets.only(left: 2.0)),
                                Text('${_restaurant.menuCategories[index].menuItems.length} items',
                                  maxLines: 1,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey
                                  ),  
                                ), 
                              ] 
                            )
                          ), 
                        ]
                      ),
                    ),
                  ),
                ),
              );
            },
            childCount: _restaurant.menuCategories.length
            ),
          ),
          SliverPadding(padding: EdgeInsets.only(top: 40.0)),
        ],
      )
    );
  }
}