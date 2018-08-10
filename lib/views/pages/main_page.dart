import 'package:flutter/material.dart';

import 'specials_page.dart';
import 'profile_page.dart';
import 'restaurants_page.dart';

import '../routes/default_page_route.dart';

class MainPage extends StatefulWidget {
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

    controller = TabController(length: 3, vsync: this, initialIndex: 1);
    controller.addListener(
      () {
        setState(
          () {
            for (int i = 0; i < tabColors.length; i++){
              tabColors[i] = Colors.grey;
            }
            tabColors[controller.index] = Color.fromARGB(255, 247, 131, 6);
          }
        );
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
        children: [SpecialsPage(), RestaurantsPage(parentContext: context,), ProfilePage()],
        controller: controller,
      ),
      bottomNavigationBar: Material(
        child: Container(
          height: 50.0,
          child: 
            TabBar(            
              tabs: [
                Container(
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 5.0)),
                      Icon(IconData(0xe801, fontFamily: 'icons'),
                        color: tabColors[0],
                      ),
                      Text('Specials',
                        style: TextStyle(
                          color: tabColors[0],
                          fontSize: 12.0
                        ),
                      )
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
                      Text("Restaurants",
                        style: TextStyle(
                          color: tabColors[1],
                          fontSize: 12.0
                        ),
                      )
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
                      Text("Profile",
                        style: TextStyle(
                          color: tabColors[2],
                          fontSize: 12.0
                        ),
                      )
                    ],
                  ),
                ),
              ], 
            controller: controller,
          ),
        ),
      ),
    );
  }
}
