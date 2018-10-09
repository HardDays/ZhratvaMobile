import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong/latlong.dart';

import 'main_page.dart';
import 'restaurant_page.dart';

import '../widgets/cart_widget.dart';

import '../routes/default_page_route.dart';

import '../../helpers/util/geolocation_cache.dart';
import '../../helpers/view/localization.dart';
import '../../helpers/view/formatter.dart';


import '../../models/storage/cache.dart';
import '../../models/api/restaurant.dart';

class RestaurantsFiltersPage extends StatefulWidget {

  @override
  RestaurantsFiltersPageState createState() => RestaurantsFiltersPageState();
}


class RestaurantsFiltersPageState  extends State<RestaurantsFiltersPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Filters',
          style: TextStyle(
            color: Colors.white
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        backgroundColor: Color.fromARGB(255, 247, 131, 6),
        actions: [
          
        ]       
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            // название
            // город
            // переключатель по дистанции -> включается ползунок по дистанции (макс. радиус)
            // тип (все, кафе, рестораны и тд) (можно выбор одного, можно нескольких, тут хз),
            // переключатель показывать только открытые -> опционально, включается ползунок время закрытия от текущего до 23:59 
          ],
        ),
      )
    );
  }
} 