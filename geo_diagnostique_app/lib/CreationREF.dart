import 'package:flutter/material.dart';

class CreationREF extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      key: _scaffoldKey,
      appBar:AppBar(
        title: Text('Création d\'une référence'),
        backgroundColor:Colors.teal[700],
      ),
      body: Center(
        child: Column(
          children:[
          TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'N°Affaire',
            ),
          ),
          TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Commune',
            ),
          ),
          TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Réf. Commune',
            ),
          ),
          TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Réf. Ouvrage',
            ),
          ),
          RaisedButton(
            onPressed: (){
              
              _scaffoldKey.currentState.showSnackBar(
                SnackBar(
                  duration: new Duration(seconds: 3),
                  backgroundColor: Colors.blueGrey,
                  content: Text('Ajouter avec Succés !'),
                  action: SnackBarAction(
                    label: 'Annuler',
                    textColor: Colors.redAccent,
                    onPressed: (){
                      //Code pour annuler l'ajout
                    },
                  ),
                ),
              );
            },
            child: Text('Ajouter la Réf.'),
          )
        ]),
      ),
    );
  }
}