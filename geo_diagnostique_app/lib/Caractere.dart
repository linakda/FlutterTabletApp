import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:geo_diagnostique_app/Anomalies.dart';
import 'package:geo_diagnostique_app/FicheOuvrage.dart';
import 'package:geo_diagnostique_app/Localisation.dart';
import 'package:geo_diagnostique_app/Schema.dart';
import 'package:geo_diagnostique_app/Size.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';


class Caractere extends StatelessWidget{
  FicheOuvrage ouvrage = new FicheOuvrage();
  SizeConfig size = new SizeConfig();
  TextStyle textSize = new TextStyle(fontSize: SizeConfig.fontSize);
  Color color = Colors.teal[700];
  EdgeInsetsGeometry textPadding = EdgeInsets.all(SizeConfig.screenPadding);
  int navigationIndex;
  TextEditingController communeController = TextEditingController();
  TextEditingController rueController = TextEditingController();
  final int currentIndex=1;
  
  
  Widget build(BuildContext context){
   
    SizeConfig().init(context);
    return new Scaffold(
     

      body: Container(
        padding: EdgeInsets.all(10.0),
      child: Column( children:[

 new DropdownButton<String>(
   
        hint: Text('Type'),
        items: <String>['regard', 'regard avaloir', 'avaloir', 'grille', 'boîte de branchement', 'autre'].map((String value) {
          return new DropdownMenuItem<String>(
            child: SizedBox(width: 320.0, 
            child: Text(value, textAlign: TextAlign.left,)
            ,),
              value: value,
             // child: new Text(value),
          );
        }).toList(),
        onChanged: (_) {},
      ),
  Padding(
              padding: const EdgeInsets.only(bottom: 9.0),
                child: TextField(
                  style: TextStyle(fontSize: 15.5),
                 controller: rueController,  
                  onChanged: (v) => rueController.text = v,
                  decoration: InputDecoration(
                  labelText: 'Observations',
              )),
          ),


 new DropdownButton<String>(
        hint: Text('Dispositif de fermeture'),
        items: <String>['fonte', 'béton', 'autre: ', ].map((String value) {
          return new DropdownMenuItem<String>(
             child: SizedBox(width: 320.0, 
            child: Text(value, textAlign: TextAlign.left,)
            ,),
              value: value,
            //  child: new Text(value),
          );
        }).toList(),
        onChanged: (_) {},
      ),

 new DropdownButton<String>(
        hint: Text('Section (cheminée)'),
        items: <String>['Circulaire', 'rectangulaire'].map((String value) {
          return new DropdownMenuItem<String>(
             child: SizedBox(width: 320.0, 
            child: Text(value, textAlign: TextAlign.left,)
            ,),
              value: value,
            //  child: new Text(value),
          );
        }).toList(),
        onChanged: (_) {},
      ),
       new DropdownButton<String>(
        hint: Text('Nature (cheminée)'),
        items: <String>['préfabriquée', 'maçonnée', 'PVC' , 'autre : '].map((String value) {
          return new DropdownMenuItem<String>(
             child: SizedBox(width: 320.0, 
            child: Text(value, textAlign: TextAlign.left,)
            ,),
              value: value,
            //  child: new Text(value),
          );
        }).toList(),
        onChanged: (_) {},
      ),
      
       Padding(
              padding: const EdgeInsets.only(bottom: 9.0),
                child: TextField(
                style: TextStyle(fontSize: 15.5),
                 controller: rueController,  
                  onChanged: (v) => rueController.text = v,
                  decoration: InputDecoration(
                  labelText: 'Dimension (cheminée)',
                  hintText: 'ex: 1000mm',
              )),
          ),
           new DropdownButton<String>(
        hint: Text('Dispositif daccès'),
        items: <String>['présence dechelons', 'présence dune crosse'].map((String value) {
          return new DropdownMenuItem<String>(
             child: SizedBox(width: 320.0, 
            child: Text(value, textAlign: TextAlign.left,)
            ,),
              value: value,
            //  child: new Text(value),
          );
        }).toList(),
        onChanged: (_) {},
      ),
       new DropdownButton<String>(
        hint: Text('Cunette'),
        items: <String>['préfabriquée', 'maçonnée', 'absence de cunette'].map((String value) {
          return new DropdownMenuItem<String>(
             child: SizedBox(width: 320.0, 
            child: Text(value, textAlign: TextAlign.left,)
            ,),
              value: value,
            //  child: new Text(value),
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