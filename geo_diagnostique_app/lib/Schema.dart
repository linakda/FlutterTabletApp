import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';


class LandingScreen extends StatefulWidget {
   @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {

 _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source : ImageSource.camera);
    Navigator.of(context).pop();
    this.setState((){
      imageFile=picture;
      });
  }//opencamera

  _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    Navigator.of(context).pop();
    this.setState((){
      imageFile=picture;
    });

  }//opengallery

  Future<void>  _showChoiceDialog(BuildContext context) {
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("Make a choice"),
        content: SingleChildScrollView(
          child: ListBody (
            children: <Widget>[
              GestureDetector(
                child: Text("Gallery"),
                onTap: () {
                  _openGallery(context);
                },
                ),
                Padding(padding: EdgeInsets.all(8.0),),
                GestureDetector(
                  child: Text("Camera"),
                  onTap: (){
                    _openCamera(context);
                  },
                  )
                ],
          ),
       ),
      );
    });
  }

  File imageFile;

  @override
  Widget build(BuildContext context){
    
  return Scaffold(
  

    body : Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text("No Image Selected"),
            RaisedButton(onPressed: () {
                _showChoiceDialog(context);
            },child: Text("Select Image")
            ,)
          ],
        )
        ),
    )
    );
}
 
}//class


