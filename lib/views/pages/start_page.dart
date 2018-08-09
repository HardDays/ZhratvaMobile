import 'package:flutter/material.dart';

import 'login_page.dart';

import '../routes/default_page_route.dart';

class StartPage extends StatelessWidget {

  void _onLogin(){

  }

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
             /*   Padding(padding: EdgeInsets.only(top: 20.0)),  
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Theme(
                    data: ThemeData(
                      primaryColor: Color.fromARGB(128, 255, 255, 255),
                      hintColor: Color.fromARGB(128, 255, 255, 255)
                    ),
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          color: Color.fromARGB(128, 255, 255, 255),
                          fontSize: 20.0,
                        ),
                        
                      ),
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 20.0
                      ),
                    )
                  )
                ),
                Padding(padding: EdgeInsets.only(top: 5.0)),  
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Theme(
                    data: ThemeData(
                      primaryColor: Color.fromARGB(128, 255, 255, 255),
                      hintColor: Color.fromARGB(128, 255, 255, 255)
                    ),
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: Color.fromARGB(128, 255, 255, 255),
                          fontSize: 20.0,
                        ),
                        
                      ),
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 20.0
                      ),
                    )
                  )
                ),*/
                Padding(padding: EdgeInsets.only(top: 50.0)),  
                Container(
                  width:  MediaQuery.of(context).size.width * 0.5,
                  height: 50.0,
                  child: FlatButton(
                    color: Colors.white,
                    onPressed: (){
                      Navigator.push(context, DefaultPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text('LOG IN',
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
                      _onLogin();
                    },
                    child: Text('SIGN UP',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0), )
                  )
                ),  
               /* Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                      child: Text("FORGOT PASSWORD",
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                      onPressed: (){
                      },
                    ),
                    FlatButton(
                      child: Text("REGISTER",
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                      onPressed: (){
                      },
                    )
                  ]
                )*/
              ],
            ),
          )
        )
      )
    );
  }
}
