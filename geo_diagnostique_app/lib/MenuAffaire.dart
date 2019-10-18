
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

  void _addNumAffaire(String numeroAffaire,String nomCommune,String refCommune){
    Commune _nouvelCommune = new Commune(nomCommune,refCommune);

    setState(() {
      if (_isAffaireExist(_listNumeroAffaire, numeroAffaire) != null){
        //numero d'affaire déjà existant
        int index = _isAffaireExist(_listNumeroAffaire, numeroAffaire);
        if(!_isCommuneExist(_listNumeroAffaire[index].listCommune, nomCommune)){
          //si la commune n'existe pas
          _listNumeroAffaire[index].addCommune(_nouvelCommune);
        }
      }
      else{
        //numéro d'affaire non-existant
        _listNumeroAffaire.add(new NumeroAffaire(numeroAffaire,));
        _listNumeroAffaire[_listNumeroAffaire.length-1].addCommune(_nouvelCommune);
      }
    });
  }

  int _isAffaireExist(List<NumeroAffaire> listNumeroAffaire, String numero){
    if(listNumeroAffaire.isNotEmpty){
      for(int index=0;index<_listNumeroAffaire.length;index++){
        if(listNumeroAffaire[index].numeroAffaire == numero){return index;}
      }
    }
    return null;
  }

  bool _isCommuneExist(List<Commune> listCommune, String nomCommune){
    if(listCommune.isNotEmpty){
      for(int index=0;index<listCommune.length;index++){
          if(listCommune[index].nomCommune == nomCommune){return true;}
      }
    }
    return false;
  }

  List<Card> listCommuneGenerator(List<Commune> list){
    List<Card> _listCardCommune = new List<Card>();

    for(int index=0;index<list.length;index++){
       _listCardCommune.add(
        new Card(
           elevation: 10,
           color: Colors.white,
           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),),
           margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
           child: new ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                leading: Container(
                  padding: EdgeInsets.only(right: 12.0),
                  child: Icon(Icons.location_city, color: Colors.grey[600],size: SizeConfig.fontSize,),
                ),
                title: Text(
                  list[index].nomCommune,
                  style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold,fontSize: SizeConfig.fontSize),),
                subtitle: Text(
                  list[index].refCommune,
                  style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold)),

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
           color: Colors.grey[600],
           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),),
           margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
           child: new ExpansionTile(
                leading: Container(
                  padding: EdgeInsets.only(right: 12.0),
                  child: Icon(Icons.account_circle, color: Colors.white,size: SizeConfig.fontSize*1.5,),
                ),
                title: Text(
                  _listNumeroAffaire[index].numeroAffaire,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: SizeConfig.fontSize*1.5),
                ),
                children: listCommuneGenerator(_listNumeroAffaire[index].listCommune),
            ),
          ); 
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreationREF(_addNumAffaire,_listNumeroAffaire)),);
        },
        backgroundColor: Colors.orangeAccent,
        tooltip: 'Image',
        icon: Icon(Icons.add_circle),
        label:Text("Nouvel ouvrage",style: TextStyle(fontSize: SizeConfig.fontSize/1.5),),
      ),
    );
  }

  
}