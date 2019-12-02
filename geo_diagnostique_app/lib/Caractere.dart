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
  Ouvrage ouvrage;
  Config size = new Config();
  TextStyle textSize = new TextStyle(fontSize: Config.fontSize);
  Color color = Colors.teal[700];
  EdgeInsetsGeometry textPadding = EdgeInsets.all(Config.screenPadding);
  int navigationIndex;
  TextEditingController typeControler = TextEditingController();
  TextEditingController obsControler = TextEditingController();
  TextEditingController fermetureControler = TextEditingController();
  TextEditingController dimensionControler = TextEditingController();
  TextEditingController natureControler = TextEditingController();
  final int currentIndex = 1;
  final List<String> listString = new List<String>(6);

  @override
  void initState() {
    print("passer par initstate");
    super.initState();
    for(var i=0;i<listString.length;i++){
      listString[i] = "Selectionner";
    }
  }


  Padding dropDownList(int index, List<String> list,
      String elementOuvrage, TextEditingController controller) {
        print(listString[index]);
    return Padding(
      padding: EdgeInsets.all(Config.screenPadding),
      child: DropdownButton<String>(
        hint: SizedBox(
          width: listString[index]=="autre : "?Config.screenWidth/4:Config.screenWidth/1.5,
          child: Text(
            listString[index],
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: Config.fontSize, color: Colors.black),
          ),
        ),
        style: TextStyle(fontSize: Config.fontSize, color: Colors.black),
        items: list.map((String value) {
          return new DropdownMenuItem<String>(
            child: SizedBox(
              width: listString[index]=="autre : "?Config.screenWidth/4:Config.screenWidth/1.5,
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
            listString[index] = newValue;
            print("${listString[index]} == $newValue");
            if (listString[index] != 'autre : ') {
              elementOuvrage = newValue;
              if (controller != null) {
                controller.text = "";
              }
            }
          });
        },
      ),
    );
  }

  Expanded expandedTextField(String labelText,String elementOuvrage ) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(Config.screenPadding),
        child: TextField(
          controller: typeControler,
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
              elementOuvrage = text;
            });
          },
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    print(listString[0]);
    Config().init(context);
    return new Scaffold(
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    Text("Type :"),
                    dropDownList(
                        0,
                        <String>[
                          'regard',
                          'regard avaloir',
                          'avaloir',
                          'grille',
                          'boîte de branchement',
                          'autre : '
                        ],
                        widget.selectedOuvrage.type,
                        typeControler),
                    Visibility(
                      child:expandedTextField('Type de l\'ouvrage', widget.selectedOuvrage.type),
                      visible: listString[0] == "autre : ",
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Observation :"),
                    expandedTextField('Observations', widget.selectedOuvrage.observationCaracteristiques),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Dispositif de fermeture : "),
                    dropDownList(
                        1,
                        <String>[
                          'fonte',
                          'béton',
                          'autre : ',
                        ],
                        widget.selectedOuvrage.dispositifFermeture,
                        fermetureControler),
                    Visibility(
                      child:expandedTextField('Type de fermeture', widget.selectedOuvrage.dispositifFermeture),
                      visible: listString[1] == 'autre : ',
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Section (Cheminée) :"),
                    dropDownList(
                        2,
                        <String>['circulaire', 'rectangulaire'],
                        widget.selectedOuvrage.section,
                        null),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Nature (Cheminée) :"),
                    dropDownList(
                        3,
                        <String>['préfabriquée', 'maçonnée', 'PVC', 'autre : '],
                        widget.selectedOuvrage.nature,
                        natureControler),
                    Visibility(
                      child : expandedTextField('Nature de la cheminée', widget.selectedOuvrage.nature),
                      visible: listString[3] == 'autre : ',
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Dimension (cheminée) : "),
                    expandedTextField('Dimension (cheminée)', widget.selectedOuvrage.dimension),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Dispositif d'accès :"),
                    dropDownList(
                        4,
                        <String>[
                          'présence d\'échelons',
                          'présence d\'une crosse'
                        ],
                        widget.selectedOuvrage.dispositifAcces,
                        null),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Cunette"),
                    dropDownList(
                        5,
                        <String>[
                          'préfabriquée',
                          'maçonnée',
                          'absence de cunette'
                        ],
                        widget.selectedOuvrage.cunette,
                        null),
                  ],
                ),
              ], //Children
            ),
          ),
        ),
      ),
    );
  }
}
