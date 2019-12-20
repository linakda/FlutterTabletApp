import 'package:flutter/material.dart';
import 'package:GeoREF/MenuAffaire.dart';
import 'dart:async';
import 'main.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:GeoREF/Config.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Animation _animation;
  AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn);

    Future.delayed(Duration(seconds: 5), () async {
      await storage.readAndUpdateList();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MenuAffaire(),
          ));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      //Pour remplir le background avec une image floutée
      body: Container(
        height: Config.screenHeight,
        width: Config.screenWidth,
        decoration: new BoxDecoration(
          image: new DecorationImage(
              image: new AssetImage("assets/couv.png"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.8), BlendMode.dstATop)),
        ),

        //L'affichage du logo
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //L'affichage du texte en ombré
            Center(
              child: new Container(
                padding: new EdgeInsets.all(70.0),
                child: DelayedDisplay(
                  delay: Duration(seconds: 2),
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
                ),
              ),
            ),

            //Le bouton de commencement en ombré
            Center(
              child: new Container(
                padding: new EdgeInsets.all(30.0),
                child: DelayedDisplay(
                  delay: Duration(seconds: 1),
                  fadingDuration: Duration(seconds: 2),
                  child: new CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
