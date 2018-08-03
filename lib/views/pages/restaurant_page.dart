import 'package:flutter/material.dart';
import 'menu_page.dart';

import '../widgets/cart_widget.dart';

import '../routes/default_page_route.dart';
import '../../models/storage/cart.dart';
import '../../models/api/restaurant.dart';

class RestaurantPage extends StatelessWidget {

  Restaurant restaurant;

  RestaurantPage({this.restaurant}){
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(restaurant.name,
          style: TextStyle(
            color: Colors.white
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        backgroundColor: Color.fromARGB(255, 247, 131, 6),
        actions: [
          CartWidget()
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
                              Text(restaurant.name,
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
                                    Text('${restaurant.rating}',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 247, 131, 6)
                                      ),
                                    ),
                                    Row(
                                      children: List.generate(restaurant.rating.floor(), 
                                        (index) {
                                          return Icon(Icons.star, color: Color.fromARGB(255, 247, 131, 6), size: 15.0,);
                                        }
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: 7.0)),
                              Text(restaurant.address,
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
                                child: Text(restaurant.description,
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
                print(restaurant.menuCategories[index].cover);
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
                      DefaultPageRoute(builder: (context) => MenuPage(restaurant.menuCategories[index].menuItems)),
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
                                image: ExactAssetImage(restaurant.menuCategories[index].cover),
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
                                Text(restaurant.menuCategories[index].name,
                                  maxLines: 1,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black
                                  ),  
                                ), 
                                Padding(padding: EdgeInsets.only(left: 2.0)),
                                Text('${restaurant.menuCategories[index].menuItems.length} items',
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
            childCount: restaurant.menuCategories.length
            ),
          ),
          SliverPadding(padding: EdgeInsets.only(top: 40.0)),
        ],
      )
    );
  }
}