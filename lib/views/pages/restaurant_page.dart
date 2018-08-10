import 'package:flutter/material.dart';
import 'menu_page.dart';

import '../widgets/cart_widget.dart';

import '../routes/default_page_route.dart';

import '../../helpers/api/main_api.dart';

import '../../models/storage/cart.dart';
import '../../models/api/restaurant.dart';

class RestaurantPage extends StatefulWidget {

  Restaurant restaurant;

  RestaurantPage({this.restaurant});

  @override
  RestaurantPageState createState() => RestaurantPageState();
}


class RestaurantPageState  extends State<RestaurantPage> {

  @override
  void initState() {
    super.initState();

    if (widget.restaurant.menuCategories == null){
      MainAPI.getRestaurantMenu(widget.restaurant.id).then(
        (res){
          setState(() {
            widget.restaurant.menuCategories = res;
          });        
        }     
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.restaurant.menuCategories == null){
       return Container(
         color: Colors.white,
         child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(backgroundColor: Color.fromARGB(255, 247, 131, 6)),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.restaurant.name,
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
                          image: NetworkImage(widget.restaurant.cover),
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
                              Text(widget.restaurant.name,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black
                                ),  
                              ),
                              Padding(padding: EdgeInsets.only(top: 2.0)),
                              widget.restaurant.rating != null ? Container(
                                height: 15.0,
                                child: Row(
                                  children: [
                                    Text('${widget.restaurant.rating}',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 247, 131, 6)
                                      ),
                                    ),
                                    Row(
                                      children: List.generate(widget.restaurant.rating.floor(), 
                                        (index) {
                                          return Icon(Icons.star, color: Color.fromARGB(255, 247, 131, 6), size: 15.0,);
                                        }
                                      ),
                                    ),
                                  ],
                                ),
                              ) : Container(),
                              Padding(padding: EdgeInsets.only(top: 7.0)),
                              Text(widget.restaurant.address,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey
                                ),  
                              ),  
                              Padding(padding: EdgeInsets.only(top: 7.0)),
                              Text(widget.restaurant.openNow ? 'Open till ${widget.restaurant.workingHourNow.close}' : 'Closed now',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey
                                ),  
                              ),  
                              Padding(padding: EdgeInsets.only(top: 10.0)),
                              Container(
                                child: Text(widget.restaurant.description,
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
          widget.restaurant.menuCategories != null ? SliverFixedExtentList(
            itemExtent: 10.0,
            delegate: SliverChildBuilderDelegate(
              (context, index) {
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
          ) : SliverPadding(padding: EdgeInsets.only(top: 1.0)),
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
                      DefaultPageRoute(builder: (context) => MenuPage(widget.restaurant.menuCategories[index].menuItems)),
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
                                image: NetworkImage(widget.restaurant.menuCategories[index].cover()),
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
                                Text(widget.restaurant.menuCategories[index].name,
                                  maxLines: 1,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black
                                  ),  
                                ), 
                                Padding(padding: EdgeInsets.only(left: 2.0)),
                                Text('${widget.restaurant.menuCategories[index].menuItems.length} items',
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
            childCount: widget.restaurant.menuCategories != null ? widget.restaurant.menuCategories.length : 0
            ),
          ),
          SliverPadding(padding: EdgeInsets.only(top: 40.0)),
        ],
      )
    );
  }
} 