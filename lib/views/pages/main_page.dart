import 'package:flutter/material.dart';

import 'restaurants_page.dart';
import 'restaurants_map_page.dart';
import 'profile_page.dart';
import 'current_orders_page.dart';

import '../routes/default_page_route.dart';

import '../../helpers/view/localization.dart';

class MainPage extends StatefulWidget {
  int index = 1;
  bool showMap;

  MainPage({this.index, this.showMap = false}){
  }

  @override
  MainPageState createState() => new MainPageState();
}

class MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  // Create a tab controller
  TabController controller;

  List <Color> tabColors;

  @override
  void initState() {
    super.initState();

    tabColors = [
      Colors.grey,
      Colors.grey,
      Colors.grey
    ];

    controller = TabController(length: 3, vsync: this, initialIndex: widget.index != null ? widget.index : 1);
    controller.addListener(
      () {
        setTabColor();
      }
    );
    setTabColor();
  }

  void setTabColor(){
    setState(
      () {
        for (int i = 0; i < tabColors.length; i++){
          tabColors[i] = Colors.grey;
        }
        tabColors[controller.index] = Color.fromARGB(255, 247, 131, 6);
      }
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        children: [CurrentOrdersPage(), widget.showMap ? RestaurantsMapPage() : RestaurantsPage(), ProfilePage()],
        controller: controller,
      ),
      bottomNavigationBar: Material(
        child: Container(
          height: 53.0,
          child: Column(
            children: [
              Divider(height: 5.0),
              TabBar(            
              tabs: [
                Container(
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 5.0)),
                      Icon(IconData(0xe801, fontFamily: 'icons'),
                        color: tabColors[0],
                      ),
                      Text(Localization.word('Orders'),
                        style: TextStyle(
                          color: tabColors[0],
                          fontSize: 12.0
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 3.0))
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 5.0)),
                      Icon(Icons.restaurant,
                        color: tabColors[1],
                      ),
                      Text(Localization.word('Restaurants'),
                        style: TextStyle(
                          color: tabColors[1],
                          fontSize: 12.0
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 3.0))
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 5.0)),
                      Icon(IconData(0xe800, fontFamily: 'icons'),
                        color: tabColors[2],
                      ),
                      Text(Localization.word('Profile'),
                        style: TextStyle(
                          color: tabColors[2],
                          fontSize: 12.0
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 3.0))

                    ],
                  ),
                ),
              ], 
              controller: controller,
              ), 
            ]
          ),
        ),
      ),
    );
  }
}
