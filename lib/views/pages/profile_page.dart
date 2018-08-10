import 'package:flutter/material.dart';

import 'start_page.dart';

import '../routes/default_page_route.dart';

import '../../models/storage/cache.dart';
import '../../models/storage/database.dart';

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
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(  
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 30.0),
                  width:  MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: ExactAssetImage('assets/images/placeholder.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),  
                Padding(padding: EdgeInsets.only(top: 20.0)),  
                Text('${Cache.currentUser.firstName} ${Cache.currentUser.lastName}',
                  style: TextStyle(
                    fontSize: 20.0
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 50.0)),  
                Container(  
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Divider(
                    color: Colors.grey, 
                    height: 1.0,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: FlatButton(
                    child: Text('PROFILE',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color.fromARGB(255, 128, 128, 128)
                      ),
                    ),
                    onPressed: (){

                    },
                  )
                ),
                Container(  
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Divider(
                    color: Colors.grey, 
                    height: 1.0,
                  ),
                ),    
                Container(
                  margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: FlatButton(
                    child: Text('HISTORY',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color.fromARGB(255, 128, 128, 128)
                      ),
                    ),
                    onPressed: (){

                    },
                  )
                ),
                Container(  
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Divider(
                    color: Colors.grey, 
                    height: 1.0,
                  ),
                ),    
                Container(
                  margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: FlatButton(
                    child: Text('SETTINGS',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color.fromARGB(255, 128, 128, 128)
                      ),
                    ),
                    onPressed: (){

                    },
                  )
                ),
                Container(  
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Divider(
                    color: Colors.grey, 
                    height: 1.0,
                  ),
                ),    
                Container(
                  margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: FlatButton(
                    child: Text('LOGOUT',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color.fromARGB(255, 128, 128, 128)
                      ),
                    ),
                    onPressed: (){
                      Cache.currentUser = null;
                      Database.deleteCurrentUser(); 
                      Navigator.pushReplacement(
                        context, 
                        DefaultPageRoute(builder: (context) => StartPage())
                      );
                    },
                  )
                ),
                Container(  
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Divider(
                    color: Colors.grey, 
                    height: 1.0,
                  ),
                ),    
              ]
            ),
          )
        ),
      ),     
    );
  }
}