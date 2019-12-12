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
  List<int> selectedArrow = List.filled(6, -1);
  String _imageString = "";
  String dropdownValueReference = "fs";
  int selectedOutput = 0;
  List<String> listOutput = ['fs', 'fe1', 'fe2', 'fe3', 'fe4', 'fe5'];
  List<bool> notShowArrow = List.filled(12, true);
  List<bool> isPipeExisting = [true, false, false, false, false, false];
  List<List<List<TextEditingController>>> listController = List.filled(6, new List.filled(1,new List(7),growable: true));
  List<String> nameOutput = List.filled(12, "");
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

//Open camera
  _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    Navigator.of(context).pop();
    setState(() {
      _saveImage(picture, true);
    });
  }

  void _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    Navigator.of(context).pop();
    setState(() {
      image = Image.file(imageFile);
      _saveImage(picture, false);
    });
  } //opengallery

  void _saveImage(File picture,bool isFromCamera){
    String dir = p.dirname(picture.path);
    Directory newdir = new Directory(dir + '/' + widget.selectNumeroAffaire.numeroAffaire);
    newdir.createSync();
    if(isFromCamera){
      File picture1 = picture.renameSync(
          newdir.path + '/' + widget.selectedOuvrage.refOuvrage + '.png');
      imageFile = picture1;
    }
    else{
      File previous =
          File(newdir.path + '/' + widget.selectedOuvrage.refOuvrage + '.png');
      previous.deleteSync();
      File picture1 = picture.renameSync(
          newdir.path + '/' + widget.selectedOuvrage.refOuvrage + '.png');
      imageFile = picture1;
    }
  }

  String setImage() {
    if (imageFile != null) {
      _imageString = base64.encode(imageFile.readAsBytesSync());
      return _imageString;
    } else
      return "";
  }

//Afficher l'image
  Widget showImage(String stringImg) {
    if (stringImg != "") {
      return Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: ExactAssetImage(stringImg), fit: BoxFit.cover)),
          child: Image.file(imageFile));
    } else {
      return Container(
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
            ? Image.file(imageFile, fit: BoxFit.cover)
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
                child: notShowArrow[i - 1]
                    ? Image.asset('assets/Image2.png', fit: BoxFit.fill)
                    : Image.asset('assets/fleche.png', fit: BoxFit.fill),
              ),
            ),
            onTap: () {
              setState(() {
                if (notShowArrow[i - 1]) {
                  if (selectedArrow[selectedOutput] != -1) {
                    notShowArrow[selectedArrow[selectedOutput]] = true;
                    nameOutput[selectedArrow[selectedOutput]] = "";
                    selectedArrow[selectedOutput] = -1;
                  }
                  selectedArrow[selectedOutput] = i - 1;
                  notShowArrow[selectedArrow[selectedOutput]] = false;
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
                    style: TextStyle(color: Colors.blue)))));
      }
    }
    return clickableSchema;
  }

  //Dialogue pour le choix de la prise de la photo (soit en gallerie, soit l'appareil photo)
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

  Widget addSuperposedPipe(int i) {
    List<Widget> colum = [];
    for (int j = 0; j < listController[i].length; j++) {
      colum.add(showCanalisation(i, j));
    }
    return new Column(
      children: colum,
    );
  }
  
  //ajoute les éléments d'éditions, multiple si sorties superposées
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
  void setControllerList(String caracteristique,int indexCaracteristique, int indexPipe ){
    //Retourne le nombre de pipe par entrée/sorties
    List<String> listCaracteristique = caracteristique.split("£");
    //length représente le nombre de sous tuyaux
    for(var i=0;i<listCaracteristique.length;i++){
      listController[indexPipe][i][indexCaracteristique].text=listCaracteristique[i];
    }
  }
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < listController.length; i++) {
      for (int j = 0; j < listController[i].length; j++) {
        for (int k = 0; k < listController[i][j].length; k++) {
          listController[i][j][k] = new TextEditingController();
          if([0,1,3].contains(k)) listController[i][j][k].text = "Séléctionner";
          else listController[i][j][k].text = "";
        }
      }
    }

    //Parcours chaque entrée/sortie (Les 6 : de fs à fe5)
    for (int i = 0; i < listController.length; i++) {
      setControllerList(widget.selectedOuvrage.listCanalisation[i].role, 0, i);
      setControllerList(widget.selectedOuvrage.listCanalisation[i].geometrie, 1, i);
      setControllerList(widget.selectedOuvrage.listCanalisation[i].dimension, 2, i);
      setControllerList(widget.selectedOuvrage.listCanalisation[i].nature, 3, i);
      setControllerList(widget.selectedOuvrage.listCanalisation[i].profondeur, 4, i);
      setControllerList(widget.selectedOuvrage.listCanalisation[i].angle, 5, i);
      setControllerList(widget.selectedOuvrage.listCanalisation[i].observations, 6, i);
    }
    for (int i = 0; i < widget.selectedOuvrage.listCanalisation.length; i++) {
      int arrow = convertAngle
          .indexOf(widget.selectedOuvrage.listCanalisation[i].angle);
      if (arrow != -1) {
        selectedArrow[i] = arrow;
        notShowArrow[i] = false;
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
                            items: output(isPipeExisting).map((String value) {
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
                                while (isPipeExisting[i]) {
                                  i++;
                                }
                                isPipeExisting[i] = true;
                              });
                            },
                            child: Text("+1 fe"),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(Config.screenPadding),
                      child: addSuperposedPipe(selectedOutput),
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
