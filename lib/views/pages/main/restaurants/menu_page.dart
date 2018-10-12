import 'package:flutter/material.dart';
import 'menu_item_page.dart';

import '../../../widgets/cart_widget.dart';

import '../../../routes/default_page_route.dart';

import '../../../../models/api/restaurant.dart';
import '../../../../models/api/menu_item.dart';

import '../../../../helpers/view/localization.dart';

class MenuPage extends StatelessWidget {

  Restaurant restaurant;
  List <MenuItem> list;

  MenuPage({this.restaurant, this.list}){
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Localization.titleMenu,
          style: TextStyle(
            color: Colors.white
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 247, 131, 6),
        actions: [
          CartWidget()
        ]       
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        children: List.generate(list.length, (index) {
          return GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  DefaultPageRoute(builder: (context) => MenuItemPage(item: list[index], restaurant: restaurant,)),
                );
              },
            child: Container(
            margin: EdgeInsets.all(5.0),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.width * 0.53,
                  child: Card( 
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 15.0),
                            width:  MediaQuery.of(context).size.width * 0.27,
                            height: MediaQuery.of(context).size.width * 0.27,
                            decoration: BoxDecoration(
                            shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(list[index].cover()),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 3.0)),
                          Text(list[index].name,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 3.0)),
                          Text('${list[index].price} ${Localization.textRUB}',
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Color.fromARGB(255, 247, 131, 6),
                            ),
                          ),
                        ]
                      ),
                    ),
                  )
                ),
                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.52 - 20),
                  child: FlatButton(
                    color: Color.fromARGB(255, 247, 131, 6),
                    onPressed: (){
                      Navigator.push(
                        context,
                        DefaultPageRoute(builder: (context) => MenuItemPage(item: list[index], restaurant: restaurant,)),
                      );
                    },
                    child: Text(Localization.buttonBuy,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.0
                      ),
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))
                  ),
                ),
              ]
            )
            )
          );
        }),
      )
    );
  }
}
