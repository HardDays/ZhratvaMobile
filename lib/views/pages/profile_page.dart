import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile',
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Profile'),
          backgroundColor: Color.fromARGB(255, 247, 131, 6),     
        ),
        body: Center(
          child: SingleChildScrollView(
          )
        ),
      ),
    );
  }
}