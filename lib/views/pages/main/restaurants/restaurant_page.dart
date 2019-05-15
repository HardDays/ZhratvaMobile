import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'menu_page.dart';

import '../../../widgets/cart_widget.dart';

import '../../../routes/default_page_route.dart';

import '../../../../helpers/api/main_api.dart';
import '../../../../helpers/view/localization.dart';

import '../../../../models/storage/cart.dart';
import '../../../../models/api/restaurant.dart';

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
    setState(
      () {
      }
    );
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
                      child: CachedNetworkImage(  
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.25,
                        fadeOutDuration: Duration(milliseconds: 100),
                        fadeInDuration: Duration(milliseconds: 100),
                        imageUrl: widget.restaurant.cover,
                        fit: BoxFit.cover,
                        placeholder: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: Colors.grey.withOpacity(0.2))
                          ),
                          child: Icon(Icons.restaurant, color: Colors.grey.withOpacity(0.5), size: 25),
                        ),
                        errorWidget: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: Colors.grey.withOpacity(0.2))
                          ),
                          child: Icon(Icons.restaurant, color: Colors.grey.withOpacity(0.5), size: 25),
                        ),
                      )
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
                              Row(
                                  children: [
                                    Icon(Icons.location_on,
                                      size: 18.0,
                                      color: Color.fromARGB(160, 0, 0, 0)
                                    ),
                                    Padding(padding: EdgeInsets.only(right: 5.0)),
                                    Text(widget.restaurant.address,
                                      style: TextStyle(
                                        color: Color.fromARGB(160, 0, 0, 0)
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                              ),
                              widget.restaurant.phone != null ? 
                                Container(
                                  padding: EdgeInsets.only(top: 7.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.phone,
                                        size: 18.0,
                                        color: Color.fromARGB(160, 0, 0, 0)
                                      ),
                                      Padding(padding: EdgeInsets.only(right: 5.0)),
                                      Text(widget.restaurant.phone,
                                        style: TextStyle(
                                          color: Color.fromARGB(160, 0, 0, 0)
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                ),
                              ) : Container(),
                              widget.restaurant.link != null ? 
                                Container(
                                  padding: EdgeInsets.only(top: 7.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.web,
                                        size: 18.0,
                                        color: Color.fromARGB(160, 0, 0, 0)
                                      ),
                                      Padding(padding: EdgeInsets.only(right: 5.0)),
                                      Text(widget.restaurant.link,
                                        style: TextStyle(
                                          color: Color.fromARGB(160, 0, 0, 0)
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                ),
                              ) : Container(),
                              Padding(padding: EdgeInsets.only(top: 7.0)),
                               Row(
                                  children: [
                                    Icon(Icons.timer,
                                      size: 18.0,
                                      color: Color.fromARGB(160, 0, 0, 0)
                                    ),
                                    Padding(padding: EdgeInsets.only(right: 5.0)),
                                    Text(widget.restaurant.openNow ? '${Localization.textOpenTill} ${widget.restaurant.workingHourNow.close}' : Localization.textClosed,
                                      style: TextStyle(
                                        color: Color.fromARGB(160, 0, 0, 0)
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                              ),  
                              Padding(padding: EdgeInsets.only(top: 10.0)),
                              Container(
                                child: Text(widget.restaurant.description,
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Color.fromARGB(160, 0, 0, 0)
                                  ),  
                                ),    
                              ),     
                              Padding(padding: EdgeInsets.only(top: 10.0)),
                              InkWell(
                                onTap: (){
                                },
                                child: Text(Localization.textInformation),
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
          SliverPadding(
            padding: EdgeInsets.only(top: 10.0)),
            widget.restaurant.menuCategories != null ? SliverFixedExtentList(
            itemExtent: 20.0,
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04),
                  alignment: Alignment.topLeft,
                  child: Text(Localization.titleMenu,
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                );
              },
              childCount: 1
            ),
          ) : SliverPadding(padding: EdgeInsets.only(top: 1.0)),
          SliverPadding(padding: EdgeInsets.only(top: 10.0)),
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
                      DefaultPageRoute(builder: (context) => MenuPage(restaurant: widget.restaurant, list: widget.restaurant.menuCategories[index].menuItems)),
                    );
                  },
                  child: Card(                 
                    child: Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(padding: EdgeInsets.only(left: 10.0)),
                          ClipOval(
                            child: CachedNetworkImage(  
                              width: MediaQuery.of(context).size.height * 0.10,
                              height: MediaQuery.of(context).size.height * 0.10,
                              fadeOutDuration: Duration(milliseconds: 100),
                              fadeInDuration: Duration(milliseconds: 100),
                              imageUrl: widget.restaurant.menuCategories[index].cover(),
                              fit: BoxFit.cover,
                              placeholder: Container(
                                width: MediaQuery.of(context).size.height * 0.10,
                                height: MediaQuery.of(context).size.height * 0.10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.grey.withOpacity(0.2))
                                ),
                                child: Icon(Icons.restaurant, color: Colors.grey.withOpacity(0.5), size: 25),
                              ),
                              errorWidget: Container(
                                width: MediaQuery.of(context).size.height * 0.10,
                                height: MediaQuery.of(context).size.height * 0.10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.grey.withOpacity(0.2))
                                ),
                                child: Icon(Icons.restaurant, color: Colors.grey.withOpacity(0.5), size: 25),
                              ),
                            )
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
                                Text('${widget.restaurant.menuCategories[index].menuItems.length} ${Localization.textItems}',
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