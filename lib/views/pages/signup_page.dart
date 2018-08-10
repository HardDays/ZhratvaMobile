import 'dart:async';

import 'package:flutter/material.dart';
import 'package:validator/validator.dart';

import 'main_page.dart';

import '../../helpers/api/main_api.dart';

import '../../models/api/user.dart';
import '../../models/storage/database.dart';
import '../../models/storage/cache.dart';

import '../widgets/keyboard_visible_widget.dart';
import '../routes/default_page_route.dart';

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

  void _onSignup(){
    FormState form = formKey.currentState;

    if (form.validate()) {
      form.save();
      MainAPI.createUser(user).then(
        (res){
          if (res != null){
            Database.setCurrentUser(res);
            Cache.currentUser = res;
            Navigator.pushReplacement(
              context,
              DefaultPageRoute(builder: (context) => MainPage()),
            );
          }
        }
      );
    }
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
          physics: MediaQuery.of(context).viewInsets.bottom > 0 ? NeverScrollableScrollPhysics() : PageScrollPhysics(),
          controller: scrollController,
          child: Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.12),
                  width:  MediaQuery.of(context).size.height * 0.12,
                  height: MediaQuery.of(context).size.height * 0.12,
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
                    fontSize: 30.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w700
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 30.0)),  
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
                          child: KeyboardVisibleWidget(
                            focusNode: firstNameNode,
                            scrollController: scrollController,
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              focusNode: firstNameNode,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: 'First name',
                                hintStyle: TextStyle(
                                  color: Color.fromARGB(128, 255, 255, 255),
                                  fontSize: 20.0, 
                                ),
                              ),
                              validator: (val) {
                                if (val.isEmpty){
                                  return 'Enter your first name';
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
                          )
                        ),
                        Padding(padding: EdgeInsets.only(top: 5.0)),
                        Theme(
                          data: ThemeData(
                            primaryColor: Color.fromARGB(128, 255, 255, 255),
                            hintColor: Color.fromARGB(128, 255, 255, 255),
                            errorColor: Color.fromARGB(128, 55, 0, 0)
                          ),
                          child: KeyboardVisibleWidget(
                            focusNode: lastNameNode,
                            scrollController: scrollController,
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              focusNode: lastNameNode,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: 'Last name',
                                hintStyle: TextStyle(
                                  color: Color.fromARGB(128, 255, 255, 255),
                                  fontSize: 20.0, 
                                ),
                              ),
                              validator: (val) {
                                if (val.isEmpty){
                                  return 'Enter your last name';
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
                          )
                        ),
                        Padding(padding: EdgeInsets.only(top: 5.0)),
                        Theme(
                          data: ThemeData(
                            primaryColor: Color.fromARGB(128, 255, 255, 255),
                            hintColor: Color.fromARGB(128, 255, 255, 255),
                            errorColor: Color.fromARGB(128, 55, 0, 0)
                          ),
                          child: KeyboardVisibleWidget(
                            focusNode: phoneNode,
                            scrollController: scrollController,
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              focusNode: phoneNode,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: 'Phone',
                                hintStyle: TextStyle(
                                  color: Color.fromARGB(128, 255, 255, 255),
                                  fontSize: 20.0, 
                                ),
                              ),
                              validator: (val) {
                                if (val.length < 5){
                                  return 'Enter valid phone';
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
                          )
                        ),
                        Padding(padding: EdgeInsets.only(top: 5.0)),
                        Theme(
                          data: ThemeData(
                            primaryColor: Color.fromARGB(128, 255, 255, 255),
                            hintColor: Color.fromARGB(128, 255, 255, 255),
                            errorColor: Color.fromARGB(128, 55, 0, 0)
                          ),
                          child: KeyboardVisibleWidget(
                            focusNode: emailNode,
                            scrollController: scrollController,
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              focusNode: emailNode,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                  color: Color.fromARGB(128, 255, 255, 255),
                                  fontSize: 20.0, 
                                ),
                              ),
                              validator: (val) {
                                if (!isEmail(val)){
                                  return 'Not a valid email';
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
                          )
                        ),
                        Padding(padding: EdgeInsets.only(top: 5.0)),
                        Theme(
                          data: ThemeData(
                            primaryColor: Color.fromARGB(128, 255, 255, 255),
                            hintColor: Color.fromARGB(128, 255, 255, 255),
                            errorColor: Color.fromARGB(128, 55, 0, 0)
                          ),
                          child: KeyboardVisibleWidget(
                            focusNode: passwordNode,
                            scrollController: scrollController,
                            child: TextFormField(
                              obscureText: true,                             
                              focusNode: passwordNode,
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
                              validator: (val) {
                                if (val.length < 7){
                                  return 'Enter more than 7 symbols';
                                }                               
                              },  
                              onSaved: (val){
                                user.password = val;
                              },
                            )
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
                      _onSignup();
                    },
                    child: Text('SIGN UP',
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
