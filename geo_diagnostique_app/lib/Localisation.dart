import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:geo_diagnostique_app/Ouvrage.dart';
import 'package:geo_diagnostique_app/Config.dart';

class Localisation extends StatefulWidget {
  @override
  LocalisationState createState() => LocalisationState();
}

class LocalisationState extends State<Localisation> {
  Ouvrage ouvrage;
  Config size = new Config();
  TextStyle textSize = new TextStyle(fontSize: Config.fontSize);
  EdgeInsetsGeometry textPadding = EdgeInsets.all(Config.screenPadding);
  int navigationIndex;
  final int currentIndex = 0;
  TextEditingController communeController = TextEditingController();
  TextEditingController rueController = TextEditingController();
  TextEditingController typeDeReseau = TextEditingController();
  String dropdownValueImplantation = "Implantation";
  String dropdownValueReseau = "Type de réseau";
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return new Scaffold(
        body: Builder(
      builder: (context) => SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(Config.screenPadding),
                child: TextField(
                    controller: communeController,
                    //onChanged: (v) => communeController.text = v,
                    decoration: InputDecoration(
                      labelText: 'Commune',
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
                child: TextField(
                    controller: rueController,
                    //onChanged: (v) => rueController.text = v,
                    decoration: InputDecoration(
                      labelText: 'Nom de la rue',
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
                        dropdownValueImplantation,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: Config.fontSize, color: Colors.black),
                      ),
                    ),
                  style: TextStyle(fontSize: Config.fontSize,
                  color: Colors.black),
                  items: <String>[
                    'chaussée',
                    'trottoir',
                    'accotement',
                    'terrain naturel',
                    'domaine privé'
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
                      dropdownValueImplantation = newValue;
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
                        dropdownValueReseau,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: Config.fontSize, color: Colors.black),
                      ),
                    ),
                  style: TextStyle(fontSize: Config.fontSize,
                  color: Colors.black),
                  items: <String>[
                    'séparatif EU',
                    'séparatif EP',
                    'unitaire',
                    'autre : '
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
                      dropdownValueReseau = newValue;
                      if(!(dropdownValueReseau == 'autre : ')){
                        typeDeReseau.text = "";
                      }
                    });
                  },
                ),
              ),
              Visibility(
                child:Padding(
                padding: EdgeInsets.all(Config.screenPadding),
                  child: TextField(
                      controller: typeDeReseau,
                      enabled: dropdownValueReseau == 'autre : ',
                      decoration: InputDecoration(
                        labelText: 'Type de Reseau',
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
                visible: dropdownValueReseau == 'autre : ',
              ),
            ], //Children
          ),
        ),
      ),
    ));
  }
}
