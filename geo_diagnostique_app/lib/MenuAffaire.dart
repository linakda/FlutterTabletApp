
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geo_diagnostique_app/Affaire.dart';
import 'package:geo_diagnostique_app/Commune.dart';
import 'package:geo_diagnostique_app/CreationREF.dart';
import 'package:geo_diagnostique_app/Size.dart';


class MenuAffaire extends StatefulWidget{
 MenuAffaireState createState() => MenuAffaireState(); 
}
class MenuAffaireState extends State<MenuAffaire>{
  
  List<NumeroAffaire> _listNumeroAffaire= new List<NumeroAffaire>();

  @override
  initState(){
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _addNumAffaire(String numeroAffaire,String nomCommune){
    int _index;
    Commune _nouvelCommune = new Commune(nomCommune);
    bool _isNouveauNumAffaire = true;
    bool _isNouvelCommune = true;
    setState(() {
      for(_index=0;_index<_listNumeroAffaire.length;_index++){
        if(_listNumeroAffaire[_index].numeroAffaire == numeroAffaire){
          //numéro d'affaire déjà existant
          for(int k=0;k<_listNumeroAffaire[_index].listCommune.length;k++){
            if(_listNumeroAffaire[_index].listCommune[k].nomCommune == nomCommune){
              //nom de commune déjà existant
              _isNouvelCommune = false;
              break;
            }
          }
          _isNouveauNumAffaire = false;
          break;
        }
      }
      //Si on a parcouru toute la liste et qu'aucun numéro d'affaire en ai ressortie alors:
      if(_isNouveauNumAffaire){
        // - un nouveau numéro d'affaire à la liste
        _listNumeroAffaire.add(new NumeroAffaire(numeroAffaire,));
        // - une fois celui-ci créer on lui ajoute une nouvelle commune
        _listNumeroAffaire[_listNumeroAffaire.length-1].addCommune(_nouvelCommune);
      }
      else if(_isNouvelCommune){
        //on se trouve dans le cas ou on ajoute une commune à un numéro d'affaire déjà existant
        _listNumeroAffaire[_index].addCommune(_nouvelCommune);
      }
    });
  }

  List<Card> listCommuneGenerator(List<Commune> list){
    List<Card> _listCardCommune = new List<Card>();

    for(int index=0;index<list.length;index++){
       _listCardCommune.add(
        new Card(
           elevation: 10,
           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),),
           margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
           child: new ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                leading: Container(
                  padding: EdgeInsets.only(right: 12.0),
                  child: Icon(Icons.account_circle, color: Colors.grey[700],size: SizeConfig.fontSize,),
                ),
                title: Text(
                  list[index].nomCommune,
                  style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold,fontSize: SizeConfig.fontSize),
                ),
                subtitle: Text("Nombre de commune",style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold,fontSize: SizeConfig.fontSize/3),),
                trailing:Icon(Icons.keyboard_arrow_right, color: Colors.grey[700], size: SizeConfig.fontSize)
              ),
        )
      ); 
    }
    return _listCardCommune;
  }
  
  @override
  Widget build(BuildContext context){
    SizeConfig().init(context);
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "Menu d'affaire",
          style: TextStyle(fontSize: SizeConfig.fontSize),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _listNumeroAffaire.length,
        itemBuilder: (BuildContext context, int index){
          return new Card(
           elevation: 10,
           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),),
           margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
           child: new ExpansionTile(
                leading: Container(
                  padding: EdgeInsets.only(right: 12.0),
                  child: Icon(Icons.account_circle, color: Colors.grey[700],size: SizeConfig.fontSize*1.5,),
                ),
                title: Text(
                  _listNumeroAffaire[index].numeroAffaire,
                  style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold,fontSize: SizeConfig.fontSize*1.5),
                ),
                children: listCommuneGenerator(_listNumeroAffaire[index].listCommune),
            ),
          ); 
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreationREF(_addNumAffaire)),);
        },
        backgroundColor: Colors.orangeAccent,
        tooltip: 'Image',
        icon: Icon(Icons.add_circle),
        label:Text("Nouvelle ouvrage",style: TextStyle(fontSize: SizeConfig.fontSize/1.5),),
      ),
    );
  }

  
}