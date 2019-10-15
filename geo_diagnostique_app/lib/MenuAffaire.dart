
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geo_diagnostique_app/CreationREF.dart';
import 'package:geo_diagnostique_app/Size.dart';

class MenuAffaire extends StatelessWidget{
  final List<ListTile> listNumeroAffaire = new List(5);
  
  Widget build(BuildContext context){
    listGenerator(context);
    SizeConfig().init(context);
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Text("Menu d'affaire"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(5),
        children: listNumeroAffaire,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreationREF()),);
        },
        backgroundColor: Colors.orangeAccent,
        tooltip: 'Image',
        child: Icon(Icons.add_box),
      ),
    );
  }

  void listGenerator( BuildContext context){
    for(int i=0;i<5;i++){
      listNumeroAffaire[i] = ListTile(
        leading: Icon(Icons.filter_frames),
        title: Text("Numero d'affaire $i"),
        onTap: (){},

      );
    }
  }
}