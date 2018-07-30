import 'package:flutter/material.dart';
import 'main_page.dart';
import '../routes/default_page_route.dart';
import '../../models/menu_item.dart';

class RestaurantPage extends StatelessWidget {

  List <MenuItem> _list = [
    MenuItem(
      name: 'Пельмень1', 
      description: 'Вкусно',
      price: 228
    ),
    MenuItem(
      name: 'Большой Пельмень', 
      description: 'Очень большой',
      price: 1499
    ),
    MenuItem(
      name: 'Борщ', 
      description: 'Вкусно',
      price: 123
    ),
    MenuItem(
      name: 'Вискас', 
      description: 'Для байта',
      price: 228
    ),
    MenuItem(
      name: 'Дошик', 
      description: 'Элитная пища',
      price: 228
    )
  ];


  @override
  Widget build(BuildContext context) {
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
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(16.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              Text('sa'),
              Text('sa'),
              Text('sa'),
              Text('sa'),
              Text('sa'),
              Text('sa'),
              Text('sa'),
              Text('sa'),
              Text('sa'),
              Text('sa'),
              Text('sa'),
              Text('sa'),
              Text('sa'),
            ]),
          ),
        ),
      ],
    );
  }
}