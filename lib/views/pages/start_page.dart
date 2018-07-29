import 'package:flutter/material.dart';
import 'main_page.dart';
import '../routes/default_page_route.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Start'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Main page'),
          onPressed: () {
            Navigator.push(
              context,
              DefaultPageRoute(builder: (context) => MainPage()),
            );
          },
        ),
      ),
    );
  }
}
