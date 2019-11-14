
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geo_diagnostique_app/Affaire.dart';
import 'package:geo_diagnostique_app/Commune.dart';
import 'package:geo_diagnostique_app/Config.dart';
import 'package:geo_diagnostique_app/FeuilleOuvrage.dart';
import 'package:geo_diagnostique_app/Storage.dart';

class MenuOuvrage extends StatefulWidget{
  final NumeroAffaire selectedNumeroAffaire;
  final Commune selectedCommune;
  MenuOuvrage(this.selectedNumeroAffaire,this.selectedCommune);
  @override
  MenuOuvrageState createState() => MenuOuvrageState(); 
}

class MenuOuvrageState extends State<MenuOuvrage>{
  @override
  Widget build(BuildContext context){
    Config().init(context);
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Config.color,
        title: Text(
          "Menu d'affaire",
          style: TextStyle(fontSize: Config.fontSize),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(Config.screenPadding),
            child:TextField(
              cursorColor: Config.color,
                style: TextStyle(fontSize: Config.fontSize),
                decoration: InputDecoration(
                  labelText: "Ajouter un nouvel ouvrage",
                  labelStyle: TextStyle(color: Config.textColor,fontSize: Config.fontSize/1.5),
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
              )) ,         

          Expanded(
            child: ListView.builder(
              itemCount: widget.selectedCommune.listOuvrage.length,
              itemBuilder: (BuildContext context, int index){
                return new Card(
                elevation: 10,
                color: Config.textColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),),
                margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child: new ListTile(
                      leading: Container(
                        padding: EdgeInsets.only(right: 12.0),
                        child: Icon(Icons.account_circle, color: Colors.white,size: Config.fontSize*1.5,),
                      ),
                      title: Text(
                        widget.selectedCommune.listOuvrage[index].refOuvrage,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: Config.fontSize*1.5),
                      ),
                      onTap: ()  {
                         Navigator.push(context, MaterialPageRoute(
                           builder: (context) => FeuilleOuvrage()));
                      },
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