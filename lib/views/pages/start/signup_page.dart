import 'dart:async';

import 'package:flutter/material.dart';

import '../main/main_page.dart';

import '../../../helpers/api/main_api.dart';
import '../../../helpers/view/localization.dart';
import '../../../helpers/view/dialogs.dart';

import '../../../models/api/user.dart';
import '../../../models/storage/database.dart';
import '../../../models/storage/cache.dart';

import '../../widgets/keyboard_visible_widget.dart';
import '../../routes/default_page_route.dart';

class SignupPage extends StatefulWidget {

  @override
  SignupPageState createState() => new SignupPageState();

}

class SignupPageState extends State<SignupPage> {

  FocusNode firstNameNode = FocusNode();
  FocusNode lastNameNode = FocusNode();
  FocusNode phoneNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ScrollController scrollController = ScrollController();

  User user = User();

  @override
  void initState() {
    super.initState();
  }

   @override
  void dispose() {


    super.dispose();
  }

  void onSignup(){
    FormState form = formKey.currentState;

    if (form.validate()) {
      form.save();
      Dialogs.showLoader(context);
      MainAPI.createUser(user).then(
        (res){
          if (res != null){
            MainAPI.token = user.token;
            Database.setCurrentUser(res);
            Cache.flush();
            Cache.currentUser = res;
            Navigator.pushReplacement(
              context,
              DefaultPageRoute(builder: (context) => MainPage()),
            );
          }else{
            Dialogs.showMessage(context, Localization.textNotRegistered, Localization.textEmailTaken, Localization.buttonOk);          
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
                  margin: EdgeInsets.only(top: 0.0, right: 5.0),
                  width:  MediaQuery.of(context).size.height * 0.12,
                  height: MediaQuery.of(context).size.height * 0.17 ,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: ExactAssetImage('assets/images/logo.png'),
                      fit: BoxFit.cover,
                    ),
                  )
                ),
                Padding(padding: EdgeInsets.only(top: 0.0)),  
                Text('FOOD\nAPP',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w700
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 15.0)),  
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
                            keyboardType: TextInputType.text,
                            focusNode: firstNameNode,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: Localization.textFirstName,
                              hintStyle: TextStyle(
                                color: Color.fromARGB(128, 255, 255, 255),
                                fontSize: 20.0, 
                              ),
                            ),
                            validator: (val) {
                              if (val.isEmpty){
                                return Localization.textEnterFirstName;
                              }                               
                            },                              
                            onFieldSubmitted: (text){
                              FocusScope.of(context).requestFocus(lastNameNode);
                            },
                            onSaved: (val){
                              user.firstName = val;
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
                            keyboardType: TextInputType.text,
                            focusNode: lastNameNode,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: Localization.textLastName,
                              hintStyle: TextStyle(
                                color: Color.fromARGB(128, 255, 255, 255),
                                fontSize: 20.0, 
                              ),
                            ),
                            validator: (val) {
                              if (val.isEmpty){
                                return Localization.textEnterLastName;
                              }                               
                            },                              
                            onFieldSubmitted: (text){
                              FocusScope.of(context).requestFocus(phoneNode);
                            },
                            onSaved: (val){
                              user.lastName = val;
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
                            keyboardType: TextInputType.phone,
                            focusNode: phoneNode,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: Localization.textPhone,
                              hintStyle: TextStyle(
                                color: Color.fromARGB(128, 255, 255, 255),
                                fontSize: 20.0, 
                              ),
                            ),
                            validator: (val) {
                              if (val.length < 5){
                                return Localization.textEnterPhone;
                              }                                 
                            },                              
                            onFieldSubmitted: (text){
                              FocusScope.of(context).requestFocus(emailNode);
                            },
                            onSaved: (val){
                              user.phone = val;
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
                            validator: (val) {
                              if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val)){
                                return Localization.textNotValidEmail;
                              }                               
                            },                              
                            onFieldSubmitted: (text){
                              FocusScope.of(context).requestFocus(passwordNode);
                            },
                            onSaved: (val){
                              user.email = val;
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
                              if (val.length <= 7){
                                return Localization.textShortPassword;
                              }                               
                            },  
                            onSaved: (val){
                              user.password = val;
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
                      onSignup();
                    },
                    child: Text(Localization.buttonSignUp,
                      style: TextStyle(
                        color: Color.fromARGB(255, 247, 131, 6),
                      ),
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))
                  )
                ),     
                Padding(padding: EdgeInsets.only(bottom: 20.0)),           
                Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).viewInsets.bottom))
              ],
            ),
          )
        )
      )
    );
  }
}
