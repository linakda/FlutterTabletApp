import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:geo_diagnostique_app/Ouvrage.dart';
import 'package:geo_diagnostique_app/Config.dart';

class Caractere extends StatefulWidget {
  final Ouvrage selectedOuvrage;
  Caractere(this.selectedOuvrage);
  @override
  CaractereState createState() => CaractereState();
}

class CaractereState extends State<Caractere> {
  TextStyle textStyle =
      new TextStyle(fontSize: Config.fontSize, fontWeight: FontWeight.bold);
  List<TextEditingController> controllerList = new List(14);
  /*
   * controller :
   *  0 -> type list (1)
   *  1 -> type text (1)
   *  2 -> observation text (2)
   *  3 -> dispositif fermeture list (3)
   *  4 -> dispositif fermeture text (3)
   *  5 -> section cheminé text (4)
   *  6 -> nature cheminé list (5)
   *  7 -> nature cheminé text (5)
   *  8 -> dimension text (6)
   *  11 -> dimension text (6) si rectangulaire
   *  9 -> dispositif acces list (7)
   *  10 -> cunette  (8)
   *  12 -> profondeur cunnette (9)
   *  13 -> côte tn (10)
   */
  String getElement(
    int index,
  ) {
    switch (index) {
      case 1:
        return widget.selectedOuvrage.type;
        break;
      case 2:
        return widget.selectedOuvrage.observationCaracteristiques;
        break;
      case 3:
        return widget.selectedOuvrage.dispositifFermeture;
        break;
      case 4:
        return widget.selectedOuvrage.section;
        break;
      case 5:
        return widget.selectedOuvrage.nature;
        break;
      case 6:
        return widget.selectedOuvrage.dimension;
        break;
      case 7:
        return widget.selectedOuvrage.dispositifAcces;
        break;
      case 8:
        return widget.selectedOuvrage.cunette;
        break;
      case 9:
        return widget.selectedOuvrage.profondeurRadier;
        break;
      case 10:
       return widget.selectedOuvrage.coteTN;
       break;
      default:
        return null;
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < controllerList.length; i++) {
      controllerList[i] = new TextEditingController();
    }
    controllerList[0].text = "Sélectionner";
    controllerList[3].text = "Sélectionner";
    controllerList[5].text = "Sélectionner";
    controllerList[6].text = "Sélectionner";
    controllerList[9].text = "Sélectionner";
    controllerList[10].text = "Sélectionner";
    editControllerlist(<String>[
      'regard',
      'regard avaloir',
      'avaloir',
      'grille',
      'boîte de branchement',
      ''
    ], 0, 1, 1);
    if (getElement(2) != "") controllerList[2].text = getElement(2);
    editControllerlist(<String>['fonte', 'béton', ''], 3, 4, 3);
    if (getElement(4) != "") controllerList[5].text = getElement(4);
    editControllerlist(
        <String>['préfabriquée', 'maçonnée', 'PVC', ''], 6, 7, 5);
    if (getElement(6) != "") {
      if (testDimensionFormat().length == 1)
        controllerList[8].text = getElement(6);
      else {
        controllerList[8].text = testDimensionFormat()[0];
        controllerList[11].text = testDimensionFormat()[1];
      }
    }
    if (getElement(7) != "") controllerList[9].text = getElement(7);
    if (getElement(8) != "") controllerList[10].text = getElement(8);
    if(getElement(9)!="") controllerList[12].text = getElement(9);
    if(getElement(10)!="") controllerList[13].text = getElement(10);
  }

  void editControllerlist(List<String> list, int indexController1,
      int indexController2, int indexParameter) {
    if (list.indexOf(getElement(indexParameter)) == -1) {
      controllerList[indexController1].text = 'autre : ';
      controllerList[indexController2].text = getElement(indexParameter);
    } else if (getElement(indexParameter) != '')
      controllerList[indexController1].text = getElement(indexParameter);
  }

  void setElement(int index, String value) {
    switch (index) {
      case 1:
        widget.selectedOuvrage.type = value;
        break;
      case 2:
        widget.selectedOuvrage.observationCaracteristiques = value;
        break;
      case 3:
        widget.selectedOuvrage.dispositifFermeture = value;
        break;
      case 4:
        widget.selectedOuvrage.section = value;
        break;
      case 5:
        widget.selectedOuvrage.nature = value;
        break;
      case 6:
        widget.selectedOuvrage.dimension = value;
        break;
      case 7:
        widget.selectedOuvrage.dispositifAcces = value;
        break;
      case 8:
        widget.selectedOuvrage.cunette = value;
        break;
      case 9:
        widget.selectedOuvrage.profondeurRadier=value;
        break;
      case 10:
        widget.selectedOuvrage.coteTN=value;
        break;
      default:
        break;
    }
  }

  Padding dropDownList(
      int indexController, int indexParameter, List<String> list) {
    return Padding(
      padding: EdgeInsets.all(Config.screenPadding),
      child: DropdownButton<String>(
          hint: SizedBox(
            width: controllerList[indexController].text == "autre : "
                ? Config.screenWidth / 4
                : Config.screenWidth / 2,
            child: Text(
              controllerList[indexController].text,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: Config.fontSize, color: Colors.black),
            ),
          ),
          style: TextStyle(fontSize: Config.fontSize, color: Colors.black),
          items: list.map((String value) {
            return new DropdownMenuItem<String>(
              child: SizedBox(
                width: controllerList[indexController].text == "autre : "
                    ? Config.screenWidth / 4
                    : Config.screenWidth / 2,
                child: Text(
                  value,
                  textAlign: TextAlign.left,
                ),
              ),
              value: value,
            );
          }).toList(),
          onChanged: (String newValue) {
            setState(() {
              controllerList[indexController].text = newValue;
              if (controllerList[indexController].text != 'autre : ')
                setElement(indexParameter, newValue);
            });
          }),
    );
  }

  Expanded expandedTextField(
      int indexController, int indexParameter, String labelText) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(Config.screenPadding),
        child: TextField(
          controller: controllerList[indexController],
          keyboardType: <int>[11,8,12,13].contains(indexController)
              ? TextInputType.number
              : TextInputType.text,
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            labelText: labelText,
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
              if (indexController == 11)
                setElement(indexParameter, controllerList[8].text + ':' + text);
              else
                setElement(indexParameter, text);
            });
          },
        ),
      ),
    );
  }

  List<String> testDimensionFormat() {
    String value = getElement(6);
    return value.split(":");
  }

  Widget build(BuildContext context) {
    Config().init(context);
    return new Scaffold(
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(Config.screenPadding),
            child: Center(
              child: Column(
                children: [
                  Row(
                    children: <Widget>[
                      Text("Type :", style: textStyle),
                      dropDownList(
                        0,
                        1,
                        <String>[
                          'regard',
                          'regard avaloir',
                          'avaloir',
                          'grille',
                          'boîte de branchement',
                          'autre : '
                        ],
                      ),
                      Visibility(
                        child: expandedTextField(1, 1, "Type de l'ouvrage"),
                        visible: controllerList[0].text == "autre : ",
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      expandedTextField(2, 2, "Observations"),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("Dispositif de fermeture : ", style: textStyle),
                      dropDownList(
                          3,
                          3,
                          <String>[
                            'fonte',
                            'béton',
                            'autre : ',
                          ],
                        ),
                      Visibility(
                        child:
                            expandedTextField(4, 3, "Dispositif de fermeture"),
                        visible: controllerList[3].text == 'autre : ',
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("Section (Cheminée) :", style: textStyle),
                      dropDownList(
                            5, 4, <String>['circulaire', 'rectangulaire']),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("Nature (Cheminée) :", style: textStyle),
                      dropDownList(
                          6,
                          5,
                          <String>['préfabriquée', 'maçonnée', 'PVC', 'autre : '],
                        ),
                      Visibility(
                        child: expandedTextField(7, 5, "Nature de la cheminée"),
                        visible: controllerList[6].text == 'autre : ',
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("Dimension (cheminée) : ", style: textStyle),
                      expandedTextField(
                          8,
                          6,
                          controllerList[5].text == 'circulaire'
                              ? "Diamètre (en cm)"
                              : "Longueur (en cm)"),
                      controllerList[5].text == 'circulaire'
                          ? Padding(
                              padding: EdgeInsets.all(1),
                            )
                          : expandedTextField(11, 6, "Largeur (en cm)")
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("Dispositif d'accès :", style: textStyle),
                      dropDownList(
                        9,
                        7,
                        <String>[
                          'présence d\'échelons',
                          'présence d\'une crosse'
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("Cunette :", style: textStyle),
                      dropDownList(
                        10,
                        8,
                        <String>[
                          'préfabriquée',
                          'maçonnée',
                          'absence de cunette'
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("Profondeur radier en l'abscence de cunette :",style: textStyle,),
                      expandedTextField(12, 9, "Profondeur (en cm)")
                  ],),
                  Row(
                    children: <Widget>[
                      Text("Côte tn :",style: textStyle,),
                      expandedTextField(13, 10, "Côte (en cm)")
                  ],)
                ], //Children
              ),
            ),
          ),
        ),
      ),
    );
  }
}
