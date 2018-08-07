import 'package:flutter/material.dart';

import 'helpers/util/geolocation_cache.dart';

import 'views/pages/start_page.dart';
import 'views/pages/main_page.dart';

void main() => runApp(new App());

class App extends StatelessWidget {

  App(){
    GeolocationCache.init();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: new StartPage(),
    );
  }
}
