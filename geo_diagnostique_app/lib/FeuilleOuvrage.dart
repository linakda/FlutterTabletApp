import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:geo_diagnostique_app/Affaire.dart';
import 'package:geo_diagnostique_app/Anomalies.dart';
import 'package:geo_diagnostique_app/Caractere.dart';
import 'package:geo_diagnostique_app/Commune.dart';
import 'package:geo_diagnostique_app/Localisation.dart';
import 'package:geo_diagnostique_app/MenuOuvrage.dart';
import 'package:geo_diagnostique_app/Ouvrage.dart';
import 'package:geo_diagnostique_app/Schema.dart';
import 'package:geo_diagnostique_app/Config.dart';
import 'package:geo_diagnostique_app/main.dart';

class FeuilleOuvrage extends StatefulWidget {
  final NumeroAffaire selectedNumeroAffaire;
  final Commune selectedCommune;
  final Ouvrage selectedOuvrage;
  FeuilleOuvrage(
      this.selectedNumeroAffaire, this.selectedCommune, this.selectedOuvrage);
  @override
  FeuilleOuvrageState createState() => FeuilleOuvrageState();
}

class FeuilleOuvrageState extends State<FeuilleOuvrage> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  int currentIndex = 0;

  @override
  initState() {
    super.initState();
  }

  //Création d'une boîte AlertDialog après validation du formulaire
  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Valider le formulaire?'),
            content:
                const Text("Le fomulaire sera enregistré dans son intégralité"),
            actions: <Widget>[
              FlatButton(
                child: const Text("Annuler"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: const Text('Valider'),
                onPressed: () {
                  String ouvrageData = widget
                          .selectedNumeroAffaire.numeroAffaire +
                      ',' +
                      widget.selectedOuvrage.refOuvrage +
                      ',' +
                      widget.selectedCommune.nomCommune +
                      ',' +
                      widget.selectedOuvrage.nomRue +
                      ',' +
                      widget.selectedOuvrage.implantation +
                      ',' +
                      widget.selectedOuvrage.typeReseau +
                      ',' +
                      widget.selectedOuvrage.latitude +
                      ',' +
                      widget.selectedOuvrage.longitude +
                      ',' +
                      widget.selectedOuvrage.type +
                      ',' +
                      widget.selectedOuvrage.observationCaracteristiques +
                      ',' +
                      widget.selectedOuvrage.dispositifFermeture +
                      ',' +
                      widget.selectedOuvrage.section +
                      ',' +
                      widget.selectedOuvrage.nature +
                      ',' +
                      widget.selectedOuvrage.dimension +
                      ',' +
                      widget.selectedOuvrage.dispositifAcces +
                      ',' +
                      widget.selectedOuvrage.cunette +
                      ',' +
                      widget.selectedOuvrage.refOuvrage +
                      ',' +
                      widget.selectedOuvrage.coteTN.toString() +
                      ',' +
                      widget.selectedOuvrage.profondeurRadier.toString() +
                      ',' +
                      widget.selectedOuvrage.listCanalisation[0].role +
                      ',' +
                      widget.selectedOuvrage.listCanalisation[0].geometrie +
                      ',' +
                      widget.selectedOuvrage.listCanalisation[0].dimension +
                      ',' +
                      widget.selectedOuvrage.listCanalisation[0].nature +
                      ',' +
                      widget.selectedOuvrage.listCanalisation[0].profondeur
                          .toString() +
                      ',' +
                      widget.selectedOuvrage.listCanalisation[0].observations +
                      ',' +
                      widget.selectedOuvrage.listCanalisation[1].role +
                      ',' +
                      widget.selectedOuvrage.listCanalisation[1].geometrie +
                      ',' +
                      widget.selectedOuvrage.listCanalisation[1].dimension +
                      ',' +
                      widget.selectedOuvrage.listCanalisation[1].nature +
                      ',' +
                      widget.selectedOuvrage.listCanalisation[1].profondeur
                          .toString() +
                      ',' +
                      widget.selectedOuvrage.listCanalisation[1].angle +
                      ',' +
                      widget.selectedOuvrage.listCanalisation[1].observations +
                      ',' +
                      widget.selectedOuvrage.listCanalisation[2].role +
                      ',' +
                      widget.selectedOuvrage.listCanalisation[2].geometrie +
                      ',' +
                      widget.selectedOuvrage.listCanalisation[2].dimension +
                      ',' +
                      widget.selectedOuvrage.listCanalisation[2].nature +
                      ',' +
                      widget.selectedOuvrage.listCanalisation[2].profondeur
                          .toString() +
                      ',' +
                      widget.selectedOuvrage.listCanalisation[2].angle +
                      ',' +
                      widget.selectedOuvrage.listCanalisation[2].observations +
                      ',' +
                      widget.selectedOuvrage.listCanalisation[3].role +
                      ',' +
                      widget.selectedOuvrage.listCanalisation[3].geometrie +
                      ',' +
                      widget.selectedOuvrage.listCanalisation[3].dimension +
                      ',' +
                      widget.selectedOuvrage.listCanalisation[3].nature +
                      ',' +
                      widget.selectedOuvrage.listCanalisation[3].profondeur
                          .toString() +
                      ',' +
                      widget.selectedOuvrage.listCanalisation[3].angle +
                      ',' +
                      widget.selectedOuvrage.listCanalisation[3].observations +
                      ',' +
                      widget.selectedOuvrage.listCanalisation[4].role +
                      ',' +
                      widget.selectedOuvrage.listCanalisation[4].geometrie +
                      ',' +
                      widget.selectedOuvrage.listCanalisation[4].dimension +
                      ',' +
                      widget.selectedOuvrage.listCanalisation[4].nature +
                      ',' +
                      widget.selectedOuvrage.listCanalisation[4].profondeur
                          .toString() +
                      ',' +
                      widget.selectedOuvrage.listCanalisation[4].angle +
                      ',' +
                      widget.selectedOuvrage.listCanalisation[4].observations +
                      ',' +
                      widget.selectedOuvrage.listCanalisation[5].role +
                      ',' +
                      widget.selectedOuvrage.listCanalisation[5].geometrie +
                      ',' +
                      widget.selectedOuvrage.listCanalisation[5].dimension +
                      ',' +
                      widget.selectedOuvrage.listCanalisation[5].nature +
                      ',' +
                      widget.selectedOuvrage.listCanalisation[5].profondeur
                          .toString() +
                      ',' +
                      widget.selectedOuvrage.listCanalisation[5].angle +
                      ',' +
                      widget.selectedOuvrage.listCanalisation[5].observations +
                      ',' +
                      widget.selectedOuvrage.tracesCharge +
                      ',' +
                      widget.selectedOuvrage.perturbationEcoulement +
                      ',' +
                      widget.selectedOuvrage.precisionPerturbationEcoulement +
                      ',' +
                      widget.selectedOuvrage.defautEtancheite +
                      ',' +
                      widget.selectedOuvrage.tracesInfiltration +
                      ',' +
                      widget.selectedOuvrage.branchementNonEtanche +
                      ',' +
                      widget.selectedOuvrage.defautStructure +
                      ',' +
                      widget.selectedOuvrage.genieCivilFissure +
                      ',' +
                      widget.selectedOuvrage.deboitement +
                      ',' +
                      widget.selectedOuvrage.defautFermeture +
                      ',' +
                      widget.selectedOuvrage.tamponDeteriore +
                      ',' +
                      widget.selectedOuvrage.presenceH2S +
                      ',' +
                      widget.selectedOuvrage.observationsAnomalies;
                  storage.writeData(
                      ouvrageData,
                      widget.selectedNumeroAffaire.numeroAffaire,
                      widget.selectedOuvrage.refOuvrage);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MenuOuvrage(
                              widget.selectedNumeroAffaire,
                              widget.selectedCommune)));
                },
              )
            ],
          );
        });
  }

  Widget build(BuildContext context) {
    Config().init(context);
    return new Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        title: Text(widget.selectedOuvrage.refOuvrage),
        centerTitle: true,
      ),
      body: [
        Localisation(widget.selectedOuvrage),
        Caractere(widget.selectedOuvrage),
        LandingScreen(widget.selectedOuvrage, widget.selectedNumeroAffaire),
        Anomalie(widget.selectedOuvrage),
      ].elementAt(currentIndex),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialog();
        },
        child: Icon(
          Icons.check,
          size: 25,
        ),
        backgroundColor: Config.buttonColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BubbleBottomBar(
          backgroundColor: Config.bottomBarColor,
          opacity: .2,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          elevation: 2,
          fabLocation: BubbleBottomBarFabLocation.end, //new
          hasNotch: true, //new
          hasInk: true, //new, gives a cute ink effect
          inkColor: Colors.black12, //optional, uses
          currentIndex: currentIndex,
          items: <BubbleBottomBarItem>[
            BubbleBottomBarItem(
              backgroundColor: Colors.red,
              icon: Icon(
                Icons.map,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.map,
                color: Colors.red,
              ),
              title: Text(
                "Localisation",
                style: TextStyle(
                    fontSize: Config.fontSize / 1.5, color: Colors.red),
              ),
            ),
            BubbleBottomBarItem(
                backgroundColor: Colors.deepPurple,
                icon: Icon(
                  Icons.assignment,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.assignment,
                  color: Colors.deepPurple,
                ),
                title: Text(
                  "Caractéristiques",
                  style: TextStyle(
                      fontSize: Config.fontSize / 1.5,
                      color: Colors.deepPurple),
                )),
            BubbleBottomBarItem(
                backgroundColor: Colors.lightBlue,
                icon: Icon(
                  Icons.add_a_photo,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.add_a_photo,
                  color: Colors.lightBlue,
                ),
                title: Text(
                  "Schéma",
                  style: TextStyle(
                      fontSize: Config.fontSize / 1.5, color: Colors.indigo),
                )),
            BubbleBottomBarItem(
                backgroundColor: Colors.green,
                icon: Icon(
                  Icons.new_releases,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.new_releases,
                  color: Colors.green,
                ),
                title: Text(
                  "Anomalies",
                  style: TextStyle(
                      fontSize: Config.fontSize / 1.5, color: Colors.green),
                ))
          ],
          onTap: (newIndex) {
            setState(() {
              currentIndex = newIndex;
            });
          }),
    );
  }
}
