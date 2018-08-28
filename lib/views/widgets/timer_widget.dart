import 'package:flutter/material.dart';

import '../../helpers/view/formatter.dart';

import '../../models/api/order.dart';

import 'dart:async';

class TimerWidget extends StatefulWidget {
  
  DateTime end;

  TimerWidget({this.end});

  TimerWidgetState createState() => new TimerWidgetState();
}

class TimerWidgetState extends State<TimerWidget> {
  Timer timer;
  Duration currentTime;

  @override
  void initState() {
    super.initState();
    setState(
      () {
        timer = Timer.periodic(Duration(seconds: 5), onTimer);
      }
    );    
  }

  void onTimer(Timer timer){
    setState(
      () {
        currentTime = (widget.end.difference(DateTime.now()));
      }
     );
  }
  
  @override
  Widget build(BuildContext context) {
    return Text(Formatter.longDuration(currentTime),
      style: TextStyle(
        fontSize: 40.0
      ),
    );
  }
}