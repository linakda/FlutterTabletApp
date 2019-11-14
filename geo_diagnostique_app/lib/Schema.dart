import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geo_diagnostique_app/Config.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'dart:math' as Math;

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  File imageFile;
  String _imageString = "";
  String dropdownValueReference = "Référence";
  String dropdownValueRole = "Rôle";
  String dropdownValueGeometrie = "Géométrie";
  String dropdownValueNature = "Nature";
  TextEditingController profondeurController = TextEditingController();
  String dropdownValueRole1 = "Rôle";
  String dropdownValueGeometrie1 = "Géométrie";
  String dropdownValueNature1 = "Nature";
  TextEditingController profondeurController1 = TextEditingController();
  String dropdownValueRole2 = "Rôle";
  String dropdownValueGeometrie2 = "Géométrie";
  String dropdownValueNature2 = "Nature";
  TextEditingController profondeurController2 = TextEditingController();
  String dropdownValueRole3 = "Rôle";
  String dropdownValueGeometrie3 = "Géométrie";
  String dropdownValueNature3 = "Nature";
  TextEditingController profondeurController3 = TextEditingController();
  String dropdownValueRole4 = "Rôle";
  String dropdownValueGeometrie4 = "Géométrie";
  String dropdownValueNature4 = "Nature";
  TextEditingController profondeurController4 = TextEditingController();
  String dropdownValueRole5 = "Rôle";
  String dropdownValueGeometrie5 = "Géométrie";
  String dropdownValueNature5 = "Nature";
  TextEditingController profondeurController5 = TextEditingController();
  int fsf = -1;
  int fe1f = -1;
  int fe2f = -1;
  int fe3f = -1;
  int fe4f = -1;
  int fe5f = -1;
  List<bool> aff = [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true
  ];

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    Navigator.of(context).pop();
    this.setState(() {
      imageFile = picture;
    });
  } //opencamera

  _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    Navigator.of(context).pop();
    this.setState(() {
      imageFile = picture;
    });
  } //opengallery

  String setImage() {
    if (imageFile != null) {
      _imageString = base64.encode(imageFile.readAsBytesSync());
      return _imageString;
    } else
      return "";
  }

  Widget showImage(String stringImg) {
    //permet d'afficher l'image
    if (stringImg != "") {
      return Image.memory(base64.decode(stringImg));
    } else {
      return Container(
        //color: Colors.grey,
        padding: EdgeInsets.all(Config.screenPadding * 5),
        child: const Text(
          'Aucune image sélectionnée',
          style: TextStyle(fontFamily: 'AbrilFatface-Regular', fontSize: 40),
          textAlign: TextAlign.center,
        ),
      );
    }
  }

  List<Positioned> _cliclableArrayGenerator() {
    List<Positioned> clickableSchema = new List<Positioned>();
    double schemSize = Config.screenWidth / 1.5;
    double dotCenter = schemSize / 2 - 37;
    double radius = schemSize / 2 - 40;
    clickableSchema.add(Positioned(
      child: Container(
        height: schemSize,
        width: schemSize,
        child: showImage(setImage()),
      ),
    ));

    for (var i = 0; i < 13; i++) {
      if (i == 0) {
        clickableSchema.add(
          Positioned(
            child: Container(
              height: schemSize,
              width: schemSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/cercle1.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        );
      } else {
        clickableSchema.add(
          Positioned(
              key: Key('$i'),
              top: dotCenter -
                  radius * Math.sin((i - 1) * Math.pi / 6 + Math.pi / 2) +
                  15,
              left: dotCenter +
                  radius * Math.cos((i - 1) * Math.pi / 6 + Math.pi / 2) +
                  18,
              child: InkWell(
                child: RotationTransition(
                  turns: AlwaysStoppedAnimation(15 / 360),
                  child: Container(
                    height: Config.screenWidth / 30,
                    width: Config.screenWidth / 30,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: aff[i - 1]
                            ? AssetImage('assets/Image2.png')
                            : AssetImage('assets/dot-ConvertImage.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    aff[i - 1] ? aff[i - 1] = false : aff[i - 1] = true;
                    dropdownValueReference == 'fs'
                        ? fsf = i
                        : dropdownValueReference == 'fe1'
                            ? fe1f = i
                            : dropdownValueReference == 'fe2'
                                ? fe2f = i
                                : dropdownValueReference == 'fe3'
                                    ? fe3f = i
                                    : dropdownValueReference == 'fe4'
                                        ? fe4f = i
                                        : dropdownValueReference == 'fe5'
                                            ? fe5f = i
                                            : dropdownValueReference =
                                                'Référence';
                  });
                },
              )),
        );
      }
    }
    return clickableSchema;
  }

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
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(Config.screenPadding),
                  child: RaisedButton(
                    onPressed: () {
                      _showChoiceDialog(context);
                    },
                    child: Text(
                      "Ajouter image",
                      style: TextStyle(
                          fontSize: Config.fontSize, color: Colors.black),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(Config.screenPadding),
                  child: DropdownButton<String>(
                    hint: SizedBox(
                      width: 320.0,
                      child: Text(
                        dropdownValueReference,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: Config.fontSize, color: Colors.black),
                      ),
                    ),
                    style: TextStyle(
                        fontSize: Config.fontSize, color: Colors.black),
                    items: <String>['fs', 'fe1', 'fe2', 'fe3', 'fe4', 'fe5']
                        .map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: SizedBox(
                          width: 320.0,
                          child: Text(
                            value,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: Config.fontSize, color: Colors.black),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValueReference = newValue;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(Config.screenPadding),
                  child: Stack(
                    children: _cliclableArrayGenerator(),
                  ),
                ),
                Visibility(
                  visible: dropdownValueReference == 'fs',
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(Config.screenPadding),
                        child: DropdownButton<String>(
                          hint: SizedBox(
                            width: 320.0,
                            child: Text(
                              dropdownValueRole,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: Config.fontSize,
                                  color: Colors.black),
                            ),
                          ),
                          style: TextStyle(
                              fontSize: Config.fontSize, color: Colors.black),
                          items: <String>[
                            'grille',
                            'collecteur',
                            'branchement',
                            'avaloir',
                            'canalisation',
                            'déverse',
                            '???'
                          ].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: SizedBox(
                                width: 320.0,
                                child: Text(
                                  value,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: Config.fontSize,
                                      color: Colors.black),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValueRole = newValue;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Config.screenPadding),
                        child: DropdownButton<String>(
                          hint: SizedBox(
                            width: 320.0,
                            child: Text(
                              dropdownValueGeometrie,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: Config.fontSize,
                                  color: Colors.black),
                            ),
                          ),
                          style: TextStyle(
                              fontSize: Config.fontSize, color: Colors.black),
                          items: <String>[
                            'circulaire',
                            'rectangulaire',
                            'voûte',
                            'ovoïde',
                            '???'
                          ].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: SizedBox(
                                width: 320.0,
                                child: Text(
                                  value,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: Config.fontSize,
                                      color: Colors.black),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValueGeometrie = newValue;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Config.screenPadding),
                        child: TextField(
                            controller: profondeurController,
                            decoration: InputDecoration(
                              labelText: 'Profondeur',
                              labelStyle: TextStyle(color: Config.textColor),
                              focusColor: Config.color,
                              fillColor: Colors.white,
                              focusedBorder: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(color: Config.color),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Config.screenPadding),
                        child: DropdownButton<String>(
                          hint: SizedBox(
                            width: 320.0,
                            child: Text(
                              dropdownValueNature,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: Config.fontSize,
                                  color: Colors.black),
                            ),
                          ),
                          style: TextStyle(
                              fontSize: Config.fontSize, color: Colors.black),
                          items: <String>[
                            'B',
                            'FC',
                            'PVC',
                            'G',
                            'briques',
                            '???'
                          ].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: SizedBox(
                                width: 320.0,
                                child: Text(
                                  value,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: Config.fontSize,
                                      color: Colors.black),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValueNature = newValue;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: dropdownValueReference == 'fe1',
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(Config.screenPadding),
                        child: DropdownButton<String>(
                          hint: SizedBox(
                            width: 320.0,
                            child: Text(
                              dropdownValueRole1,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: Config.fontSize,
                                  color: Colors.black),
                            ),
                          ),
                          style: TextStyle(
                              fontSize: Config.fontSize, color: Colors.black),
                          items: <String>[
                            'grille',
                            'collecteur',
                            'branchement',
                            'avaloir',
                            'canalisation',
                            'déverse',
                            '???'
                          ].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: SizedBox(
                                width: 320.0,
                                child: Text(
                                  value,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: Config.fontSize,
                                      color: Colors.black),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValueRole1 = newValue;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Config.screenPadding),
                        child: DropdownButton<String>(
                          hint: SizedBox(
                            width: 320.0,
                            child: Text(
                              dropdownValueGeometrie1,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: Config.fontSize,
                                  color: Colors.black),
                            ),
                          ),
                          style: TextStyle(
                              fontSize: Config.fontSize, color: Colors.black),
                          items: <String>[
                            'circulaire',
                            'rectangulaire',
                            'voûte',
                            'ovoïde',
                            '???'
                          ].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: SizedBox(
                                width: 320.0,
                                child: Text(
                                  value,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: Config.fontSize,
                                      color: Colors.black),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValueGeometrie1 = newValue;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Config.screenPadding),
                        child: TextField(
                            controller: profondeurController1,
                            decoration: InputDecoration(
                              labelText: 'Profondeur',
                              labelStyle: TextStyle(color: Config.textColor),
                              focusColor: Config.color,
                              fillColor: Colors.white,
                              focusedBorder: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(color: Config.color),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Config.screenPadding),
                        child: DropdownButton<String>(
                          hint: SizedBox(
                            width: 320.0,
                            child: Text(
                              dropdownValueNature1,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: Config.fontSize,
                                  color: Colors.black),
                            ),
                          ),
                          style: TextStyle(
                              fontSize: Config.fontSize, color: Colors.black),
                          items: <String>[
                            'B',
                            'FC',
                            'PVC',
                            'G',
                            'briques',
                            '???'
                          ].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: SizedBox(
                                width: 320.0,
                                child: Text(
                                  value,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: Config.fontSize,
                                      color: Colors.black),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValueNature = newValue;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: dropdownValueReference == 'fe2',
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(Config.screenPadding),
                        child: DropdownButton<String>(
                          hint: SizedBox(
                            width: 320.0,
                            child: Text(
                              dropdownValueRole2,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: Config.fontSize,
                                  color: Colors.black),
                            ),
                          ),
                          style: TextStyle(
                              fontSize: Config.fontSize, color: Colors.black),
                          items: <String>[
                            'grille',
                            'collecteur',
                            'branchement',
                            'avaloir',
                            'canalisation',
                            'déverse',
                            '???'
                          ].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: SizedBox(
                                width: 320.0,
                                child: Text(
                                  value,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: Config.fontSize,
                                      color: Colors.black),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValueRole2 = newValue;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Config.screenPadding),
                        child: DropdownButton<String>(
                          hint: SizedBox(
                            width: 320.0,
                            child: Text(
                              dropdownValueGeometrie2,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: Config.fontSize,
                                  color: Colors.black),
                            ),
                          ),
                          style: TextStyle(
                              fontSize: Config.fontSize, color: Colors.black),
                          items: <String>[
                            'circulaire',
                            'rectangulaire',
                            'voûte',
                            'ovoïde',
                            '???'
                          ].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: SizedBox(
                                width: 320.0,
                                child: Text(
                                  value,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: Config.fontSize,
                                      color: Colors.black),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValueGeometrie2 = newValue;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Config.screenPadding),
                        child: TextField(
                            controller: profondeurController2,
                            decoration: InputDecoration(
                              labelText: 'Profondeur',
                              labelStyle: TextStyle(color: Config.textColor),
                              focusColor: Config.color,
                              fillColor: Colors.white,
                              focusedBorder: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(color: Config.color),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Config.screenPadding),
                        child: DropdownButton<String>(
                          hint: SizedBox(
                            width: 320.0,
                            child: Text(
                              dropdownValueNature2,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: Config.fontSize,
                                  color: Colors.black),
                            ),
                          ),
                          style: TextStyle(
                              fontSize: Config.fontSize, color: Colors.black),
                          items: <String>[
                            'B',
                            'FC',
                            'PVC',
                            'G',
                            'briques',
                            '???'
                          ].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: SizedBox(
                                width: 320.0,
                                child: Text(
                                  value,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: Config.fontSize,
                                      color: Colors.black),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValueNature2 = newValue;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: dropdownValueReference == 'fe3',
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(Config.screenPadding),
                        child: DropdownButton<String>(
                          hint: SizedBox(
                            width: 320.0,
                            child: Text(
                              dropdownValueRole3,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: Config.fontSize,
                                  color: Colors.black),
                            ),
                          ),
                          style: TextStyle(
                              fontSize: Config.fontSize, color: Colors.black),
                          items: <String>[
                            'grille',
                            'collecteur',
                            'branchement',
                            'avaloir',
                            'canalisation',
                            'déverse',
                            '???'
                          ].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: SizedBox(
                                width: 320.0,
                                child: Text(
                                  value,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: Config.fontSize,
                                      color: Colors.black),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValueRole3 = newValue;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Config.screenPadding),
                        child: DropdownButton<String>(
                          hint: SizedBox(
                            width: 320.0,
                            child: Text(
                              dropdownValueGeometrie3,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: Config.fontSize,
                                  color: Colors.black),
                            ),
                          ),
                          style: TextStyle(
                              fontSize: Config.fontSize, color: Colors.black),
                          items: <String>[
                            'circulaire',
                            'rectangulaire',
                            'voûte',
                            'ovoïde',
                            '???'
                          ].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: SizedBox(
                                width: 320.0,
                                child: Text(
                                  value,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: Config.fontSize,
                                      color: Colors.black),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValueGeometrie3 = newValue;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Config.screenPadding),
                        child: TextField(
                            controller: profondeurController3,
                            decoration: InputDecoration(
                              labelText: 'Profondeur',
                              labelStyle: TextStyle(color: Config.textColor),
                              focusColor: Config.color,
                              fillColor: Colors.white,
                              focusedBorder: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(color: Config.color),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Config.screenPadding),
                        child: DropdownButton<String>(
                          hint: SizedBox(
                            width: 320.0,
                            child: Text(
                              dropdownValueNature3,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: Config.fontSize,
                                  color: Colors.black),
                            ),
                          ),
                          style: TextStyle(
                              fontSize: Config.fontSize, color: Colors.black),
                          items: <String>[
                            'B',
                            'FC',
                            'PVC',
                            'G',
                            'briques',
                            '???'
                          ].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: SizedBox(
                                width: 320.0,
                                child: Text(
                                  value,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: Config.fontSize,
                                      color: Colors.black),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValueNature3 = newValue;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: dropdownValueReference == 'fe4',
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(Config.screenPadding),
                        child: DropdownButton<String>(
                          hint: SizedBox(
                            width: 320.0,
                            child: Text(
                              dropdownValueRole4,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: Config.fontSize,
                                  color: Colors.black),
                            ),
                          ),
                          style: TextStyle(
                              fontSize: Config.fontSize, color: Colors.black),
                          items: <String>[
                            'grille',
                            'collecteur',
                            'branchement',
                            'avaloir',
                            'canalisation',
                            'déverse',
                            '???'
                          ].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: SizedBox(
                                width: 320.0,
                                child: Text(
                                  value,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: Config.fontSize,
                                      color: Colors.black),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValueRole4 = newValue;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Config.screenPadding),
                        child: DropdownButton<String>(
                          hint: SizedBox(
                            width: 320.0,
                            child: Text(
                              dropdownValueGeometrie4,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: Config.fontSize,
                                  color: Colors.black),
                            ),
                          ),
                          style: TextStyle(
                              fontSize: Config.fontSize, color: Colors.black),
                          items: <String>[
                            'circulaire',
                            'rectangulaire',
                            'voûte',
                            'ovoïde',
                            '???'
                          ].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: SizedBox(
                                width: 320.0,
                                child: Text(
                                  value,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: Config.fontSize,
                                      color: Colors.black),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValueGeometrie4 = newValue;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Config.screenPadding),
                        child: TextField(
                            controller: profondeurController4,
                            decoration: InputDecoration(
                              labelText: 'Profondeur',
                              labelStyle: TextStyle(color: Config.textColor),
                              focusColor: Config.color,
                              fillColor: Colors.white,
                              focusedBorder: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(color: Config.color),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Config.screenPadding),
                        child: DropdownButton<String>(
                          hint: SizedBox(
                            width: 320.0,
                            child: Text(
                              dropdownValueNature4,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: Config.fontSize,
                                  color: Colors.black),
                            ),
                          ),
                          style: TextStyle(
                              fontSize: Config.fontSize, color: Colors.black),
                          items: <String>[
                            'B',
                            'FC',
                            'PVC',
                            'G',
                            'briques',
                            '???'
                          ].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: SizedBox(
                                width: 320.0,
                                child: Text(
                                  value,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: Config.fontSize,
                                      color: Colors.black),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValueNature4 = newValue;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: dropdownValueReference == 'fe5',
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(Config.screenPadding),
                        child: DropdownButton<String>(
                          hint: SizedBox(
                            width: 320.0,
                            child: Text(
                              dropdownValueRole5,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: Config.fontSize,
                                  color: Colors.black),
                            ),
                          ),
                          style: TextStyle(
                              fontSize: Config.fontSize, color: Colors.black),
                          items: <String>[
                            'grille',
                            'collecteur',
                            'branchement',
                            'avaloir',
                            'canalisation',
                            'déverse',
                            '???'
                          ].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: SizedBox(
                                width: 320.0,
                                child: Text(
                                  value,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: Config.fontSize,
                                      color: Colors.black),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValueRole5 = newValue;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Config.screenPadding),
                        child: DropdownButton<String>(
                          hint: SizedBox(
                            width: 320.0,
                            child: Text(
                              dropdownValueGeometrie5,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: Config.fontSize,
                                  color: Colors.black),
                            ),
                          ),
                          style: TextStyle(
                              fontSize: Config.fontSize, color: Colors.black),
                          items: <String>[
                            'circulaire',
                            'rectangulaire',
                            'voûte',
                            'ovoïde',
                            '???'
                          ].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: SizedBox(
                                width: 320.0,
                                child: Text(
                                  value,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: Config.fontSize,
                                      color: Colors.black),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValueGeometrie5 = newValue;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Config.screenPadding),
                        child: TextField(
                            controller: profondeurController5,
                            decoration: InputDecoration(
                              labelText: 'Profondeur',
                              labelStyle: TextStyle(color: Config.textColor),
                              focusColor: Config.color,
                              fillColor: Colors.white,
                              focusedBorder: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(color: Config.color),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Config.screenPadding),
                        child: DropdownButton<String>(
                          hint: SizedBox(
                            width: 320.0,
                            child: Text(
                              dropdownValueNature5,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: Config.fontSize,
                                  color: Colors.black),
                            ),
                          ),
                          style: TextStyle(
                              fontSize: Config.fontSize, color: Colors.black),
                          items: <String>[
                            'B',
                            'FC',
                            'PVC',
                            'G',
                            'briques',
                            '???'
                          ].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: SizedBox(
                                width: 320.0,
                                child: Text(
                                  value,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: Config.fontSize,
                                      color: Colors.black),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValueNature5 = newValue;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
