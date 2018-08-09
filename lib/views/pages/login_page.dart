import 'dart:async';
import 'package:flutter/material.dart';

import '../widgets/keyboard_visible_widget.dart';


class LoginPage extends StatefulWidget {

  @override
  LoginPageState createState() => new LoginPageState();

}

class LoginPageState extends State<LoginPage> {

  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();

  Container dumb;

  ScrollController scrollController = ScrollController();


  @override
  void initState() {
    super.initState();
    //MediaQuery.of(context).viewInsets.bottom
/*
    focusNode1.addListener(
      (){
        if (focusNode1.hasFocus){
          print('here1');
          scrollController.animateTo(MediaQuery.of(this.context).viewInsets.bottom, curve: Curves.easeOut, duration: Duration(milliseconds: 300));
        }
      }
    );

    focusNode2.addListener(
      () async {
        if (focusNode2.hasFocus){
          await new Future.delayed(const Duration(milliseconds: 1800));
          var t = TextField();
          var pos = scrollController.position;
          //pos.ensureVisible(context.findRenderObject());
          
          print(MediaQuery.of(this.context).viewInsets.bottom);
          scrollController.animateTo(MediaQuery.of(context).viewInsets.bottom, curve: Curves.easeOut, duration: Duration(milliseconds: 300));
        }
      }
    );*/
  }

   @override
  void dispose() {


    super.dispose();
  }

  void _onLogin(){

  }

  @override
  Widget build(BuildContext context) {
    dumb = new Container();
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
          physics: NeverScrollableScrollPhysics(),
          controller: scrollController,
          child: Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
                  width:  MediaQuery.of(context).size.height * 0.2,
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: ExactAssetImage('assets/images/logo.png'),
                      fit: BoxFit.cover,
                    ),
                  )
                ),
                Padding(padding: EdgeInsets.only(top: 5.0)),    
                Text('${MediaQuery.of(this.context).viewInsets.bottom}',
                  style: TextStyle(
                    fontSize: 45.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w700
                  ),
                ),             
                Padding(padding: EdgeInsets.only(top: 30.0)),  
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
                    child: KeyboardVisibleWidget(
                      focusNode: focusNode1,
                      scrollController: scrollController,
                      child: TextField(
                        onSubmitted: (text){
                          print('kek');
                        },
                        focusNode: focusNode1,
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
                  )
                ),
                Padding(padding: EdgeInsets.only(top: 20.0)),  
                Container(
                  width:  MediaQuery.of(context).size.width * 0.5,
                  height: 50.0,
                  child: FlatButton(
                    color: Colors.white,
                    onPressed: (){
                      _onLogin();
                    },
                    child: Text('LOG IN',
                      style: TextStyle(
                        color: Color.fromARGB(255, 247, 131, 6),
                      ),
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))
                  )
                ),  
                Padding(padding: EdgeInsets.only(top: 10.0)),  
                Row(
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
                  ]
                ),
                Padding(padding: EdgeInsets.only(top: MediaQuery.of(this.context).viewInsets.bottom))
              ],
            ),
          )
        )
      )
    );
  }
}
