import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geo_diagnostique_app/Affaire.dart';
import 'package:geo_diagnostique_app/Commune.dart';
import 'package:geo_diagnostique_app/Config.dart';
import 'package:geo_diagnostique_app/FeuilleOuvrage.dart';
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
  
  @override
  void initState() {
    super.initState();
    listOuvrage = widget.selectedCommune.listOuvrage.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Config.color,
        title: Text(
          widget.selectedNumeroAffaire.numeroAffaire,
          style: TextStyle(fontSize: Config.fontSize),
        ),
        centerTitle: true,
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
              )),
          Expanded(
            child: ListView.builder(
              itemCount: listOuvrage.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key:
                      Key(listOuvrage[index].refOuvrage),
                  background: Container(
                    alignment: Alignment.centerLeft,
                    color: Config.color,
                    child: Padding(
                        padding: EdgeInsets.only(left: Config.screenPadding),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: Config.fontSize,
                        )),
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
                                style:
                                    TextStyle(fontSize: Config.fontSize / 1.3),
                              ),
                              content: new Text(
                                "Etes-vous sûr de vouloir supprimer la REFOuvrage ?",
                                style:
                                    TextStyle(fontSize: Config.fontSize / 1.3),
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
                                        storage.deleteOuvrage(
                                            widget.selectedNumeroAffaire,
                                            widget.selectedCommune,
                                            index,
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
                    color: Config.textColor,
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
                        listOuvrage[index].refOuvrage,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: Config.fontSize * 1.5),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FeuilleOuvrage(widget.selectedNumeroAffaire,widget.selectedCommune,listOuvrage[index])));
                      },
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
