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
  Ouvrage ouvrage;
  Config size = new Config();
  TextStyle textSize = new TextStyle(fontSize: Config.fontSize);
  EdgeInsetsGeometry textPadding = EdgeInsets.all(Config.screenPadding);
  final int currentIndex = 0;
  TextEditingController ecoulementController = TextEditingController();
  TextEditingController deboitementController = TextEditingController();
  TextEditingController observationController = TextEditingController();
  String radioEtancheite = '';
  bool radioEtancheite2 = false;
  bool radioBranchement = false;
  bool radioStructure = false;
  bool radiodevoitement = false;
  bool radioTampon = false;
  bool radioDeteriore = false;
  bool tracesCharges = false;
  String radioH2S2 = "";
  String radioH2S = "";
  String radioTampon2 = "";
  String radioStructure2 = '';
  String dropdownCharge = 'Traces de mise en charge';
  String dropdownEcoulement = 'Perturbation de l\'écoulement';
  String dropdownEtancheite = 'Défaut d\'étanchéité';
  String dropdownStructure = 'Défaut de structure';
  String dropdownFermeture = 'Défaut de fermeture';
  String dropdownH2S = 'Présence de H2S';
  double widthRadio3 = Config.screenWidth / 3 - Config.screenWidth / 75;
  double widthRadio2 = Config.screenWidth / 2 - Config.screenWidth / 150;

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return new Scaffold(
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    Text("Traces de mise en charge : "),
                    Switch(
                      value: tracesCharges,
                      onChanged: (value){
                        setState(() {
                          tracesCharges=value;
                        });
                      },
                    ),
                    Text(tracesCharges ?"oui":"non"),
                    /*Padding(
                      padding: EdgeInsets.all(Config.screenPadding),
                      child: DropdownButton<String>(
                        hint: SizedBox(
                          width: 320.0,
                          child: Text(
                            dropdownCharge,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: Config.fontSize, color: Colors.black),
                          ),
                        ),
                        style: TextStyle(
                            fontSize: Config.fontSize, color: Colors.black),
                        items: <String>['Oui', 'Non'].map((String value) {
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
                            dropdownCharge = newValue;
                            widget.selectedOuvrage.tracesCharge=newValue;
                          });
                        },
                      ),
                    ),*/
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(Config.screenPadding),
                  child: DropdownButton<String>(
                    hint: SizedBox(
                      width: 320.0,
                      child: Text(
                        dropdownEcoulement,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: Config.fontSize, color: Colors.black),
                      ),
                    ),
                    style: TextStyle(
                        fontSize: Config.fontSize, color: Colors.black),
                    items: <String>['Oui', 'Non'].map((String value) {
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
                        dropdownEcoulement = newValue;
                        if (dropdownEcoulement == 'Non') {
                          ecoulementController.text = "";
                        }
                      });
                    },
                  ),
                ),
                Visibility(
                  child: Padding(
                    padding: EdgeInsets.all(Config.screenPadding),
                    child: TextField(
                        controller: ecoulementController,
                        enabled: dropdownEcoulement == 'Oui',
                        decoration: InputDecoration(
                          labelText: 'Préciser',
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
                  visible: dropdownEcoulement == 'Oui',
                  maintainState: dropdownEcoulement == 'Oui',
                  maintainAnimation: dropdownEcoulement == 'Oui',
                  maintainSize: dropdownEcoulement == 'Oui',
                ),
                Padding(
                  padding: EdgeInsets.all(Config.screenPadding),
                  child: DropdownButton<String>(
                    hint: SizedBox(
                      width: 320.0,
                      child: Text(
                        dropdownEtancheite,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: Config.fontSize, color: Colors.black),
                      ),
                    ),
                    items: <String>['Oui', 'Non'].map((String value) {
                      return new DropdownMenuItem<String>(
                          value: value,
                          child: SizedBox(
                            width: 320.0,
                            child: Text(
                              value,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: Config.fontSize,
                                  color: Colors.black),
                            ),
                          ));
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownEtancheite = newValue;
                        if (dropdownEtancheite == 'Non') {
                          radioEtancheite2 = false;
                          radioEtancheite = '';
                          radioBranchement = false;
                        }
                      });
                    },
                  ),
                ),
                Visibility(
                  child: Padding(
                    padding: EdgeInsets.all(Config.screenPadding),
                    child: Container(
                      height: 150.0,
                      width: Config.screenWidth,
                      child: ListView(children: <Widget>[
                        Container(
                          height: 50.0,
                          width: Config.screenWidth,
                          child: Card(
                            child: CheckboxListTile(
                                title: Text(
                                  "Traces d'infiltration",
                                  style: TextStyle(
                                      fontSize: Config.fontSize,
                                      color: Colors.black),
                                ),
                                value: radioEtancheite2,
                                onChanged: (bool newValue) {
                                  setState(() {
                                    radioEtancheite2 = newValue;
                                    radioEtancheite = '';
                                  });
                                }),
                          ),
                        ),
                        Visibility(
                          visible: radioEtancheite2,
                          child: Container(
                            width: Config.screenWidth,
                            height: 50.0,
                            child: Card(
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  Container(
                                    height: 50.0,
                                    width: widthRadio3,
                                    child: RadioListTile(
                                      title: Text("faible"),
                                      value: "faible",
                                      groupValue: radioEtancheite,
                                      onChanged: (String newValue) {
                                        setState(() {
                                          radioEtancheite = newValue;
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: 50.0,
                                    width: widthRadio3,
                                    child: RadioListTile(
                                      title: Text(
                                        "moyenne",
                                      ),
                                      value: "moyenne",
                                      groupValue: radioEtancheite,
                                      onChanged: (String newValue) {
                                        setState(() {
                                          radioEtancheite = newValue;
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: 50.0,
                                    width: widthRadio3,
                                    child: RadioListTile(
                                      title: Text("forte"),
                                      value: "forte",
                                      groupValue: radioEtancheite,
                                      onChanged: (String newValue) {
                                        setState(() {
                                          radioEtancheite = newValue;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 50.0,
                          width: Config.screenWidth,
                          child: Card(
                            child: CheckboxListTile(
                                title: Text(
                                  "Branchement non étanche",
                                  style: TextStyle(
                                      fontSize: Config.fontSize,
                                      color: Colors.black),
                                ),
                                value: radioBranchement,
                                onChanged: (bool newValue) {
                                  setState(() {
                                    radioBranchement = newValue;
                                  });
                                }),
                          ),
                        ),
                      ]),
                    ),
                  ),
                  visible: dropdownEtancheite == 'Oui',
                  maintainState: dropdownEtancheite == 'Oui',
                  maintainAnimation: dropdownEtancheite == 'Oui',
                  maintainSize: dropdownEtancheite == 'Oui',
                ),
                Padding(
                  padding: EdgeInsets.all(Config.screenPadding),
                  child: DropdownButton<String>(
                    hint: SizedBox(
                      width: 320.0,
                      child: Text(
                        dropdownStructure,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: Config.fontSize, color: Colors.black),
                      ),
                    ),
                    items: <String>[
                      'Oui',
                      'Non',
                    ].map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: SizedBox(
                          width: 320.0,
                          child: Text(
                            value,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: Config.fontSize, color: Colors.black),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownStructure = newValue;
                        if (dropdownStructure == 'Non') {
                          radioStructure = false;
                          radioStructure2 = '';
                          radiodevoitement = false;
                          deboitementController.text = '';
                        }
                      });
                    },
                  ),
                ),
                Visibility(
                  child: Padding(
                    padding: EdgeInsets.all(Config.screenPadding),
                    child: Container(
                      height: 225.0,
                      width: Config.screenWidth,
                      child: ListView(children: <Widget>[
                        Card(
                          child: Container(
                            height: 50.0,
                            width: Config.screenWidth,
                            child: CheckboxListTile(
                                title: Text(
                                  "Génie civil fissuré",
                                  style: TextStyle(
                                      fontSize: Config.fontSize,
                                      color: Colors.black),
                                ),
                                value: radioStructure,
                                onChanged: (bool newValue) {
                                  setState(() {
                                    radioStructure = newValue;
                                    if (!radioStructure) {
                                      radioStructure2 = '';
                                    }
                                  });
                                }),
                          ),
                        ),
                        Visibility(
                          visible: radioStructure,
                          child: Card(
                            child: Container(
                              width: Config.screenWidth,
                              height: 50.0,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  Container(
                                    height: 50.0,
                                    width: widthRadio2,
                                    child: RadioListTile(
                                      title: Text(
                                        "léger",
                                        style: TextStyle(
                                            fontSize: Config.fontSize,
                                            color: Colors.black),
                                      ),
                                      value: "léger",
                                      groupValue: radioStructure2,
                                      onChanged: (String newValue) {
                                        setState(() {
                                          radioStructure2 = newValue;
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: 50.0,
                                    width: widthRadio2,
                                    child: RadioListTile(
                                      title: Text(
                                        "lourd",
                                        style: TextStyle(
                                            fontSize: Config.fontSize,
                                            color: Colors.black),
                                      ),
                                      value: "lourd",
                                      groupValue: radioStructure2,
                                      onChanged: (String newValue) {
                                        setState(() {
                                          radioStructure2 = newValue;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Card(
                          child: Container(
                            height: 50.0,
                            width: Config.screenWidth,
                            child: CheckboxListTile(
                                title: Text(
                                  "Déboitement",
                                  style: TextStyle(
                                      fontSize: Config.fontSize,
                                      color: Colors.black),
                                ),
                                value: radiodevoitement,
                                onChanged: (bool newValue) {
                                  setState(() {
                                    radiodevoitement = newValue;
                                    if (radiodevoitement) {
                                      deboitementController.text = '';
                                    }
                                  });
                                }),
                          ),
                        ),
                        Visibility(
                          visible: radiodevoitement,
                          child: Container(
                            width: Config.screenWidth,
                            height: 50.0,
                            child: TextField(
                                controller: deboitementController,
                                decoration: InputDecoration(
                                  labelText: 'Précision',
                                  labelStyle:
                                      TextStyle(color: Config.textColor),
                                  focusColor: Config.color,
                                  fillColor: Colors.white,
                                  focusedBorder: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    borderSide:
                                        new BorderSide(color: Config.color),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                )),
                          ),
                        ),
                      ]),
                    ),
                  ),
                  visible: dropdownStructure == 'Oui',
                  maintainState: dropdownStructure == 'Oui',
                  maintainAnimation: dropdownStructure == 'Oui',
                  maintainSize: dropdownStructure == 'Oui',
                ),
                Padding(
                  padding: EdgeInsets.all(Config.screenPadding),
                  child: Container(
                    height: 173.0,
                    width: Config.screenWidth,
                    child: ListView(children: <Widget>[
                      Card(
                        child: Container(
                        height: 50.0,
                        width: Config.screenWidth,
                          child: CheckboxListTile(
                              title: Text("Tampon non accessible",
                                  style: TextStyle(
                                      fontSize: Config.fontSize,
                                      color: Colors.black),),
                              value: radioTampon,
                              onChanged: (bool newValue) {
                                setState(() {
                                  radioTampon = newValue;
                                  if (!radioTampon) {
                                    radioTampon2 = '';
                                  }
                                });
                              }),
                        ),
                      ),
                      Visibility(
                        visible: radioTampon,
                        child: Card(
                          child: Container(
                          width: Config.screenWidth,
                          height: 50.0,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                Container(
                                  height: 50.0,
                                  width: widthRadio2,
                                  child: RadioListTile(
                                    title: Text("sous enrobé",
                                  style: TextStyle(
                                      fontSize: Config.fontSize,
                                      color: Colors.black),),
                                    value: "sous enrobé",
                                    groupValue: radioTampon2,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        radioTampon2 = newValue;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  height: 50.0,
                                  width: widthRadio2,
                                  child: RadioListTile(
                                    title: Text(
                                      "sous véhicule",
                                  style: TextStyle(
                                      fontSize: Config.fontSize,
                                      color: Colors.black),
                                    ),
                                    value: "sous véhicule",
                                    groupValue: radioTampon2,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        radioTampon2 = newValue;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                        height: 50.0,
                        width: Config.screenWidth,
                          child: CheckboxListTile(
                              title: Text("Tampon détérioré",
                                  style: TextStyle(
                                      fontSize: Config.fontSize,
                                      color: Colors.black),),
                              value: radioDeteriore,
                              onChanged: (bool newValue) {
                                setState(() {
                                  radioDeteriore = newValue;
                                });
                              }),
                        ),
                      ),
                    ]),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(Config.screenPadding),
                  child: Container(
                    height: 120.0,
                    width: Config.screenWidth,
                    child: ListView(
                      children: <Widget>[
                        Card(
                          child: Container(
                          width: Config.screenWidth,
                          height: 50.0,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                Container(
                                  height: 50.0,
                                  width: widthRadio2,
                                  child: RadioListTile(
                                    title: Text("Absence de H2S",
                                  style: TextStyle(
                                      fontSize: Config.fontSize,
                                      color: Colors.black),),
                                    value: "Absence de H2S",
                                    groupValue: radioH2S,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        radioH2S = newValue;
                                        radioH2S2 = "";
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  height: 50.0,
                                  width: widthRadio2,
                                  child: RadioListTile(
                                    title: Text(
                                      "Présence de H2S",
                                  style: TextStyle(
                                      fontSize: Config.fontSize,
                                      color: Colors.black),
                                    ),
                                    value: "Présence de H2S",
                                    groupValue: radioH2S,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        radioH2S = newValue;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                            visible: radioH2S == "Présence de H2S",
                            child: Card(
                              child: Container(
                              height: 50.0,
                              width: Config.screenWidth,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: <Widget>[
                                    Container(
                                      height: 50.0,
                                      width: widthRadio3,
                                      child: RadioListTile(
                                        title: Text("faible",
                                  style: TextStyle(
                                      fontSize: Config.fontSize,
                                      color: Colors.black),),
                                        value: "faible",
                                        groupValue: radioH2S2,
                                        onChanged: (String newValue) {
                                          setState(() {
                                            radioH2S2 = newValue;
                                          });
                                        },
                                      ),
                                    ),
                                    Container(
                                      height: 50.0,
                                      width: widthRadio3,
                                      child: RadioListTile(
                                        title: Text(
                                          "moyenne",
                                  style: TextStyle(
                                      fontSize: Config.fontSize,
                                      color: Colors.black),
                                        ),
                                        value: "moyenne",
                                        groupValue: radioH2S2,
                                        onChanged: (String newValue) {
                                          setState(() {
                                            radioH2S2 = newValue;
                                          });
                                        },
                                      ),
                                    ),
                                    Container(
                                      height: 50.0,
                                      width: widthRadio3,
                                      child: RadioListTile(
                                        title: Text("importante",
                                  style: TextStyle(
                                      fontSize: Config.fontSize,
                                      color: Colors.black),),
                                        value: "importante",
                                        groupValue: radioH2S2,
                                        onChanged: (String newValue) {
                                          setState(() {
                                            radioH2S2 = newValue;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(Config.screenPadding),
                  child: TextField(
                      controller: observationController,
                      decoration: InputDecoration(
                        labelText: 'Autres observations',
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
              ], //Children
            ),
          ),
        ),
      ),
    );
  }
}
