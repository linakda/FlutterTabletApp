import 'package:flutter/material.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/src/widgets/fade_in_image.dart';
class Home extends StatefulWidget {
@override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

Widget build(BuildContext context){
   return MaterialApp(
      home: Scaffold(
    backgroundColor: Colors.white,
    
      body: Column(
    mainAxisAlignment: MainAxisAlignment.center,
      
      children: <Widget>[
       
        FadeInImage.assetNetwork(
          fadeInDuration: 
          const Duration(seconds : 3),
          height: 300.0,
          width: 300.0,
          placeholder:'assets/42495.png',
          image: 'assets/42495.png',
          ),
              
        DelayedDisplay(
          delay: Duration(seconds: 2),
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
          ),
        ],
        ),
        ),
        );
  }
}