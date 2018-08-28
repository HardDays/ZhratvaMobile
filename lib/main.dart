import 'package:flutter/material.dart';

import 'helpers/util/geolocation_cache.dart';
import 'helpers/api/main_api.dart';

import 'models/storage/database.dart';
import 'models/storage/cache.dart';

import 'models/api/user.dart';

import 'views/pages/start_page.dart';
import 'views/pages/main_page.dart';
import 'views/pages/splash_page.dart';

void main() => runApp(new App());

class App extends StatefulWidget {


  @override
  AppState createState() => AppState();
}


class AppState extends State<App> {

  bool loading = true;

  @override
  void initState() {
    super.initState();
    
    GeolocationCache.init();
    Database.init().then(
      (v){
        var user = Database.getCurrentUser();
        if (user != null){
          MainAPI.token = user.token;
          MainAPI.getMe().then(
            (me){
              if (me != null){
                setState(() {Cache.currentUser = me;});
              }
              setState(() {loading = false;});
            }
          );
        } else {
          setState(() {loading = false;});
        }
      }
    );
  }
 
  @override
  Widget build(BuildContext context) {
    if (loading){
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.grey,
          primaryColor: Color.fromARGB(255, 247, 131, 6),
          accentColor: Colors.white
        ),
        home: SplashPage()
      );
    }
    if (Cache.currentUser != null) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.grey,
          primaryColor: Color.fromARGB(255, 240, 240, 240),
          accentColor: Color.fromARGB(255, 247, 131, 6),
       
        ),
        home: MainPage(),
      );
    } else {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.grey,
          primaryColor: Color.fromARGB(255, 247, 131, 6),
          accentColor: Color.fromARGB(255, 247, 131, 6),
        ),
        home: StartPage(),
      );
    }
  }
}
