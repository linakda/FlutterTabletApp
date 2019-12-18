import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geo_diagnostique_app/Affaire.dart';
import 'package:geo_diagnostique_app/Commune.dart';
import 'package:geo_diagnostique_app/Config.dart';
import 'package:geo_diagnostique_app/FeuilleOuvrage.dart';
import 'package:geo_diagnostique_app/MenuAffaire.dart';
import 'package:geo_diagnostique_app/Ouvrage.dart';
import 'package:geo_diagnostique_app/main.dart';

class MenuOuvrage extends StatefulWidget {
  final NumeroAffaire selectedNumeroAffaire;
  final Commune selectedCommune;
  MenuOuvrage(this.selectedNumeroAffaire, this.selectedCommune);
  @override
  MenuOuvrageState createState() => MenuOuvrageState();
}

class MenuOuvrageState extends State<MenuOuvrage> {
  List<Ouvrage> listOuvrage = new List<Ouvrage>();
  List<String> listTypeOuvrage;
  int exitCode=0;
  List colors;
  List<Ouvrage> _searchOuvragelist = new List<Ouvrage>();
  bool _searchMode = false;
  @override
  void initState() {
    super.initState();
    listOuvrage = widget.selectedCommune.listOuvrage;
    colors = [
      Colors.brown,
      Colors.blue,
      Colors.green,
      Config.textColor,
      Colors.redAccent,
      Colors.redAccent
    ];
    listTypeOuvrage = <String>[
      'séparatif EU',
      'séparatif EP',
      'unitaire',
      'autre :',
      'sous enrobé',
      'sous véhicule'
    ];
  }

  Color switchColor(String typeOuvrage) {
    int index = listTypeOuvrage.indexOf(typeOuvrage);
    if (index == -1)
      return Colors.grey;
    else
      return colors[index];
  }

  //Creér une nouvelle liste suite à la recherche d'une commune ou d'un numéro d'affaire
  void _updateSearcOuvrageList(String searchElement) {
    _searchOuvragelist = new List<Ouvrage>();
    for (int i = 0; i < listOuvrage.length; i++) {
      if (listOuvrage[i].refOuvrage.contains(searchElement)) {
        _searchOuvragelist.add(listOuvrage[i]);
        print(listOuvrage[i].refOuvrage);
      }
    }
    print("taille de ma list de recherche = ${_searchOuvragelist.length}");
  }

  @override
  Widget build(BuildContext context) {
    if(exitCode==1){
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
    //Method qui permet de trouver l'indice de l'ouvrage
    listOuvrage = widget.selectedCommune.listOuvrage;

    Config().init(context);
    return new Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            }),
        backgroundColor: Config.color,
        title: Text(
          widget.selectedCommune.nomCommune,
          style: TextStyle(fontSize: Config.fontSize),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            storage.addREFOuvrage(
                widget.selectedNumeroAffaire.numeroAffaire,
                widget.selectedCommune.nomCommune,
                widget.selectedCommune.refCommune,
                widget.selectedCommune.refCommune +
                    storage.nextRefOuvrage(widget.selectedCommune));
          });
        },
        backgroundColor: Config.buttonColor,
        splashColor: Config.splashColor,
        tooltip: 'Image',
        label: Icon(Icons.plus_one),
      ),
      body: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(Config.screenPadding),
              child: TextField(
                cursorColor: Config.color,
                style: TextStyle(fontSize: Config.fontSize),
                decoration: InputDecoration(
                  labelText: "Rechercher un ouvrage",
                  labelStyle: TextStyle(
                      color: Config.textColor, fontSize: Config.fontSize / 1.5),
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
                textCapitalization: TextCapitalization.characters,
                onChanged: (String text) {
                  if (listOuvrage.isNotEmpty) {
                    setState(() {
                      _searchMode = true;
                      _updateSearcOuvrageList(text);
                    });
                    if (text == "") {
                      _searchMode = false;
                    }
                  }
                },
              )),
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: ListView.builder(
                reverse: true,
                shrinkWrap: true,
                itemCount: !_searchMode
                    ? listOuvrage.length
                    : _searchOuvragelist.length,
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                    key: Key(listOuvrage[index].refOuvrage),
                    background: Container(
                      color: Colors.white,
                    ),
                    secondaryBackground: Container(
                      alignment: Alignment.centerRight,
                      color: Colors.redAccent,
                      child: Padding(
                        padding: EdgeInsets.only(right: Config.screenPadding),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: Config.fontSize,
                        ),
                      ),
                    ),
                    confirmDismiss: (direction) async {
                      if (direction == DismissDirection.endToStart) {
                        final bool res = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: new Text(
                                  "Confirmation de suppression :",
                                  style: TextStyle(
                                      fontSize: Config.fontSize / 1.3),
                                ),
                                content: new Text(
                                  "Etes-vous sûr de vouloir supprimer la REFOuvrage ?",
                                  style: TextStyle(
                                      fontSize: Config.fontSize / 1.3),
                                ),
                                actions: <Widget>[
                                  new FlatButton(
                                      child: new Text(
                                        "Annuler",
                                        style: TextStyle(
                                            fontSize: Config.fontSize / 1.5),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      }),
                                  new FlatButton(
                                      child: new Text(
                                        "Supprimer",
                                        style: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: Config.fontSize / 1.3),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          exitCode = storage.deleteOuvrage(
                                              widget.selectedNumeroAffaire,
                                              widget.selectedCommune,
                                              listOuvrage[index].refOuvrage,
                                              context);
                                          Navigator.of(context).pop();
                                        });

                                      })
                                ],
                              );
                            });
                        return res;
                      }
                      return null;
                    },
                    child: new Card(
                      elevation: 10,
                      color: listOuvrage[index].defautFermeture != ""
                          ? Colors.red
                          : switchColor(listOuvrage[index].typeReseau),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      margin: new EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 6.0),
                      child: new ListTile(
                        leading: Container(
                          padding: EdgeInsets.only(right: 12.0),
                          child: Icon(
                            Icons.account_circle,
                            color: Colors.white,
                            size: Config.fontSize * 1.5,
                          ),
                        ),
                        title: Text(
                          !_searchMode
                              ? listOuvrage[index].refOuvrage
                              : _searchOuvragelist[index].refOuvrage,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: Config.fontSize * 1.5),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FeuilleOuvrage(
                                        widget.selectedNumeroAffaire,
                                        widget.selectedCommune,
                                        !_searchMode
                                            ? listOuvrage[index]
                                            : _searchOuvragelist[index],
                                      )));
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
