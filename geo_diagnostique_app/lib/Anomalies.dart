import 'dart:core';
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
  List<TextEditingController> controllerList = new List(15);
  List<bool> boolList = new List();
  double widthRadio3 = Config.screenWidth / 3 - Config.screenWidth / 75;
  double widthRadio2 = Config.screenWidth / 2 - Config.screenWidth / 150;
  
  String getElement(int index){
    switch(index){
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
   *   5 -> étanchéité choix 1 (5)
   *   6 -> étanchéité choix 2 (6)
   *   7 -> structure switch (7)
   *   8 -> structure choix 1 (8)
   *   9 -> structure choix 2 (9)
   *   10 -> fermeture choix 1 (10)
   *   11 -> fermeture choix 2 (11)
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
    if(getElement(1)=="")setElement(1, 'non');
    if(getElement(1)=="")setElement(2, 'non');
    if(getElement(1)=="")setElement(4, 'non');
    if(getElement(1)=="")setElement(7, 'non');
    if(getElement(1)=="")setElement(12,'non');
    editControllerlist(<String>['faible', 'moyenne','importante','','non'], 0,1, 1);
    controllerList[2].text=getElement(2);
    controllerList[3].text=getElement(3);
    controllerList[4].text=getElement(4);
    controllerList[5].text=getElement(5);
    controllerList[6].text=getElement(6);
    controllerList[7].text=getElement(7);
    controllerList[8].text=getElement(8);
    if(getElement(8)=="") controllerList[8].text="Sélectionner";
    controllerList[9].text=getElement(9);
    controllerList[10].text = getElement(10);
    if(getElement(10)==''){
      controllerList[10].text="Sélectionner";
    }
    else if(getElement(10)=="tampon non accessible"){
      controllerList[11].text=getElement(11);
    }
    controllerList[11].text=getElement(11);
    editControllerlist(<String>['faible', 'moyenne','importante','','non'], 12, 13, 12);
    controllerList[14].text=getElement(13);
  }
  
  void editControllerlist(List<String> list,int indexController1,int indexController2, int indexParameter){
    if(list.indexOf(getElement(indexParameter))!=-1){
      //switch == non
      controllerList[indexController1].text = getElement(indexParameter);
    }
    else {
      controllerList[indexController1].text = 'oui';
      controllerList[indexController2].text = getElement(indexParameter);
    }
  }

  void setElement(int index,String value){
    switch(index){
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
        widget.selectedOuvrage.tracesInfiltration = value;
        break;
      case 6:
        widget.selectedOuvrage.branchementNonEtanche = value;
        break;
      case 7:
        widget.selectedOuvrage.defautStructure = value;
        break;
      case 8:
        widget.selectedOuvrage.genieCivilFissure = value;
        break;
      case 9:
        widget.selectedOuvrage.deboitement = value;
        break;
      case 10:
        widget.selectedOuvrage.defautFermeture = value;
        break;
      case 11:
        widget.selectedOuvrage.tamponDeteriore = value;
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

  Padding dropDownList(List<String> list, int indexParameter, int indexController) {
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

  Switch _switch(int indexParameter,int indexController) {
    return Switch(
      value: controllerList[indexController].text=='oui',
      onChanged: (value) {
        setState(() {
          if(value){
            controllerList[indexController].text ='oui';
            setElement(indexParameter, 'oui');
          }
          else {
            controllerList[indexController].text = 'non';
            setElement(indexParameter, 'non');
          }
        });
      },
    );
  }

  Expanded expandedTextField(int indexParameter,int indexController) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(Config.screenPadding),
        child: TextField(
          controller: controllerList[indexController],
          decoration: InputDecoration(
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
                      Text("Traces de mise en charge : ", style: textStyle),
                      _switch(1,0),
                      Text(controllerList[0].text == 'oui' ? "oui" : "non"),
                      controllerList[0].text == 'oui'
                          ? dropDownList(
                              <String>[
                                'faible',
                                'moyenne',
                                'importante',
                              ],
                              1,1)
                          : Padding(padding: EdgeInsets.all(1)),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("Perturbation de l'écoulement :", style: textStyle),
                      _switch(2,2),
                      Text(controllerList[2].text == 'oui' ? "oui" : "non"),
                      controllerList[2].text == 'oui'
                          ? expandedTextField(3,3)
                          : Padding(padding: EdgeInsets.all(1)),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("Défaut d'étanchéité :", style: textStyle),
                      _switch(4,4),
                      Text(controllerList[4].text == 'oui' ? "oui" : "non"),
                      controllerList[4].text == 'oui'
                          ? dropDownList(
                              <String>[
                                "traces d'infiltration",
                                "branchement non étanche"
                              ],
                              5,5)
                          : Padding(padding: EdgeInsets.all(1)),
                      controllerList[5].text == "traces d'infiltration"
                          ? dropDownList(
                              <String>[
                                'faible',
                                'moyenne',
                                'importante',
                              ],
                              6,6)
                          : Padding(padding: EdgeInsets.all(1))
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Défaut de structure",
                        style: textStyle,
                      ),
                      _switch(7,7),
                      Text(controllerList[7].text=='oui' ? "oui" : "non"),
                      controllerList[7].text=='oui'
                          ? dropDownList(
                              <String>["Genie civil fissuré", "déboitement"],
                              8,8)
                          : Padding(padding: EdgeInsets.all(1)),
                      Visibility(
                        visible: controllerList[7].text=='oui',
                        child: controllerList[8].text == "Genie civil fissuré"
                            ? dropDownList(
                                <String>[
                                  'léger',
                                  'lourd',
                                ],
                                9,9)
                            : expandedTextField(8,8),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("Défaut de fermeture", style: textStyle),
                      dropDownList(<String>["tampon non accessible","tampon détérioré"], 10, 10),
                      controllerList[10].text == 'tampon non accessible'
                          ? dropDownList(
                              <String>[
                                'sous enrobé',
                                'sous véhicule',
                              ],
                              11,11)
                          : Padding(padding: EdgeInsets.all(1))
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("Présence d'H2S", style: textStyle),
                      _switch(12,12),
                      Text(controllerList[12].text=='oui' ? "oui" : "non"),
                      controllerList[12].text=='oui'
                          ? dropDownList(
                              <String>[
                                'faible',
                                'moyenne',
                                'importante',
                              ],
                              12,13)
                          : Padding(padding: EdgeInsets.all(1))
                    ],
                  ),
                  Row(children: <Widget>[
                    expandedTextField(13,14),
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
