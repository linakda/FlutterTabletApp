import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:GeoREF/Affaire.dart';
import 'package:GeoREF/Commune.dart';
import 'package:GeoREF/CreationREF.dart';
import 'package:GeoREF/Config.dart';
import 'package:GeoREF/MenuOuvrage.dart';
import 'package:GeoREF/main.dart';

class MenuAffaire extends StatefulWidget {
  MenuAffaireState createState() => MenuAffaireState();
}

class MenuAffaireState extends State<MenuAffaire> {
  List<NumeroAffaire> _searchNumeroAffairelist = new List<NumeroAffaire>();
  String state;
  bool _searchMode = false;
  Commune _communeSearch;

  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //Creér une nouvelle liste suite à la recherche d'une commune ou d'un numéro d'affaire
  void _updateSearchAffaireList(String searchElement) {
    _searchNumeroAffairelist = new List<NumeroAffaire>();
    for (int i = 0; i < listNumeroAffaire.length; i++) {
      if (listNumeroAffaire[i].numeroAffaire.contains(searchElement)) {
        _searchNumeroAffairelist.add(listNumeroAffaire[i]);
      } else {
        for (var k = 0; k < listNumeroAffaire[i].listCommune.length; k++) {
          if (listNumeroAffaire[i]
              .listCommune[k]
              .nomCommune
              .contains(searchElement)) {
            _searchNumeroAffairelist.add(listNumeroAffaire[i]);
            _communeSearch = listNumeroAffaire[i].listCommune[k];
          }
        }
      }
    }
  }

  //Méthode qui génère la sous-liste des communes par num d'affaire
  List<Card> listCommuneGenerator(NumeroAffaire numeroAffaire,
      List<Commune> listCommune, BuildContext context) {
    List<Card> _listCardCommune = new List<Card>();
    int length = listCommune.length;

    //si une commune a été rechercher alors il suffit de générer une seule card avec le nom de commune correspondant
    if (_communeSearch != null) {
      length = 1;
    }
    for (var i = 0; i < length; i++) {
      _listCardCommune.add(new Card(
        elevation: 10,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: new ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            child: Icon(
              Icons.location_city,
              color: Config.textColor,
              size: Config.fontSize,
            ),
          ),
          title: Text(
            _communeSearch != null
                ? _communeSearch.nomCommune
                : listCommune[i].nomCommune,
            style: TextStyle(
                color: Config.textColor,
                fontWeight: FontWeight.bold,
                fontSize: Config.fontSize),
          ),
          subtitle: Text(
              _communeSearch != null
                  ? _communeSearch.refCommune
                  : listCommune[i].refCommune,
              style: TextStyle(
                  color: Config.textColor, fontWeight: FontWeight.bold)),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MenuOuvrage(
                        numeroAffaire,
                        _communeSearch != null
                            ? _communeSearch
                            : listCommune[i])));
          },
        ),
      ));
    }
    return _listCardCommune;
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Config.appBarColor,
        title: Text(
          "Menu d'affaire",
          style: TextStyle(fontSize: Config.fontSize),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreationREF()),
          );
        },
        backgroundColor: Config.buttonColor,
        splashColor: Config.splashColor,
        tooltip: 'Image',
        icon: Icon(Icons.add_circle),
        label: Text(
          "Nouvel ouvrage",
          style: TextStyle(fontSize: Config.fontSize / 1.5),
        ),
      ),
      body: Column(
        children: <Widget>[
          listNumeroAffaire.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.all(Config.screenPadding),
                  child: TextField(
                    cursorColor: Config.appBarColor,
                    style: TextStyle(fontSize: Config.fontSize),
                    decoration: InputDecoration(
                      labelText:
                          "Rechercher une commune ou un numéro d'affaire",
                      labelStyle: TextStyle(
                          color: Config.textColor,
                          fontSize: Config.fontSize / 1.5),
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
                      if (listNumeroAffaire.isNotEmpty) {
                        setState(() {
                          _searchMode = true;
                          _updateSearchAffaireList(text);
                        });
                        if (text == "") {
                          _searchMode = false;
                          _communeSearch = null;
                        }
                      }
                    },
                    textCapitalization: TextCapitalization.characters,
                  ))
              : Padding(
                  padding: EdgeInsets.all(Config.screenPadding),
                ),
          Expanded(
            child: ListView.builder(
              itemCount: !_searchMode
                  ? listNumeroAffaire.length
                  : _searchNumeroAffairelist.length,
              itemBuilder: (BuildContext context, int index) {
                return new Card(
                  elevation: 10,
                  color: Config.textColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  margin:
                      new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  child: new ExpansionTile(
                    leading: Container(
                        padding: EdgeInsets.only(right: 12.0),
                        child: Icon(
                          Icons.account_circle,
                          color: Colors.white,
                          size: Config.fontSize * 1.5,
                        )),
                    title: Text(
                      !_searchMode
                          ? listNumeroAffaire[index].numeroAffaire
                          : _searchNumeroAffairelist[index].numeroAffaire,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: Config.fontSize * 1.5),
                    ),
                    children: listCommuneGenerator(
                        listNumeroAffaire[index],
                        !_searchMode
                            ? listNumeroAffaire[index].listCommune
                            : _searchNumeroAffairelist[index].listCommune,
                        context),
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
