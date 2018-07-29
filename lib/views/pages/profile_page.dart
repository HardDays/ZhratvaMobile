import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}