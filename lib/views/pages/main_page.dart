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
        children: <Widget>[SpecialsPage(), RestaurantsPage(), ProfilePage()],
        controller: controller,
      ),
      bottomNavigationBar: Material(
        child: TabBar(
          tabs: <Tab>[
            Tab(
              icon: Icon(Icons.satellite),
              text: "Specials",
            ),
            Tab(
              icon: Icon(Icons.restaurant),
              text: "Restaurants",
            ),
            Tab(
              icon: Icon(Icons.people),
              text: 'Profile'
            ),
          ],
          // setup the controller
          controller: controller,
        ),
      ),
    );
  }
}
