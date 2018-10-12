import 'dart:async';

import 'package:flutter/material.dart';

import '../main/main_page.dart';

import '../../../helpers/api/main_api.dart';
import '../../../helpers/view/localization.dart';
import '../../../helpers/view/dialogs.dart';

import '../../../models/storage/database.dart';
import '../../../models/storage/cache.dart';

import '../../widgets/keyboard_visible_widget.dart';
import '../../routes/default_page_route.dart';

class LoginPage extends StatefulWidget {

  @override
  LoginPageState createState() => new LoginPageState();

}

class LoginPageState extends State<LoginPage> {

  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ScrollController scrollController = ScrollController();

  String email;
  String password;

  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

   @override
  void dispose() {
    super.dispose();
  }

  void onLogin(){
    FormState form =  formKey.currentState;
    if (form.validate()) {
      Dialogs.showLoader(context);
      form.save();
      MainAPI.authorize(email, password).then(
        (res){
          if (res != null){
            Cache.flush();  
            Cache.currentUser = res;
            Database.setCurrentUser(res);
            MainAPI.token = res.token;
            Navigator.pushReplacement(
              context,
              DefaultPageRoute(builder: (context) => MainPage()),
            );
          } else {
            Navigator.pop(context);    
            Dialogs.showMessage(context, Localization.textUnauthorized, Localization.textWrongEmailPass, Localization.buttonOk);
          }
        } 
      );
    }
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: true,
      body: Container(
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
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 40.0, left: 10.0),
                  child: IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    iconSize: 30.0,
                    icon: Icon(Icons.arrow_back,
                      color: Colors.white,
                    ),
                  )
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 10.0, right: 7.0),
                  width:  MediaQuery.of(context).size.height * 0.17,
                  height: MediaQuery.of(context).size.height * 0.22 ,
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
                    fontSize: 35.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w700
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 20.0)),  
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Theme(
                          data: ThemeData(
                            primaryColor: Color.fromARGB(128, 255, 255, 255),
                            hintColor: Color.fromARGB(128, 255, 255, 255),
                            errorColor: Color.fromARGB(128, 55, 0, 0)
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            focusNode: emailNode,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: Localization.textEmail,
                              hintStyle: TextStyle(
                                color: Color.fromARGB(128, 255, 255, 255),
                                fontSize: 20.0, 
                              ),
                            ),
                            onSaved: (val) {
                              email = val;
                            },
                            validator: (val) {
                              if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val)){
                                return Localization.textNotValidEmail;
                              }                               
                            },                              
                            onFieldSubmitted: (text){
                              FocusScope.of(context).requestFocus(passwordNode);
                            },
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 20.0
                            ),
                          )
                        ),      
                        Padding(padding: EdgeInsets.only(top: 5.0)),
                        Theme(
                          data: ThemeData(
                            primaryColor: Color.fromARGB(128, 255, 255, 255),
                            hintColor: Color.fromARGB(128, 255, 255, 255),
                            errorColor: Color.fromARGB(128, 55, 0, 0)
                          ),
                          child: TextFormField(
                            obscureText: true,                             
                            focusNode: passwordNode,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: Localization.textPassword,
                              hintStyle: TextStyle(
                                color: Color.fromARGB(128, 255, 255, 255),
                                fontSize: 20.0,
                              ),
                            ),
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 20.0
                            ),
                            validator: (val) {
                              if (val.length < 5){
                                return Localization.textShortPassword;
                              }                               
                            },  
                            onSaved: (val) {
                              password = val;
                            },
                          )
                        )      
                      ],
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
                      onLogin();
                    },
                    child: Text(Localization.buttonLogin,
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
                      child: Text(Localization.buttonForgotPassword,
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
