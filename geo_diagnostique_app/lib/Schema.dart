import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:geo_diagnostique_app/Affaire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geo_diagnostique_app/Config.dart';
import 'package:geo_diagnostique_app/Ouvrage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'dart:math' as Math;
import 'package:path/path.dart' as p;

class LandingScreen extends StatefulWidget {
  final Ouvrage selectedOuvrage;
  final NumeroAffaire selectNumeroAffaire;
  LandingScreen(this.selectedOuvrage, this.selectNumeroAffaire);
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  Image image;
  File imageFile;
  List<int> selectedArrow = [-1, -1, -1, -1, -1, -1];
  String _imageString = "";
  String dropdownValueReference = "fs";
  int selectedOutput = 0;
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
  TextEditingController test = TextEditingController();
  String testpath = "test";
  List<String> listOutput = ['fs', 'fe1', 'fe2', 'fe3', 'fe4', 'fe5'];
  List<bool> affArrow = [
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
  List<bool> existenceThread = [true, false, false, false, false, false];
  List<List<List<TextEditingController>>> listController = [
    [new List(6)],
    [new List(6)],
    [new List(6)],
    [new List(6)],
    [new List(6)],
    [new List(6)]
  ];
  List<String> nameOutput = ["", "", "", "", "", "", "", "", "", "", "", ""];
  List<String> convertAngle = [
    "0",
    "330",
    "300",
    "270",
    "240",
    "210",
    "180",
    "150",
    "120",
    "90",
    "60",
    "30"
  ];

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    Navigator.of(context).pop();
    setState(() {
      String dir = p.dirname(picture.path);
      Directory newdir =
          new Directory(dir + '/' + widget.selectNumeroAffaire.numeroAffaire);
      newdir.createSync();
      File picture1 = picture.renameSync(
          newdir.path + '/' + widget.selectedOuvrage.refOuvrage + '.png');
      imageFile = picture1;
    });
  } //opencamera

  _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    Navigator.of(context).pop();
    setState(() {
      image = Image.file(imageFile);
      String dir = p.dirname(picture.path);
      Directory newdir =
          new Directory(dir + '/' + widget.selectNumeroAffaire.numeroAffaire);
      newdir.createSync();
      File previous =
          File(newdir.path + '/' + widget.selectedOuvrage.refOuvrage + '.png');
      previous.deleteSync();
      File picture1 = picture.renameSync(
          newdir.path + '/' + widget.selectedOuvrage.refOuvrage + '.png');
      imageFile = picture1;
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
      return Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: ExactAssetImage(stringImg), fit: BoxFit.cover)),
          child: Image.file(imageFile));
      //child: Image.memory(base64.decode(stringImg)));
    } else {
      return Container(
        //color: Colors.grey,
        padding: EdgeInsets.all(Config.screenPadding * 8),
      );
    }
  }

  List<Positioned> _cliclableArrayGenerator() {
    List<Positioned> clickableSchema = new List<Positioned>();
    double schemSize = Config.screenWidth < Config.screenHeight
        ? Config.screenWidth / 1.5
        : Config.screenHeight / 1.5;
    double dotCenter = 1.02 * schemSize / 2 - 30;
    double radius = 1.01 * schemSize / 2 - 60;
    clickableSchema.add(
      Positioned(
          child: Container(
        height: schemSize,
        width: schemSize,
        child: imageFile != null
            ? Image.file(imageFile, fit: BoxFit.cover) //fill;cover;scaledown
            : Padding(padding: EdgeInsets.all(1)),
      )),
    );
    for (var i = 0; i < 13; i++) {
      if (i == 0) {
        clickableSchema.add(
          Positioned(
            child: Container(
              height: schemSize,
              width: schemSize,
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.blue, width: 3, style: BorderStyle.solid),
                image: DecorationImage(
                  image: AssetImage('assets/cercle1.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        );
        clickableSchema.add(
          Positioned(
              child: InkWell(
            child: Container(
                width: schemSize,
                height: schemSize,
                child: imageFile == null
                    ? Icon(
                        Icons.add_a_photo,
                        size: schemSize / 5,
                      )
                    : Padding(
                        padding: EdgeInsets.all(8.0),
                      ),
                alignment: Alignment.center),
            onTap: () {
              _showChoiceDialog(context);
            },
          )),
        );
      } else {
        clickableSchema.add(Positioned(
          top: dotCenter -
              radius * Math.sin((i - 1) * Math.pi / 6 + Math.pi / 2) -
              12,
          left: dotCenter +
              radius * Math.cos((i - 1) * Math.pi / 6 + Math.pi / 2) -
              12,
          child: InkWell(
            child: RotationTransition(
              turns: AlwaysStoppedAnimation(
                  i != 1 ? -(i + 8) * 30 / 360 : -(i - 10) * 30 / 360),
              child: Container(
                height: Config.screenWidth / 20,
                width: Config.screenWidth / 20,
                child: affArrow[i - 1]
                    ? Image.asset('assets/Image2.png', fit: BoxFit.fill)
                    : Image.asset('assets/fleche.png', fit: BoxFit.fill),
              ),
            ),
            onTap: () {
              setState(() {
                if (affArrow[i - 1]) {
                  if (selectedArrow[selectedOutput] != -1) {
                    affArrow[selectedArrow[selectedOutput]] = true;
                    nameOutput[selectedArrow[selectedOutput]] = "";
                    selectedArrow[selectedOutput] = -1;
                  }
                  selectedArrow[selectedOutput] = i - 1;
                  affArrow[selectedArrow[selectedOutput]] = false;
                  nameOutput[selectedArrow[selectedOutput]] =
                      dropdownValueReference;
                  widget.selectedOuvrage.listCanalisation[selectedOutput]
                      .angle = convertAngle[selectedArrow[selectedOutput]];
                }
              });
            },
          ),
        ));
        clickableSchema.add(Positioned(
            top: dotCenter +
                30 -
                (radius + 15) * Math.sin((i - 1) * Math.pi / 6 + Math.pi / 2) -
                12,
            left: dotCenter +
                32 +
                (radius + 15) * Math.cos((i - 1) * Math.pi / 6 + Math.pi / 2) -
                12,
            child: RotationTransition(
                turns: AlwaysStoppedAnimation(i == 1
                    ? 270 / 360
                    : i < 8 ? -(i + 8) * 30 / 360 : -(i - 6 + 8) * 30 / 360),
                child: Text(nameOutput[i - 1],
                    style: TextStyle(color: Colors.white)))));
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

  Widget showCanalisations(int i) {
    List<Widget> colum = [];
    for (int j = 0; j < listController[i].length; j++) {
      colum.add(showCanalisation(i, j));
    }
    return new Column(
      children: colum,
    );
  }

  Widget showCanalisation(int i, int j) {
    List<Widget> colum = [];
    colum.add(Divider(
      thickness: 2,
      color: Colors.black,
    ));
    colum.add(
      Row(
        children: <Widget>[
          Text("Rôle : "),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(Config.screenPadding / 2),
              child: DropdownButton<String>(
                hint: SizedBox(
                  width: 320.0,
                  child: Text(
                    listController[i][j][0].text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: Config.fontSize, color: Colors.black),
                  ),
                ),
                style:
                    TextStyle(fontSize: Config.fontSize, color: Colors.black),
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
                            fontSize: Config.fontSize, color: Colors.black),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String newValue) {
                  setState(() {
                    listController[i][j][0].text = newValue;
                    widget.selectedOuvrage.listCanalisation[i].role =
                        compteur(i, 0);
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
    colum.add(
      Row(children: <Widget>[
        Text("Géométrie : "),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(Config.screenPadding / 2),
            child: DropdownButton<String>(
              hint: SizedBox(
                width: 320.0,
                child: Text(
                  listController[i][j][1].text,
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: Config.fontSize, color: Colors.black),
                ),
              ),
              style: TextStyle(fontSize: Config.fontSize, color: Colors.black),
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
                          fontSize: Config.fontSize, color: Colors.black),
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String newValue) {
                setState(() {
                  listController[i][j][1].text = newValue;
                  widget.selectedOuvrage.listCanalisation[i].geometrie =
                      compteur(i, 1);
                });
              },
            ),
          ),
        ),
      ]),
    );
    colum.add(
      Row(
        children: <Widget>[
          Text("Dimensions : "),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(Config.screenPadding / 2),
              child: TextField(
                controller: listController[i][j][2],
                decoration: InputDecoration(
                  labelText: 'Dimensions',
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
                ),
                onChanged: (String text) {
                  setState(() {
                    widget.selectedOuvrage.listCanalisation[i].dimension =
                        compteur(i, 2);
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
    colum.add(
      Row(
        children: <Widget>[
          Text("Nature : "),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(Config.screenPadding / 2),
              child: DropdownButton<String>(
                hint: SizedBox(
                  width: 320.0,
                  child: Text(
                    listController[i][j][3].text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: Config.fontSize, color: Colors.black),
                  ),
                ),
                style:
                    TextStyle(fontSize: Config.fontSize, color: Colors.black),
                items: <String>['B', 'FC', 'PVC', 'G', 'briques', '???']
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
                    listController[i][j][3].text = newValue;
                    widget.selectedOuvrage.listCanalisation[i].nature =
                        compteur(i, 3);
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
    colum.add(
      Row(
        children: <Widget>[
          Text("Profondeur : "),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(Config.screenPadding / 2),
              child: TextField(
                controller: listController[i][j][4],
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
                ),
                onChanged: (String text) {
                  setState(() {
                    widget.selectedOuvrage.listCanalisation[i].profondeur =
                        compteur(i, 4);
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
    colum.add(
      Row(
        children: <Widget>[
          Text("Observation : "),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(Config.screenPadding / 2),
              child: TextField(
                controller: listController[i][j][5],
                decoration: InputDecoration(
                  labelText: 'Observation',
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
                ),
                onChanged: (String text) {
                  setState(() {
                    widget.selectedOuvrage.listCanalisation[i].observations =
                        compteur(i, 5);
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
    return new Column(
      children: colum,
    );
  }

  String compteur(int i, int k) {
    String tmp = listController[i][0][k].text;
    for (int j = 1; j < listController[i].length; j++) {
      tmp += '£' + listController[i][j][k].text;
    }
    return tmp;
  }

  List<String> output(List<bool> select) {
    List<String> ret = [];
    for (int i = 0; i < select.length; i++) {
      if (select[i]) {
        ret.add(listOutput[i]);
      }
    }
    return ret;
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < listController.length; i++) {
      int loop = 0;
      var target = widget.selectedOuvrage.listCanalisation[i].role != null
          ? widget.selectedOuvrage.listCanalisation[i].role
          : " ";
      for (int c = 0; c < target.length; c++) {
        if (target[c] == '£') {
          loop++;
        }
      }
      widget.selectedOuvrage.listCanalisation[0].role.length;
      for (int n = 0; n < loop; n++) {
        listController[i].add(new List(6));
      }
    }
    for (int i = 0; i < listController.length; i++) {
      for (int j = 0; j < listController[i].length; j++) {
        for (int k = 0; k < listController[i][j].length; k++) {
          listController[i][j][k] = new TextEditingController();
        }
      }
    }
    for (int i = 0; i < listController.length; i++) {
      List<String> listRole =
          widget.selectedOuvrage.listCanalisation[i].role.split("£");
      List<String> listGeometrie =
          widget.selectedOuvrage.listCanalisation[i].geometrie.split("£");
      List<String> listDimension =
          widget.selectedOuvrage.listCanalisation[i].dimension.split("£");
      List<String> listNature =
          widget.selectedOuvrage.listCanalisation[i].nature.split("£");
      List<String> listProfondeur =
          widget.selectedOuvrage.listCanalisation[i].profondeur.split("£");
      List<String> listObservation =
          widget.selectedOuvrage.listCanalisation[i].observations.split("£");
      for (int j = 0; j < listController[i].length; j++) {
        listController[i][j][0].text = "Sélectionner";
        print(j);
        print(listRole[j]);
        if (listRole[j] != "") listController[i][j][0].text = listRole[j];
        listController[i][j][1].text = "Sélectionner";
        print(listGeometrie[j]);
        if (listGeometrie[j] != "") listController[i][j][1].text = listGeometrie[j];
        listController[i][j][2].text = "";
        print(listDimension[j]);
        if (listDimension[j] != "")
          listController[i][j][2].text = listDimension[j];
        listController[i][j][3].text = "Sélectionner";
        if (listNature[j] != "") listController[i][j][3].text = listNature[j];
        listController[i][j][4].text = "";
        if (listProfondeur[j] != "")
          listController[i][j][4].text = listProfondeur[j];
        listController[i][j][5].text = "";
        if (listObservation[j] != "")
          listController[i][j][5].text = listObservation[j];
      }
    }
    for (int i = 0; i < widget.selectedOuvrage.listCanalisation.length; i++) {
      int arrow = convertAngle
          .indexOf(widget.selectedOuvrage.listCanalisation[i].angle);
      if (arrow != -1) {
        selectedArrow[i] = arrow;
        affArrow[i] = false;
        print("i" + i.toString());
        print("arrow" + arrow.toString());
        nameOutput[arrow] = listOutput[i];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => Center(
          child: Row(
            children: <Widget>[
              Container(
                height: Config.screenHeight - 150,
                width: Config.screenWidth / 2,
                child: Stack(
                  children: _cliclableArrayGenerator(),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(Config.screenPadding / 2),
                      child: Row(
                        children: <Widget>[
                          DropdownButton<String>(
                            hint: SizedBox(
                              width: Config.screenWidth / 4,
                              child: Text(
                                dropdownValueReference,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: Config.fontSize,
                                    color: Colors.black),
                              ),
                            ),
                            style: TextStyle(
                                fontSize: Config.fontSize, color: Colors.black),
                            items: output(existenceThread).map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: SizedBox(
                                  width: 160.0,
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
                                dropdownValueReference = newValue;
                                selectedOutput = listOutput.indexOf(newValue);
                              });
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.all(Config.screenPadding),
                            child: FlatButton(
                              onPressed: () {
                                setState(() {
                                  listController[selectedOutput]
                                      .add(new List(6));
                                  listController[selectedOutput][
                                      listController[selectedOutput].length -
                                          1][0] = new TextEditingController(
                                      text: "Sélectionner");
                                  listController[selectedOutput][
                                      listController[selectedOutput].length -
                                          1][1] = new TextEditingController(
                                      text: "Sélectionner");
                                  listController[selectedOutput][
                                      listController[selectedOutput].length -
                                          1][3] = new TextEditingController(
                                      text: "Sélectionner");
                                  widget
                                      .selectedOuvrage
                                      .listCanalisation[selectedOutput]
                                      .role = compteur(selectedOutput, 0);
                                  widget
                                      .selectedOuvrage
                                      .listCanalisation[selectedOutput]
                                      .geometrie = compteur(selectedOutput, 1);
                                  widget
                                      .selectedOuvrage
                                      .listCanalisation[selectedOutput]
                                      .dimension = compteur(selectedOutput, 2);
                                  widget
                                      .selectedOuvrage
                                      .listCanalisation[selectedOutput]
                                      .nature = compteur(selectedOutput, 3);
                                  widget
                                      .selectedOuvrage
                                      .listCanalisation[selectedOutput]
                                      .profondeur = compteur(selectedOutput, 4);
                                  widget
                                          .selectedOuvrage
                                          .listCanalisation[selectedOutput]
                                          .observations =
                                      compteur(selectedOutput, 5);
                                });
                              },
                              child: Text("+1"),
                              color: Colors.grey,
                            ),
                          ),
                          FlatButton(
                            color: Colors.grey,
                            onPressed: () {
                              setState(() {
                                int i = 0;
                                while (existenceThread[i]) {
                                  i++;
                                }
                                existenceThread[i] = true;
                              });
                            },
                            child: Text("+1 fe"),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(Config.screenPadding),
                      child: showCanalisations(selectedOutput),
                    )
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
