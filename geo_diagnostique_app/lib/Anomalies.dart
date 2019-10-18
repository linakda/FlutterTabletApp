import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:geo_diagnostique_app/FicheOuvrage.dart';
import 'package:geo_diagnostique_app/Size.dart';



class Anomalie extends StatefulWidget{
  @override
  AnomalieState createState() => AnomalieState();
}
  
  class AnomalieState extends State<Anomalie> { 
    
  FicheOuvrage ouvrage = new FicheOuvrage();
  SizeConfig size = new SizeConfig();
  TextStyle textSize = new TextStyle(fontSize: SizeConfig.fontSize);
  EdgeInsetsGeometry textPadding = EdgeInsets.all(SizeConfig.screenPadding);
  final int currentIndex=0;
  TextEditingController communeController = TextEditingController();
  TextEditingController rueController = TextEditingController();
  




  @override
  Widget build(BuildContext context){
   
    SizeConfig().init(context);
    return new Scaffold(
      

      body: Container(
        
      child: Column( children:[
 
 

 new DropdownButton<String>(
        hint: Text('Traces de mise en charge'),
        items: <String>['Oui', 'Non'].map((String value) {
          return new DropdownMenuItem<String>(
              value: value,
              child: new Text(value),
          );
        }).toList(),
        onChanged: (_) {},
      ),

 new DropdownButton<String>(
        hint: Text('Perturbation de lécoulement'),
        items: <String>['Oui', 'Non', 'préciser : '].map((String value) {
          return new DropdownMenuItem<String>(
              value: value,
              child: new Text(value),
          );
        }).toList(),
        onChanged: (_) {},
      ),
 new DropdownButton<String>(
        hint: Text('Défaut detanchétié'),
        items: <String>['Oui', 'Non', 'traces dinfiltration', 'branche '].map((String value) {
          return new DropdownMenuItem<String>(
              value: value,
              child: new Text(value),
          );
        }).toList(),
        onChanged: (_) {},
      ),
 new DropdownButton<String>(
        hint: Text('Défaut de structure'),
        items: <String>['séparatif EU', 'séparatif EP', 'unitaire', 'autre : '].map((String value) {
          return new DropdownMenuItem<String>(
              value: value,
              child: new Text(value),
          );
        }).toList(),
        onChanged: (_) {},
      ),
 new DropdownButton<String>(
        hint: Text('Défaut de fermeture'),
        items: <String>['séparatif EU', 'séparatif EP', 'unitaire', 'autre : '].map((String value) {
          return new DropdownMenuItem<String>(
              value: value,
              child: new Text(value),
          );
        }).toList(),
        onChanged: (_) {},
      ),
 new DropdownButton<String>(
        hint: Text('Présence de H2S'),
        items: <String>['séparatif EU', 'séparatif EP', 'unitaire', 'autre : '].map((String value) {
          return new DropdownMenuItem<String>(
              value: value,
              child: new Text(value),
          );
        }).toList(),
        onChanged: (_) {},
      ),

      Padding(
              padding: const EdgeInsets.only(bottom: 9.0),
                child: TextField(
                 controller: rueController,  
                  onChanged: (v) => rueController.text = v,
                  decoration: InputDecoration(
                  labelText: 'Autres observations',
              )),
          ),
 ], //Children
        ),
      ),
  
    );
  }

}