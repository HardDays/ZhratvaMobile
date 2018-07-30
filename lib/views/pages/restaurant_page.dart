import 'package:flutter/material.dart';
import 'main_page.dart';
import '../routes/default_page_route.dart';
import '../../models/menu_category.dart';
import '../../models/restaurant.dart';

class RestaurantPage extends StatelessWidget {

  Restaurant _restaurant = Restaurant(
    name: 'Good coffee',
    address: 'Kazan, Rrussia, Universitetskaya 228',
    hours: '12:00 - 15:00',
    openNow: true,
    rating: 4.5,
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi ac quam vel risus aliquam semper. Nam auctor imperdiet lectus, sit amet bibendum est ullamcorper tincidunt. Aenean tincidunt ipsum eget sem vulputate, et egestas mauris porttitor. Vivamus nec risus dapibus, tristique ante hendrerit, porta odio. Etiam accumsan, odio vitae molestie aliquet, arcu magna faucibus enim, in pharetra libero leo molestie ante. Cras sed congue lacus. Duis rutrum risus lectus, sed dapibus ante luctus a. Etiam mollis nunc at ante dapibus vehicula.',
    distance: 200
  );

  List <MenuCategory> _list = [
    MenuCategory(
      name: 'Кофе', 
      description: 'Вкусно',
      count: 228
    ),
    MenuCategory(
      name: 'Пельмени', 
      description: 'Очень большой',
      count: 1499
    ),
    MenuCategory(
      name: 'Борщи', 
      description: 'Вкусно',
      count: 123
    ),
    MenuCategory(
      name: 'Вискас', 
      description: 'Для байта',
      count: 228
    ),
    MenuCategory(
      name: 'Дошики', 
      description: 'Элитная пища',
      count: 228
    )
  ];

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: false,
          expandedHeight: 250.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('sa'),
            background: Image.asset('assets/images/placeholder.jpg',
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.5,
              fit: BoxFit.cover,  
=======
    return Scaffold(
      appBar: AppBar(
          title: Text('Restaurant'),
          backgroundColor: Color.fromARGB(255, 247, 131, 6),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverFixedExtentList(
            itemExtent: 260.0,
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
                      height: 250.0,
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
                      child: Card(
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width * 0.03, 
                            left: MediaQuery.of(context).size.width * 0.03, 
                            right: MediaQuery.of(context).size.width * 0.03, 
                            bottom: MediaQuery.of(context).size.width * 0.03
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
                              Text('cafe',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey
                                ),  
                              ),
                              Padding(padding: EdgeInsets.only(top: 10.0)),
                              Container(
                                height: MediaQuery.of(context).size.height * 0.07,
                                child: Text(_restaurant.description,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey
                                  ),  
                                ),    
                              ),     
                              Padding(padding: EdgeInsets.only(top: 25.0)),
                              Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 200.0),
                                    alignment: Alignment.center,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(_restaurant.hours,
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black
                                          ),  
                                        ),  
                                        Padding(padding: EdgeInsets.only(top: 2.0)),
                                        Text('hours',
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.grey
                                          ),  
                                        ),  
                                      ]
                                    )
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Column(
                                      children:[ 
                                        Text(_restaurant.rating != null ? '${_restaurant.rating}' : 'Not rated',
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 25.0,
                                            color: Colors.black
                                          ),  
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 2.0)),
                                        Text('rating',
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.grey
                                          ),  
                                        ),  
                                      ]
                                    ),  
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 175.0),
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        Text(_restaurant.distance != null ? '${_restaurant.distance} km' : 'Inf',
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black
                                          ),  
                                        ),  
                                        Padding(padding: EdgeInsets.only(top: 2.0)),
                                        Text('distance',
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.grey
                                          ),  
                                        ),  
                                      ],
                                    ),
                                  )
                                ],
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
>>>>>>> 519bc44b4e99e6ab81b06c9ed9dc74ebc19a8c1f
            ),
          ),
          SliverPadding(padding: EdgeInsets.only(top: 10.0)),
          SliverFixedExtentList(
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
          ),
          SliverPadding(padding: EdgeInsets.only(top: 20.0)),
          SliverFixedExtentList(
            itemExtent: MediaQuery.of(context).size.height * 0.15,
            delegate: SliverChildBuilderDelegate((context, index) {
              return Container(
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.03, 
                  right: MediaQuery.of(context).size.width * 0.03, 
                ),
                child: Card(                 
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.025),
                          width: MediaQuery.of(context).size.height * 0.10,
                          height: MediaQuery.of(context).size.height * 0.10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: ExactAssetImage('assets/images/placeholder.jpg'),
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
                              Text(_list[index].name,
                                maxLines: 1,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black
                                ),  
                              ), 
                              Padding(padding: EdgeInsets.only(left: 2.0)),
                              Text('${_list[index].count} items',
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
                  )
                )
              );
            },
            childCount: _list.length
            ),
          ),
          SliverPadding(padding: EdgeInsets.only(top: 40.0)),
        ],
      )
    );
  }
}