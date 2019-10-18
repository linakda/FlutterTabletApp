
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:geo_diagnostique_app/Anomalies.dart';
import 'package:geo_diagnostique_app/Caractere.dart';
import 'package:geo_diagnostique_app/Localisation.dart';
import 'package:geo_diagnostique_app/Schema.dart';
import 'package:geo_diagnostique_app/Config.dart';


class FeuilleOuvrage extends StatefulWidget{
@override
  FeuilleOuvrageState createState() => FeuilleOuvrageState();
}

enum ConfirmAction { Annuler, Valider }

class FeuilleOuvrageState extends State<FeuilleOuvrage> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  int currentIndex=0;
  
  @override
  initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => 
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        duration: new Duration(seconds: 3),
        backgroundColor: Config.color,
        content: Text(
          'Ajouter avec Succés !',
          style: TextStyle(fontSize: Config.fontSize / 2),
        ),
        action: SnackBarAction(
          label: 'Annuler',
          textColor: Config.buttonColor,
          onPressed: () {
            //Code pour annuler l'ajout
          },
        ),
      )
    ));
  }

  //Création d'une boîte AlertDialog après validation du formulaire
  Future<ConfirmAction>  _asyncConfirmDialog(BuildContext context) async {
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false,  // taper bouton pour fermer la fenêtre
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Valider le formulaire?'),
          content: const Text("Le fomulaire sera enregistré dans son intégralité"),
          actions: <Widget>[
            FlatButton(
              child: const Text("Annuler"),
            onPressed: () {
            Navigator.of(context).pop(ConfirmAction.Annuler);
            },
            ),
            FlatButton(
              child:const Text('Valider'),
              onPressed: () {
              Navigator.of(context).pop(ConfirmAction.Valider);
              },
            )
          ],
        );
      },
    );
  }

  Widget build(BuildContext context){
   
    Config().init(context);
    return new Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Feuille Ouvrage"),
        centerTitle: true,
      ),

      body: [
        Localisation(),
        Caractere(),
        LandingScreen(),
        Anomalie(),
      ].elementAt(currentIndex),


      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          final ConfirmAction action = await _asyncConfirmDialog(context);
          print("Confirm action $action");
        },
                child: Icon(Icons.check, size: 25,),
                backgroundColor: Config.color,
        ),
   
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,


      bottomNavigationBar: BubbleBottomBar(
        backgroundColor: Config.bottomBarColor,
        opacity: .2,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 8,
        fabLocation: BubbleBottomBarFabLocation.end, //new
        hasNotch: true, //new
        hasInk: true, //new, gives a cute ink effect
        inkColor: Colors.black12, //optional, uses
        currentIndex: currentIndex,
        items: <BubbleBottomBarItem>[
            BubbleBottomBarItem(backgroundColor: Colors.red, icon: Icon(Icons.map, color: Colors.black,), activeIcon: Icon(Icons.map, color: Colors.red,), title: Text("Localisation", style: TextStyle(fontSize:10,color:Colors.red ),),),
            BubbleBottomBarItem(backgroundColor: Colors.deepPurple, icon: Icon(Icons.assignment, color: Colors.black,), activeIcon: Icon(Icons.assignment, color: Colors.deepPurple,), title: Text("Caractéristiques", style: TextStyle(fontSize:8,color:Colors.deepPurple ),)),
            BubbleBottomBarItem(backgroundColor: Colors.lightBlue, icon: Icon(Icons.add_a_photo, color: Colors.black,), activeIcon: Icon(Icons.add_a_photo, color: Colors.lightBlue,), title: Text("Schéma", style: TextStyle(fontSize:10,color:Colors.indigo ),)),
            BubbleBottomBarItem(backgroundColor: Colors.green, icon: Icon(Icons.new_releases, color: Colors.black,), activeIcon: Icon(Icons.new_releases, color: Colors.green,), title: Text("Anomalies",  style: TextStyle(fontSize:11,color:Colors.green ),))],
        onTap: (newIndex) {
            setState(() {
              currentIndex= newIndex;
            });
   
          }
        ),

      
      );
    }

}