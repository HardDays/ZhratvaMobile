import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 247, 131, 6),
      body: Center(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
              width:  MediaQuery.of(context).size.height * 0.3,
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: ExactAssetImage('assets/images/logo.png'),
                  fit: BoxFit.cover,
                ),
              )
            ),
            Padding(padding: EdgeInsets.only(top: 5.0)),  
            Text('Eat Up',
              style: TextStyle(
                fontSize: 45.0,
                color: Colors.white,
                fontWeight: FontWeight.w700
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 25.0)),  
            CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white)),
          ]
        )
      )
    );
  }
}