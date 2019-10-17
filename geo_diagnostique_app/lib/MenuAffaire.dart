
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geo_diagnostique_app/Affaire.dart';
import 'package:geo_diagnostique_app/Commune.dart';
import 'package:geo_diagnostique_app/CreationREF.dart';
import 'package:geo_diagnostique_app/Size.dart';
import 'package:geo_diagnostique_app/main.dart';

class MenuAffaire extends StatefulWidget{
 MenuAffaireState createState() => MenuAffaireState(); 
}
class MenuAffaireState extends State<MenuAffaire>{
  List<NumeroAffaire> _listNumeroAffaire= new List<NumeroAffaire>();
  List<Commune> _listCommune = new List<Commune>();
  List<Card> _listTile = new List<Card>();


  @override
  initState(){
    super.initState();
  }
  void _addNumAffaire(String numeroAffaire,String nomCommune){
    setState(() {
      _listNumeroAffaire.add(
        new NumeroAffaire(numeroAffaire)
      );
      _listTile.add(
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
                  nomCommune,
                  style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold,fontSize: SizeConfig.fontSize),
                ),
                subtitle: Text("Nombre de commune",style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold,fontSize: SizeConfig.fontSize/3),),
                trailing:Icon(Icons.keyboard_arrow_right, color: Colors.grey[700], size: SizeConfig.fontSize)
              ),
        )
      ); 
    });
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
                  _listNumeroAffaire[index].name,
                  style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold,fontSize: SizeConfig.fontSize*1.5),
                ),
                children: _listTile,
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