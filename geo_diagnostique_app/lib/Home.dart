import 'package:flutter/material.dart';
import 'package:geo_diagnostique_app/MenuAffaire.dart';
import 'dart:async';
import 'package:delayed_display/delayed_display.dart';
import 'package:geo_diagnostique_app/Config.dart';



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SplashScreen()); // define it once at root level.
  }
}

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 8), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MenuAffaire(),
          ));
    });
  }

Widget build(BuildContext context){
  
      return Scaffold(
    backgroundColor: Colors.black,
    
    //Pour remplir le background avec une image floutée
      body: Container(
        height: Config.screenHeight, 
              width: Config.screenWidth,
              decoration: new BoxDecoration(
              image: new DecorationImage(image: new AssetImage("assets/back2.png"), fit: BoxFit.cover, colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.dstATop)),
                ),
    
          //L'affichage du logo
          child :  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
              Center(  
                child: new Container( 
                    padding: new EdgeInsets.all(90.0),
                        child : new DelayedDisplay(
                            delay: Duration(seconds:1),
                            fadingDuration: Duration(seconds: 2),
                             child: FadeInImage.assetNetwork(
                                    fadeInDuration: 
                                    const Duration(seconds : 3),
                                    height: 150.0,
                                    width: 100.0,
                                    placeholder:'assets/size2.png',
                                    image: 'assets/size2.png',
                                    ),
                              ), 
                              ),
                              ),
                    
                    //L'affichage du texte en ombré
                Center( 
                  child: new Container (
                    padding:new EdgeInsets.all(70.0),
                        child : 
                          DelayedDisplay(
                          delay: Duration(seconds:2),
                          fadingDuration: Duration(seconds: 3),
                          child: Text(
                          "Bienvenue",
                           textAlign: TextAlign.center,
                           style: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 50.0,
                            color: Colors.white,
                            ),
                          ),
                        ),),
                        ),

                    //Le bouton de commencement en ombré
                  Center(  
                    child: new Container (
                      padding:new EdgeInsets.all(30.0),
                        child:
                          DelayedDisplay(
                            delay: Duration(seconds:1),
                            fadingDuration: Duration(seconds: 2),
                              child:  new CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),),
        
                                ),
          ),
          ),
          

      ],
      ),
      
      ),);
        
  }
}


