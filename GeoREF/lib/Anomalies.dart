import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:GeoREF/Ouvrage.dart';
import 'package:GeoREF/Config.dart';

class Anomalie extends StatefulWidget {
  final Ouvrage selectedOuvrage;
  Anomalie(this.selectedOuvrage);
  @override
  AnomalieState createState() => AnomalieState();
}

class AnomalieState extends State<Anomalie> {
  TextStyle textStyle =
      new TextStyle(fontSize: Config.fontSize, fontWeight: FontWeight.bold);

  TextStyle choiceTextStyle = new TextStyle(fontSize: Config.fontSize / 1.3);
  List<TextEditingController> controllerList = new List(29);

  String getElement(int index) {
    switch (index) {
      case 1:
        return widget.selectedOuvrage.tracesCharge;
        break;
      case 2:
        return widget.selectedOuvrage.perturbationEcoulement;
        break;
      case 3:
        return widget.selectedOuvrage.precisionPerturbationEcoulement;
        break;
      case 4:
        return widget.selectedOuvrage.defautEtancheite;
        break;
      case 5:
        return widget.selectedOuvrage.branchementNonEtanche;
        break;
      case 6:
        return widget.selectedOuvrage.tracesInfiltration;
        break;
      case 7:
        return widget.selectedOuvrage.defautStructure;
        break;
      case 8:
        return widget.selectedOuvrage.deboitement;
        break;
      case 9:
        return widget.selectedOuvrage.genieCivilFissure;
        break;
      case 10:
        return widget.selectedOuvrage.tamponDeteriore;
        break;
      case 11:
        return widget.selectedOuvrage.defautFermeture;
        break;
      case 12:
        return widget.selectedOuvrage.presenceH2S;
        break;
      case 13:
        return widget.selectedOuvrage.observationsAnomalies;
        break;
      default:
        return null;
        break;
    }
  }

  /*
   * controller :
   *   0 -> tracescharges switch (1)
   *   1 -> tracescharges choix (1)
   *   2 -> perturbationécoulement switch (2)
   *   3 -> perturbationécoulement text (3)
   *   4 -> étanchéité switch (4)
   *   5 -> étanchéité choix branchement non étanche (5)
   *   15 -> étanchéité traces infiltration sélectioné (6)
   *   6 -> étanchéité choix traces infiltration (6)
   *   7 -> structure switch (7)
   *   17 -> switch génie civil
   *   18 -> switch déboitement
   *   8 -> structure choix génie civil (9)
   *   9 -> structure text déboitement (8)
   *   10 -> switch tampon détérioré (10)
   *   19 ->switch tampon non accessible
   *   11 -> choix tampon non accessible (11)
   *   12 -> h2s switch (12)
   *   13 -> H2S choix (12)
   *   14 -> observations (13)
   */
  @override
  void initState() {
    super.initState();
    for (var i = 0; i < controllerList.length; i++) {
      controllerList[i] = new TextEditingController();
    }
    for (int i in [1, 2, 4, 7, 12]) {
      //set switch false
      if (getElement(i) == "") {
        setElement(i, 'non');
      }
    }
    controllerList[0].text = getElement(1);

    if (controllerList[0].text == "non") {
      controllerList[1].text = "Sélectionner";
    } else {
      controllerList[0].text = "oui";
      controllerList[1].text = getElement(1);
    }
    controllerList[2].text = getElement(2);
    controllerList[3].text = getElement(3);
    controllerList[4].text = getElement(4);
    controllerList[16].text = "";
    controllerList[6].text = "Sélectionner";
    controllerList[5].text = "";

    if (getElement(4) == "oui") {
      controllerList[5].text = getElement(5);
      if (getElement(6) != "") {
        controllerList[16].text = "traces d'infiltration";
        controllerList[6].text = getElement(6);
      }
    }
    controllerList[7].text = getElement(7);
    controllerList[8].text = getElement(8);
    controllerList[17].text = "";
    controllerList[18].text = "";
    controllerList[9].text = "Sélectionner";

    if (controllerList[7].text == "oui") {
      controllerList[9].text = getElement(9);
      if (getElement(9) != "") controllerList[17].text = "génie civil fissuré";
      if (getElement(8) != "") controllerList[18].text = "déboitement";
    }
    controllerList[10].text = getElement(10);
    controllerList[11].text = getElement(11);
    if (getElement(11) == "") {
      controllerList[19].text = "";
      controllerList[11].text = "Sélectionner";
    } else {
      controllerList[11].text = getElement(11);
      controllerList[19].text = "tampon non accessible";
    }
    controllerList[12].text = getElement(12);
    if (getElement(12) == "non") {
      controllerList[13].text = "Sélectionner";
    } else {
      controllerList[12].text = "oui";
      controllerList[13].text = getElement(12);
    }
    controllerList[14].text = getElement(13);
  }

  void setElement(int index, String value) {
    switch (index) {
      case 1:
        widget.selectedOuvrage.tracesCharge = value;
        break;
      case 2:
        widget.selectedOuvrage.perturbationEcoulement = value;
        break;
      case 3:
        widget.selectedOuvrage.precisionPerturbationEcoulement = value;
        break;
      case 4:
        widget.selectedOuvrage.defautEtancheite = value;
        break;
      case 5:
        widget.selectedOuvrage.branchementNonEtanche = value;
        break;
      case 6:
        widget.selectedOuvrage.tracesInfiltration = value;
        break;
      case 7:
        widget.selectedOuvrage.defautStructure = value;
        break;
      case 8:
        widget.selectedOuvrage.deboitement = value;
        break;
      case 9:
        widget.selectedOuvrage.genieCivilFissure = value;
        break;
      case 10:
        widget.selectedOuvrage.tamponDeteriore = value;
        break;
      case 11:
        widget.selectedOuvrage.defautFermeture = value;
        break;
      case 12:
        widget.selectedOuvrage.presenceH2S = value;
        break;
      case 13:
        widget.selectedOuvrage.observationsAnomalies = value;
        break;
      default:
        break;
    }
  }

  Padding dropDownList(
      List<String> list, int indexParameter, int indexController) {
    return Padding(
      padding: EdgeInsets.all(Config.screenPadding),
      child: DropdownButton<String>(
        hint: SizedBox(
          child: Text(
            controllerList[indexController].text,
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
            controllerList[indexController].text = newValue;
            if (controllerList[indexController].text != 'autre : ')
              setElement(indexParameter, newValue);
          });
        },
      ),
    );
  }

  Padding _switch(
      int indexParameter,
      int indexController,
      String texttrue,
      String textfalse,
      List<int> resetParameterList,
      List<int> resetControllerList) {
    return Padding(
      padding: EdgeInsets.all(Config.screenPadding),
      child: Transform.scale(
        scale: 2.0,
        child: Switch(
          value: controllerList[indexController].text == texttrue,
          onChanged: (value) {
            setState(() {
              if (value) {
                controllerList[indexController].text = texttrue;
                if (indexParameter != null)
                  setElement(indexParameter, texttrue);
              } else {
                controllerList[indexController].text = textfalse;
                resetParameter(resetParameterList, resetControllerList);
                if (indexParameter != null)
                  setElement(indexParameter, textfalse);
              }
            });
          },
        ),
      ),
    );
  }

  void resetParameter(List<int> listParameter, List<int> listController) {
    for (int i in listParameter) {
      setElement(i, "");
    }
    for (var item in listController) {
      if ([1, 6, 9, 11, 13].indexOf(item) != -1)
        controllerList[item].text = "Sélectionner";
      else
        controllerList[item].text = "";
    }
  }

  Expanded expandedTextField(
      int indexParameter, int indexController, String text) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(Config.screenPadding),
        child: TextField(
          controller: controllerList[indexController],
          decoration: InputDecoration(
            labelText: text,
            labelStyle: TextStyle(color: Config.textColor),
            focusColor: Config.appBarColor,
            fillColor: Colors.white,
            focusedBorder: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide(color: Config.appBarColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
          onChanged: (String text) {
            setState(() {
              setElement(indexParameter, text);
            });
          },
        ),
      ),
    );
  }

  @override
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
                      Text("Traces de mise en charge :", style: textStyle),
                      _switch(null, 0, "oui", "non", [1], [1]),
                      Text(
                        controllerList[0].text == 'oui' ? "oui" : "non",
                        style: choiceTextStyle,
                      ),
                      controllerList[0].text == 'oui'
                          ? dropDownList(<String>[
                              'faible',
                              'moyenne',
                              'importante',
                            ], 1, 1)
                          : Padding(padding: EdgeInsets.all(1)),
                    ],
                  ),
                  Container(
                    height: 1.5,
                    color: Colors.blueGrey,
                  ),
                  Row(
                    children: <Widget>[
                      Text("Perturbation de l'écoulement :", style: textStyle),
                      _switch(2, 2, "oui", "non", [3], [3]),
                      Text(
                        controllerList[2].text == 'oui' ? "oui" : "non",
                        style: choiceTextStyle,
                      ),
                      controllerList[2].text == 'oui'
                          ? expandedTextField(3, 3, "Préciser")
                          : Padding(padding: EdgeInsets.all(1)),
                    ],
                  ),
                  Container(
                    height: 1.5,
                    color: Colors.blueGrey,
                  ),
                  Row(
                    children: <Widget>[
                      Text("Défaut d'étanchéité :", style: textStyle),
                      _switch(4, 4, "oui", "non", [5, 6], [5, 6, 16]),
                      Text(
                        controllerList[4].text == 'oui' ? "oui" : "non",
                        style: choiceTextStyle,
                      ),
                      Expanded(
                        child: controllerList[4].text == 'oui'
                            ? Column(children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    _switch(null, 16, "traces d'infiltration",
                                        "", [6], [6]),
                                    Text(
                                      "traces d'infiltration",
                                      style: choiceTextStyle,
                                    ),
                                    Visibility(
                                      visible: controllerList[16].text ==
                                          "traces d'infiltration",
                                      child: dropDownList(<String>[
                                        'faible',
                                        'moyenne',
                                        'importante',
                                      ], 6, 6),
                                    )
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    _switch(5, 5, "branchement non étanche", "",
                                        [], []),
                                    Text(
                                      "branchement non étanche",
                                      style: choiceTextStyle,
                                    )
                                  ],
                                ),
                              ])
                            : Padding(padding: EdgeInsets.all(1)),
                      ),
                    ],
                  ),
                  Container(
                    height: 1.5,
                    color: Colors.blueGrey,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Défaut de structure :",
                        style: textStyle,
                      ),
                      _switch(7, 7, "oui", "non", [8, 9], [8, 9, 17, 18]),
                      Text(
                        controllerList[7].text == 'oui' ? "oui" : "non",
                        style: choiceTextStyle,
                      ),
                      Expanded(
                        child: controllerList[7].text == 'oui'
                            ? Column(children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    _switch(null, 17, "génie civil fissuré", "",
                                        [9], [9]),
                                    Text(
                                      "génie civil fissuré",
                                      style: choiceTextStyle,
                                    ),
                                    Visibility(
                                      visible: controllerList[17].text ==
                                          'génie civil fissuré',
                                      child: dropDownList(<String>[
                                        'léger',
                                        'lourd',
                                      ], 9, 9),
                                    )
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    _switch(
                                        null, 18, "déboitement", "", [8], [8]),
                                    Text(
                                      "déboitement",
                                      style: choiceTextStyle,
                                    ),
                                    Visibility(
                                      visible: controllerList[18].text ==
                                          "déboitement",
                                      child:
                                          expandedTextField(8, 8, "précisions"),
                                    )
                                  ],
                                ),
                              ])
                            : Padding(padding: EdgeInsets.all(1)),
                      ),
                    ],
                  ),
                  Container(
                    height: 1.5,
                    color: Colors.blueGrey,
                  ),
                  Row(
                    children: <Widget>[
                      Text("Défaut de fermeture :", style: textStyle),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                _switch(null, 19, "tampon non accessible", "",
                                    [11], [11]),
                                Text(
                                  "tampon non accessible",
                                  style: choiceTextStyle,
                                ),
                                Visibility(
                                  visible: controllerList[19].text ==
                                      'tampon non accessible',
                                  child: dropDownList(<String>[
                                    'sous enrobé',
                                    'sous véhicule',
                                  ], 11, 11),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                _switch(10, 10, "tampon détérioré", "", [], []),
                                Text(
                                  "tampon détérioré",
                                  style: choiceTextStyle,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 1.5,
                    color: Colors.blueGrey,
                  ),
                  Row(
                    children: <Widget>[
                      Text("Présence d'H2S :", style: textStyle),
                      _switch(null, 12, "oui", "non", [12], [13]),
                      Text(
                        controllerList[12].text == 'oui' ? "oui" : "non",
                        style: choiceTextStyle,
                      ),
                      controllerList[12].text == 'oui'
                          ? dropDownList(<String>[
                              'faible',
                              'moyenne',
                              'importante',
                            ], 12, 13)
                          : Padding(padding: EdgeInsets.all(1))
                    ],
                  ),
                  Row(children: <Widget>[
                    expandedTextField(13, 14, "Autres observations"),
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
