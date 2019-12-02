import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:geo_diagnostique_app/Ouvrage.dart';
import 'package:geo_diagnostique_app/Config.dart';

class Anomalie extends StatefulWidget {
  final Ouvrage selectedOuvrage;
  Anomalie(this.selectedOuvrage);
  @override
  AnomalieState createState() => AnomalieState();
}

class AnomalieState extends State<Anomalie> {
  TextStyle textStyle =
      new TextStyle(fontSize: Config.fontSize, fontWeight: FontWeight.bold);
  EdgeInsetsGeometry textPadding = EdgeInsets.all(Config.screenPadding);
  final int currentIndex = 0;
  TextEditingController ecoulementController = TextEditingController();
  TextEditingController deboitementController = TextEditingController();
  TextEditingController observationController = TextEditingController();
  List<bool> boolList = new List();
  List<String> stringlist = new List();
  double widthRadio3 = Config.screenWidth / 3 - Config.screenWidth / 75;
  double widthRadio2 = Config.screenWidth / 2 - Config.screenWidth / 150;

  @override
  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 8; i++) {
      boolList.add(false);
      stringlist.add("Selectionner");
    }
  }

  Padding dropDownList(int index, List<String> list, String elementOuvrage) {
    return Padding(
      padding: EdgeInsets.all(Config.screenPadding),
      child: DropdownButton<String>(
        hint: SizedBox(
          child: Text(
            stringlist[index],
            textAlign: TextAlign.center,
            style:
                TextStyle(fontSize: Config.fontSize / 1.5, color: Colors.black),
          ),
        ),
        style: TextStyle(fontSize: Config.fontSize / 1.5, color: Colors.black),
        items: list.map((String value) {
          return new DropdownMenuItem<String>(
            child: SizedBox(
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
            stringlist[index] = newValue;
            elementOuvrage = newValue;
          });
        },
      ),
    );
  }

  Switch _switch(int index) {
    return Switch(
      value: boolList[index],
      onChanged: (value) {
        setState(() {
          boolList[index] = value;
        });
      },
    );
  }

  Expanded expandedTextField(String labelText, String elementOuvrage,
      TextEditingController controller) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(Config.screenPadding),
        child: TextField(
          controller: controller,
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

  @override
  Widget build(BuildContext context) {
    print(stringlist[3] + "," + boolList[4].toString());
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
                      Text("Traces de mise en charge : ", style: textStyle),
                      _switch(0),
                      Text(boolList[0] ? "oui" : "non"),
                      boolList[0]
                          ? dropDownList(
                              0,
                              <String>[
                                'faible',
                                'moyenne',
                                'importante',
                              ],
                              widget.selectedOuvrage.tracesCharge)
                          : Padding(padding: EdgeInsets.all(1)),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("Perturbation de l'écoulement :", style: textStyle),
                      _switch(1),
                      Text(boolList[1] ? "oui" : "non"),
                      boolList[1]
                          ? expandedTextField(
                              "préciser",
                              widget.selectedOuvrage.perturbationEcoulement,
                              null)
                          : Padding(padding: EdgeInsets.all(1)),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("Défaut d'étanchéité :", style: textStyle),
                      _switch(2),
                      Text(boolList[2] ? "oui" : "non"),
                      boolList[2]
                          ? dropDownList(
                              1,
                              <String>[
                                "traces d'infiltration",
                                "branchement non étanche"
                              ],
                              widget.selectedOuvrage.defautEtancheite)
                          : Padding(padding: EdgeInsets.all(1)),
                      stringlist[1] == "traces d'infiltration"
                          ? dropDownList(
                              2,
                              <String>[
                                'faible',
                                'moyenne',
                                'importante',
                              ],
                              widget.selectedOuvrage.defautEtancheite)
                          : Padding(padding: EdgeInsets.all(1))
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Défaut de structure",
                        style: textStyle,
                      ),
                      _switch(4),
                      Text(boolList[4] ? "oui" : "non"),
                      boolList[4]
                          ? dropDownList(
                              3,
                              <String>["Genie civil fissuré", "déboitement"],
                              widget.selectedOuvrage.defautStructure)
                          : Padding(padding: EdgeInsets.all(1)),
                      Visibility(
                        visible: stringlist[3] != "Selectionner",
                        child: stringlist[3] == "Genie civil fissuré"
                            ? dropDownList(
                                4,
                                <String>[
                                  'léger',
                                  'lourd',
                                ],
                                widget.selectedOuvrage.genieCivilFissure)
                            : expandedTextField("commentaires",
                                widget.selectedOuvrage.genieCivilFissure, null),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("Défaut de fermeture", style: textStyle),
                      _switch(6),
                      Text(boolList[6]
                          ? "tampon non accessible"
                          : "tampon détérioré"),
                      boolList[6]
                          ? dropDownList(
                              5,
                              <String>[
                                'sous enrobé',
                                'sous véhicule',
                              ],
                              widget.selectedOuvrage.defautFermeture)
                          : Padding(padding: EdgeInsets.all(1))
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("Présence d'H2S", style: textStyle),
                      _switch(7),
                      Text(boolList[7] ? "non" : "oui"),
                      boolList[7]
                          ? dropDownList(
                              6,
                              <String>[
                                'faible',
                                'moyenne',
                                'importante',
                              ],
                              widget.selectedOuvrage.presenceH2S)
                          : Padding(padding: EdgeInsets.all(1))
                    ],
                  ),
                  Row(children: <Widget>[
                    expandedTextField("Autres observations",
                        widget.selectedOuvrage.observationsAnomalies, null),
                  ])
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
