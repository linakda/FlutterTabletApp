import 'package:flutter/rendering.dart';
import 'package:geo_diagnostique_app/Affaire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geo_diagnostique_app/Config.dart';
import 'package:geo_diagnostique_app/Ouvrage.dart';
import 'package:geo_diagnostique_app/main.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'dart:math' as Math;

class LandingScreen extends StatefulWidget {
  final Ouvrage selectedOuvrage;
  final NumeroAffaire selectNumeroAffaire;
  LandingScreen(this.selectedOuvrage, this.selectNumeroAffaire);
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  File imageFile;
  List<int> selectedArrow = List.filled(6, -1);
  String dropdownValueReference = "fs";
  int selectedOutput = 0;
  List<String> listOutput = ['fs', 'fe1', 'fe2', 'fe3', 'fe4', 'fe5'];
  List<bool> showArrows = List.filled(12, false);
  List<bool> isPipeExisting = [true, false, false, false, false, false];
  List<List<List<TextEditingController>>> listController = [
    [new List(7)],
    [new List(7)],
    [new List(7)],
    [new List(7)],
    [new List(7)],
    [new List(7)],
  ];
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
  @override
  void initState() {
    super.initState();
    loadExistingImage();
    for (int i = 0; i < listController.length; i++) {
      for (int j = 0; j < listController[i].length; j++) {
        for (int k = 0; k < listController[i][j].length; k++) {
          listController[i][j][k] = new TextEditingController();
          if ([0, 1, 3].contains(k))
            listController[i][j][k].text = "Séléctionner";
          else
            listController[i][j][k].text = "";
        }
      }
    }

    //Parcours chaque entrée/sortie (Les 6 : de fs à fe5)
    for (int i = 0; i < listController.length; i++) {
      setControllerList(widget.selectedOuvrage.listCanalisation[i].role, 0, i);
      setControllerList(
          widget.selectedOuvrage.listCanalisation[i].geometrie, 1, i);
      setControllerList(
          widget.selectedOuvrage.listCanalisation[i].dimension, 2, i);
      setControllerList(
          widget.selectedOuvrage.listCanalisation[i].nature, 3, i);
      setControllerList(
          widget.selectedOuvrage.listCanalisation[i].profondeur, 4, i);
      setControllerList(widget.selectedOuvrage.listCanalisation[i].angle, 5, i);
      setControllerList(
          widget.selectedOuvrage.listCanalisation[i].observations, 6, i);
    }

    for (int i = 0; i < widget.selectedOuvrage.listCanalisation.length; i++) {
      String angle = widget.selectedOuvrage.listCanalisation[i].angle;
      int positionArrow = convertAngle.indexOf(angle);
      selectedArrow[i] = positionArrow;
      if (positionArrow != -1) {
        showArrows[positionArrow] = true;
        nameOutput[positionArrow] = listOutput[i];
      }
    }
  }

  //initialisation des controller avec valeurs csv si existantes
  void setControllerList(
      String caracteristique, int indexCaracteristique, int indexPipe) {
    //Retourne le nombre de pipe par entrée/sorties
    List<String> listCaracteristique = caracteristique.split("£");
    //length représente le nombre de sous tuyaux
    if(listController[indexPipe].length < listCaracteristique.length){
      for(int j=1;j<listCaracteristique.length;j++){
        addNewController(indexPipe);
        }
    }
    for (var i = 0; i < listCaracteristique.length; i++) {
      if (caracteristique != "") {
        isPipeExisting[indexPipe] = true;
        listController[indexPipe][i][indexCaracteristique].text =
            listCaracteristique[i];
      }
    }
  }

  //Ouvre l'image si existante au démarrage
  void loadExistingImage() async {
    if (widget.selectedOuvrage.photoOuvrage != "" &&
        await Directory(picturesDir.path +
                '/' +
                widget.selectNumeroAffaire.numeroAffaire)
            .exists()) {
      setState(() {
        imageFile = new File(picturesDir.path +
            '/' +
            widget.selectNumeroAffaire.numeroAffaire +
            '/' +
            widget.selectedOuvrage.photoOuvrage);
      });
    }
  }

  //Ouverture camera
  _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(
      source: ImageSource.camera,
    );
    Navigator.of(context).pop();

    _saveImage(picture, true);
  }

  //Ouverture gallerie
  void _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    Navigator.of(context).pop();

    _saveImage(picture, false);
  } //opengallery

  //Sauvegarde de l'image
  Future _saveImage(File picture, bool isFromCamera) async {
    imageCache.clear();
    Directory newdir = new Directory(
        picturesDir.path + '/' + widget.selectNumeroAffaire.numeroAffaire);
    newdir.createSync();

    if (await picture.exists()) {
      File tmp = await picture
          .copy(newdir.path + '/' + widget.selectedOuvrage.refOuvrage + '.png');
      imageFile = new File(tmp.path);
      picture.deleteSync();
      widget.selectedOuvrage.photoOuvrage =
          widget.selectedOuvrage.refOuvrage + '.png';
    }
  }

  //Zone clickable avec photo, boutons,etc....
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
    for (var i = 0; i < 12; i++) {
      clickableSchema.add(Positioned(
        top: dotCenter -
            radius * Math.sin((i - 1) * Math.pi / 6 + Math.pi / 2) -
            12,
        left: dotCenter +
            radius * Math.cos((i - 1) * Math.pi / 6 + Math.pi / 2) -
            12,
        child: InkWell(
          child: RotationTransition(
            turns: AlwaysStoppedAnimation(selectedArrow[0] != i
                ? -(i + 8) * 30 / 360
                : -(i - 10) * 30 / 360),
            child: Container(
                height: Config.screenWidth / 20,
                width: Config.screenWidth / 20,
                child: showArrows[i]
                    ? Image.asset('assets/fleche.png', fit: BoxFit.fill)
                    : Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Config.buttonColor))),
          ),
          onTap: () {
            setState(() {
              if (!showArrows[i]) {
                if (selectedArrow[selectedOutput] != -1) {
                  showArrows[selectedArrow[selectedOutput]] = false;
                  nameOutput[selectedArrow[selectedOutput]] = "";
                  selectedArrow[selectedOutput] = -1;
                }
                selectedArrow[selectedOutput] = i;
                showArrows[selectedArrow[selectedOutput]] = true;
                nameOutput[selectedArrow[selectedOutput]] =
                    dropdownValueReference;
                widget.selectedOuvrage.listCanalisation[selectedOutput].angle =
                    convertAngle[selectedArrow[selectedOutput]];
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
          child: showArrows[i]
              ? Container(
                  height: Config.fontSize * 1.5,
                  width: Config.fontSize * 1.5,
                  alignment: FractionalOffset.center,
                  child: Text(
                    nameOutput[i],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Config.color, fontSize: Config.fontSize / 1.5),
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(width: 2.0, color: Config.color),
                      shape: BoxShape.circle,
                      color: Colors.white))
              : Container()));
    }
    return clickableSchema;
  }

  //Dialogue pour le choix de la prise de la photo (soit en gallerie, soit l'appareil photo)
  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Choisissez",
              textAlign: TextAlign.center,
            ),
            content: SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    child: Column(
                      children: <Widget>[
                        Stack(children: <Widget>[
                          Positioned(
                            left: 2.0,
                            top: 2.0,
                            child: Icon(
                              Icons.photo_library,
                              color: Colors.black26,
                              size: Config.fontSize * 3
                              ),
                          ),
                          Icon(
                            Icons.photo_library,
                            color: Config.splashColor,
                            size: Config.fontSize * 3,
                          ),
                        ]),
                        Text("Galerie")
                      ],
                    ),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  InkWell(
                    child: Column(
                      children: <Widget>[
                        Stack(children: <Widget>[
                          Positioned(
                            left: 2.0,
                            top: 3.0,
                            child: Icon(
                              Icons.photo_camera,
                              color: Colors.black26,
                              size: Config.fontSize * 3
                              ),
                          ),
                          Icon(
                            Icons.photo_camera,
                            color: Config.splashColor,
                            size: Config.fontSize * 3,
                          ),
                        ]),
                        Text("Camera")
                      ],
                    ),
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

  //Ajoute un tuyau supplémentaire
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
                keyboardType: TextInputType.number,
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
                keyboardType: TextInputType.number,
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

  //Concaténation de multiples sorties
  String compteur(int i, int k) {
    String tmp = listController[i][0][k].text;
    for (int j = 1; j < listController[i].length; j++) {
      if(listController[i][j][k].text!="Sélectionner")
        tmp += '£' + listController[i][j][k].text;
    }
    return tmp;
  }

  //Selection de la sortie pour affichage dans DropDownMenu
  List<String> output(List<bool> select) {
    List<String> ret = [];
    for (int i = 0; i < select.length; i++) {
      if (select[i]) {
        ret.add(listOutput[i]);
      }
    }
    return ret;
  }

  void addNewController(int index) {
    List<TextEditingController> listtmp = new List(7);
    for (int k = 0; k < 7; k++) {
      listtmp[k] = new TextEditingController();
      if ([0, 1, 3].contains(k))
        listtmp[k].text = "Séléctionner";
      else
        listtmp[k].text = "";
    }
    listController[index].add(listtmp);
  }

  void resetController() {
    setState(() {
      widget.selectedOuvrage.resetOuvrage();
      for (int i = 0; i < listController.length; i++) {
        if (i != 0) isPipeExisting[i] = false;
        listController[i].clear();
        addNewController(i);
      }
      selectedOutput = 0;
      showArrows = new List.filled(12, false);
      selectedArrow = new List.filled(6, -1);
      nameOutput = new List.filled(12, "");
    });
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
                      child: Center(
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
                                  fontSize: Config.fontSize,
                                  color: Colors.black),
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
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        FlatButton(
                          color: Colors.grey,
                          onPressed: () {
                            if (isPipeExisting.contains(false)) {
                              setState(() {
                                int i = 0;
                                while (isPipeExisting[i]) {
                                  i++;
                                }
                                isPipeExisting[i] = true;
                              });
                            }
                          },
                          child: Text("Ajouter une entrée"),
                        ),
                        FlatButton(
                          color: Colors.red,
                          onPressed: () {
                            setState(() {
                              resetController();
                            });
                          },
                          child: Text("Tout Supprimer"),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(Config.screenPadding),
                      child: addSuperposedPipe(selectedOutput),
                    ),
                    Padding(
                      padding: EdgeInsets.all(Config.screenPadding),
                      child: FlatButton(
                        onPressed: () {
                          setState(() {
                            addNewController(selectedOutput);
                          });
                        },
                        child: Text("ajouter tuyau superposé"),
                        color: Colors.grey,
                      ),
                    ),
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
