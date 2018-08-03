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

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this, initialIndex: 1);
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
        children: <Widget>[SpecialsPage(), RestaurantsPage(parentContext: context), ProfilePage()],
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
                      Icon(Icons.restaurant,
                        color: Colors.grey,
                      ),
                      Text("Specials",
                        style: TextStyle(
                          color: Colors.grey,
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
                        color: Colors.grey,
                      ),
                      Text("Restaurants",
                        style: TextStyle(
                          color: Colors.grey,
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
                      Icon(Icons.people,
                        color: Colors.grey,
                      ),
                      Text("Profile",
                        style: TextStyle(
                          color: Colors.grey,
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
