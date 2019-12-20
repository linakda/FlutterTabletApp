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
    Config().init(context);
    return Scaffold(
      backgroundColor: Colors.black,

      //Pour remplir le background avec une image floutée
      body: Container(
        height: Config.screenHeight,
        width: Config.screenWidth,
        decoration: new BoxDecoration(
          image: new DecorationImage(
              image: new AssetImage("assets/couv.png"), fit: BoxFit.cover),
        ),

        //L'affichage du logo
        child:
            //Le bouton de commencement en ombré
            Center(
          child: new Container(
            padding: new EdgeInsets.all(30.0),
            child: DelayedDisplay(
              delay: Duration(seconds: 1),
              fadingDuration: Duration(seconds: 2),
              child: new CircularProgressIndicator(
                valueColor:
                    new AlwaysStoppedAnimation<Color>(Config.appBarColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
