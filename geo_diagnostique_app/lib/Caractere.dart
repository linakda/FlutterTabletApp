import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:geo_diagnostique_app/Ouvrage.dart';
import 'package:geo_diagnostique_app/Config.dart';

class Caractere extends StatefulWidget {
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
  String dropdownType = "Type";
  String dropdownFermeture = "Dispositif de fermeture";
  String dropdownSection = "Section (cheminée)";
  String dropdownNature = "Nature (cheminée)";
  String dropdownAcces = "Dispositif d'accès";
  String dropdownCunette = "Cunette";

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
                  child: DropdownButton<String>(
                   hint: SizedBox(
                      width: 320.0,
                      child: Text(
                        dropdownType,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: Config.fontSize, color: Colors.black),
                      ),
                    ),
                    style: TextStyle(
                        fontSize: Config.fontSize, color: Colors.black),
                    items: <String>[
                      'regard',
                      'regard avaloir',
                      'avaloir',
                      'grille',
                      'boîte de branchement',
                      'autre'
                    ].map((String value) {
                      return new DropdownMenuItem<String>(
                        child: SizedBox(
                          width: 320.0,
                          child: Text(
                            value,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: Config.fontSize, color: Colors.black),
                          ),
                        ),
                        value: value,
                        // child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownType = newValue;
                        if(!(dropdownType == 'autre')){
                          typeControler.text = '';
                        }
                      });
                    },
                  ),
                ),
                Visibility(
                   child : Padding(
                  padding: EdgeInsets.all(Config.screenPadding),
                  child:TextField(
                        controller: typeControler,
                        enabled: dropdownType == 'autre',
                        decoration: InputDecoration(
                          labelText: 'Type de l\'ouvrage',
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
                  visible: dropdownType == 'autre',
                    maintainState: dropdownType == 'autre',
                    maintainAnimation: dropdownType == 'autre',
                    maintainSize: dropdownType == 'autre',
                ),
                Padding(
                  padding: EdgeInsets.all(Config.screenPadding),
                  child: TextField(
                      style: TextStyle(fontSize: 15.5),
                      controller: obsControler,
                      //onChanged: (v) => obsControler.text = v,
                      decoration: InputDecoration(
                        labelText: 'Observations',
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
                        dropdownFermeture,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: Config.fontSize, color: Colors.black),
                      ),
                    ),
                    style: TextStyle(
                        fontSize: Config.fontSize, color: Colors.black),
                    items: <String>[
                      'fonte',
                      'béton',
                      'autre : ',
                    ].map((String value) {
                      return new DropdownMenuItem<String>(
                        child: SizedBox(
                          width: 320.0,
                          child: Text(
                            value,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        value: value,
                        //  child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownFermeture = newValue;
                        if(!(dropdownFermeture == 'autre : ')){
                          fermetureControler.text = "";
                        }
                      });
                    },
                  ),
                ),
                Visibility(
                  child : Padding(
                  padding: EdgeInsets.all(Config.screenPadding),
                    child: TextField(
                        controller: fermetureControler,
                        enabled: dropdownFermeture == 'autre : ',
                        decoration: InputDecoration(
                          labelText: 'Type de fermeture',
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
                  visible: dropdownFermeture == 'autre : ',
                    maintainState: dropdownFermeture == 'autre : ',
                    maintainAnimation: dropdownFermeture == 'autre : ',
                    maintainSize: dropdownFermeture == 'autre : ',
                ),
                Padding(
                  padding: EdgeInsets.all(Config.screenPadding),
                  child: DropdownButton<String>(
                    hint: SizedBox(
                      width: 320.0,
                      child: Text(
                        dropdownSection,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: Config.fontSize, color: Colors.black),
                      ),
                    ),
                    style: TextStyle(
                        fontSize: Config.fontSize, color: Colors.black),
                    items: <String>['circulaire', 'rectangulaire']
                        .map((String value) {
                      return new DropdownMenuItem<String>(
                        child: SizedBox(
                          width: 320.0,
                          child: Text(
                            value,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        value: value,
                        //  child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownSection = newValue;
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
                        dropdownNature,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: Config.fontSize, color: Colors.black),
                      ),
                    ),
                    style: TextStyle(
                        fontSize: Config.fontSize, color: Colors.black),
                    items: <String>[
                      'préfabriquée',
                      'maçonnée',
                      'PVC',
                      'autre : '
                    ].map((String value) {
                      return new DropdownMenuItem<String>(
                        child: SizedBox(
                          width: 320.0,
                          child: Text(
                            value,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        value: value,
                        //  child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownNature = newValue;
                        if(!(dropdownNature == 'autre : ')){
                          natureControler.text = "";
                        }
                      });
                    },
                  ),
                ),
                Visibility(
                  child : Padding(
                  padding: EdgeInsets.all(Config.screenPadding),
                  child: TextField(
                        controller: natureControler,
                        enabled: dropdownNature == 'autre : ',
                        decoration: InputDecoration(
                          labelText: 'Nature de la cheminée',
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
                  visible: dropdownNature == 'autre : ',
                    maintainState: dropdownNature == 'autre : ',
                    maintainAnimation: dropdownNature == 'autre : ',
                    maintainSize: dropdownNature == 'autre : ',
                ),
                Padding(
                  padding: EdgeInsets.all(Config.screenPadding),
                  child: TextField(
                      style: TextStyle(fontSize: 15.5),
                      controller: dimensionControler,
                      //onChanged: (v) => dimensionControler.text = v,
                      decoration: InputDecoration(
                        labelText: 'Dimension (cheminée)',
                        hintText: 'ex: 1000mm',
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
                        dropdownAcces,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: Config.fontSize, color: Colors.black),
                      ),
                    ),
                    style: TextStyle(
                        fontSize: Config.fontSize, color: Colors.black),
                    items: <String>[
                      'présence d\'échelons',
                      'présence d\'une crosse'
                    ].map((String value) {
                      return new DropdownMenuItem<String>(
                        child: SizedBox(
                          width: 320.0,
                          child: Text(
                            value,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        value: value,
                        //  child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownAcces = newValue;
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
                        dropdownCunette,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: Config.fontSize, color: Colors.black),
                      ),
                    ),
                    style: TextStyle(
                        fontSize: Config.fontSize, color: Colors.black),
                    items: <String>[
                      'préfabriquée',
                      'maçonnée',
                      'absence de cunette'
                    ].map((String value) {
                      return new DropdownMenuItem<String>(
                        child: SizedBox(
                          width: 320.0,
                          child: Text(
                            value,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        value: value,
                        //  child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownCunette = newValue;
                      });
                    },
                  ),
                ),
              ], //Children
            ),
          ),
        ),
      ),
    );
  }
}
