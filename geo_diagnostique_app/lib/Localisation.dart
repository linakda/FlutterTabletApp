import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:geo_diagnostique_app/FicheOuvrage.dart';
import 'package:geo_diagnostique_app/Size.dart';


class Localisation extends StatefulWidget{
  @override
  LocalisationState createState() => LocalisationState();
}
class LocalisationState extends State<Localisation> {
  FicheOuvrage ouvrage = new FicheOuvrage();
  SizeConfig size = new SizeConfig();
  TextStyle textSize = new TextStyle(fontSize: SizeConfig.fontSize);
  Color color = Colors.teal[700];
  EdgeInsetsGeometry textPadding = EdgeInsets.all(SizeConfig.screenPadding);
  int navigationIndex;
  final int currentIndex=0;
  TextEditingController communeController = TextEditingController();
  TextEditingController rueController = TextEditingController();
  




  @override
  Widget build(BuildContext context){
   
    SizeConfig().init(context);
    return new Scaffold(
      

      body: Container(
        
      child: Column( children:[
  Padding(
              padding: const EdgeInsets.only(bottom: 9.0),
                child: TextField(
                 controller: rueController,  
                  onChanged: (v) => rueController.text = v,
                  decoration: InputDecoration(
                  labelText: 'Commune',
              )),
          ),
 Padding(
              padding: const EdgeInsets.only(bottom: 9.0),
                child: TextField(
                 controller: rueController,  
                  onChanged: (v) => rueController.text = v,
                  decoration: InputDecoration(
                  labelText: 'Nom de la rue',
              )),
          ),

 new DropdownButton<String>(
        hint: Text('Implantation'),
        items: <String>['chaussée', 'trottoir', 'accotement', 'terrain naturel', 'domaine privé'].map((String value) {
          return new DropdownMenuItem<String>(
              value: value,
              child: new Text(value),
          );
        }).toList(),
        onChanged: (_) {},
      ),

 new DropdownButton<String>(
        hint: Text('Type de réseau'),
        items: <String>['séparatif EU', 'séparatif EP', 'unitaire', 'autre : '].map((String value) {
          return new DropdownMenuItem<String>(
              value: value,
              child: new Text(value),
          );
        }).toList(),
        onChanged: (_) {},
      ),
 ], //Children
        ),
      ),
  
    );


 }

}