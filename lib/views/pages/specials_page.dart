import 'package:flutter/material.dart';

class SpecialsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Specials',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Specials'),
        ),
        body: Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
