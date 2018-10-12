import 'package:flutter/material.dart';

import 'login_page.dart';
import 'signup_page.dart';

import '../../../helpers/view/localization.dart';

import '../../routes/default_page_route.dart';

class StartPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(128, 247, 131, 6),
              Color.fromARGB(255, 247, 131, 6),
            ]
          )
        ),
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15, right: 7.0),
                  width:  MediaQuery.of(context).size.height * 0.2,
                  height: MediaQuery.of(context).size.height * 0.25 ,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: ExactAssetImage('assets/images/logo.png'),
                      fit: BoxFit.cover,
                    ),
                  )
                ),
                Padding(padding: EdgeInsets.only(top: 5.0)),  
                Text('FOOD\nAPP',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 45.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w700
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 50.0)),  
                Container(
                  width:  MediaQuery.of(context).size.width * 0.5,
                  height: 50.0,
                  child: FlatButton(
                    color: Colors.white,
                    onPressed: (){
                      Navigator.push(context, DefaultPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text(Localization.buttonLogin,
                      style: TextStyle(
                        color: Color.fromARGB(255, 247, 131, 6),
                      ),
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))
                  )
                ),  
                Padding(padding: EdgeInsets.only(top: 20.0)),  
                 Container(
                  width:  MediaQuery.of(context).size.width * 0.5,
                  height: 50.0,
                  child: OutlineButton(
                    color: Colors.white,
                    onPressed: (){
                      Navigator.push(context, DefaultPageRoute(builder: (context) => SignupPage()));
                    },
                    child: Text(Localization.buttonSignUp,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0), )
                  )
                ),  
              ],
            ),
          )
        )
      )
    );
  }
}
