import 'package:flutter/material.dart';
import 'package:delayed_display/delayed_display.dart';

class Home extends StatefulWidget {
@override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
Widget build(BuildContext context){
  return Scaffold(
    backgroundColor: Colors.grey[300],
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
       children: <Widget>[
        DelayedDisplay(
          delay: Duration(seconds: 1),
          fadingDuration: Duration(seconds: 2),
          child: Text(
            "Bienvenue",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 50.0,
              color: Colors.red[900],
    ),
  ),
),],),);
}
}