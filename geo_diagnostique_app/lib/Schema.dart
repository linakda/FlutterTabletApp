import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geo_diagnostique_app/Config.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'dart:math'as Math;

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  File imageFile;
  String _imageString = "";

  //Accès caméra
  _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    Navigator.of(context).pop();
    this.setState(() {
      imageFile = picture;
    });
  }

  //Accès gallerie 
  _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    Navigator.of(context).pop();
    this.setState(() {
      imageFile = picture;
    });
  }

  String setImage() {
    if (imageFile != null){
      _imageString = base64.encode(imageFile.readAsBytesSync());
      return _imageString;
    }
    else return "";
  }

  Widget showImage(String stringImg) {
    //permet d'afficher l'image
    if (stringImg != "") {
      return Image.memory(base64.decode(stringImg));
    } else {
      return Container(
        color: Colors.grey,
        padding: EdgeInsets.all(Config.screenPadding*5),
        child: const Text(
          'Aucune image',
          style: TextStyle(
            fontFamily: 'AbrilFatface-Regular',
            fontSize: 30
          ),
          textAlign: TextAlign.center,
        ),
      );
    }
  }

  List<Positioned> _cliclableArrayGenerator(){
    List<Positioned> clickableSchema = new List<Positioned>();
    double schemSize = Config.screenWidth/1.5;
    double dotCenter = schemSize/2-10;
    double radius = schemSize/2-30;
    clickableSchema.add(
      Positioned(
        child: Container(
          height: schemSize ,
          width: schemSize,
          child: showImage(setImage()),
        ),
      )
    );

    for(var i=0;i<13;i++){
      if(i==0){
        clickableSchema.add(
          Positioned(
            child: Container(
              height: schemSize ,
              width: schemSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/Image1.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        );
      }
      else{
        clickableSchema.add(
          Positioned(
            top: dotCenter-radius*Math.sin((i-1)*Math.pi/6),
            left: dotCenter+radius*Math.cos((i-1)*Math.pi/6),
            child: Container(
              height: Config.screenWidth / 30,
              width: Config.screenWidth / 30,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/Image2.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        );
      }
    }
    return clickableSchema;
  }

  //Sélection camera ou gallerie
  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Make a choice"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      _openCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
            children: <Widget>[
              /*RaisedButton(
                onPressed: () {
                  _showChoiceDialog(context);
                },
                child: Text("Ajouter image"),
              ),*/
              Stack(
                children: _cliclableArrayGenerator(),
              )
            ]),
      
    );
  }
}
