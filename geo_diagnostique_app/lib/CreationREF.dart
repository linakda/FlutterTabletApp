import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geo_diagnostique_app/Affaire.dart';
import 'package:geo_diagnostique_app/Commune.dart';
import 'package:geo_diagnostique_app/Config.dart';
import 'package:geo_diagnostique_app/FeuilleOuvrage.dart';

class CreationREF extends StatefulWidget {
  final Function updateNumAffaireList;
  final List<NumeroAffaire> numAffaireList;
  final String dernierNumeroAffaire;

  CreationREF(this.updateNumAffaireList, this.numAffaireList,this.dernierNumeroAffaire);
  @override
  _CreationREFState createState() => _CreationREFState();
} 

class _CreationREFState extends State<CreationREF> {
  final TextStyle textSize = new TextStyle(fontSize: Config.fontSize);
  final EdgeInsetsGeometry textPadding =
      EdgeInsets.all(Config.screenPadding);
  //Le controller avec le text
  final List<TextEditingController> controllerList =
      new List<TextEditingController>(4);
  //La clé d'état de chaque TextFormField
  final List<GlobalKey<FormState>> formKeylist =
      new List<GlobalKey<FormState>>(4);

  //A utiliser à la fin d'utilisation des controller pour s'assurer qu'aucun élément est supprimé
  @override
  void dispose() {
    for (int i = 0; i < controllerList.length; i++) {
      controllerList[i].dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    for (int i = 0; i < controllerList.length; i++) {
      controllerList[i] = new TextEditingController(text: '');
      formKeylist[i] = new GlobalKey<FormState>();
      if(i==0){
        controllerList[i].text=widget.dernierNumeroAffaire;
      }
    }
    super.initState();
  }

  //Méthode pour créer les TextForms
  Padding textformREF(String label, int index) {
    return Padding(
        padding: textPadding,
        child: Form(
          key: formKeylist[index],
          child: TypeAheadFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Veuillez entrer un champ';
              }
              return null;
            },
            textFieldConfiguration: TextFieldConfiguration(
              textCapitalization: TextCapitalization.characters,
              onChanged: (text)
              {
                setState(() {
                  if(index==1){
                    affiche3Lettres(controllerList[1],controllerList[2]);
                    affiche3Lettres(controllerList[2], controllerList[3]);
                  }
                  else if (index==2){
                    affiche3Lettres(controllerList[2], controllerList[3]);
                  }
                });        
              },
              controller: controllerList[index],
              cursorColor: Config.color,
              style: textSize,
              decoration: InputDecoration(
                labelText: label,
                labelStyle: TextStyle(color: Config.textColor),
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
            ),
            suggestionsCallback: (pattern){
              switch(index){
              case 0:
                return filtreSuggestion(pattern, numAffaires(widget.numAffaireList)) ;
                break;
              case 1:
                  return filtreSuggestion(pattern, communeList(actuelNumAffaire(widget.numAffaireList))) ;
              
                break;
              default :
              return null;
              }
            },
            noItemsFoundBuilder: (BuildContext context) =>
            Text("Pas d'éléments trouvés",style: TextStyle(fontSize: Config.fontSize/2),),
            itemBuilder: (context, suggestion) {
              return ListTile(
                title: Text(suggestion),
              );
            },
            transitionBuilder: (context, suggestionsBox, controller) {
            return suggestionsBox;
            },
            onSuggestionSelected: (suggestion) {
            this.controllerList[index].text = suggestion;
          },
          ),
        ));
  }

  //Méthode pour valider tous les champs
  bool testREFvalidate(List<GlobalKey<FormState>> formKeylist) {
    bool validate = true;
    for (var i = 0; i < formKeylist.length; i++) {
      if (!formKeylist[i].currentState.validate()) {
        validate = false;
      }
    }
    if (validate == false) {
      return false;
    } else {
      return true;
    }
  }

  //Méthode qui à partir de la liste des numéros d'affaires, nous donnes une liste des noms des numéros d'affaires
  List<String> numAffaires(List<NumeroAffaire> list){
    List<String> listString=new List<String>();
    for(var i=0;i<list.length;i++){
      listString.add(list[i].numeroAffaire);
    }
    return listString;
  }
  
  //Méthode qui à partir d'un numéro d'affaire, nous donnes une liste des noms des communes
  List<String> communeList(NumeroAffaire affaire){
    if(affaire == null){return null;}
    List<Commune> communes=affaire.listCommune;
    List<String> listString=new List<String>();
    for(var i=0;i<communes.length;i++){
      
      listString.add(communes[i].nomCommune);
    }
    return listString;
  }

  //Méthode qui à partir de la liste des numéros d'affaire, nous donne le numéro d'affaire taper précédemment
  NumeroAffaire actuelNumAffaire(List<NumeroAffaire> affaire){
    for(var index=0;index<affaire.length;index++){
      if(affaire[index].numeroAffaire==controllerList[0].text){
        return affaire[index];
      }
    }
    return null;
  }

  //Méthode pour filtrer le résultat
  List<String> filtreSuggestion(String string,List<String> listString) {
    if(listString == null){return null;}
    List<String> rechercheList = List<String>();
    listString.forEach((item) {
      if(item.contains(string)) {
        rechercheList.add(item);
      }
    });
    return rechercheList;
  }

  //Méthode pour afficher les trois premières lettres
  void affiche3Lettres(TextEditingController textController1,TextEditingController textController2){
    String text1 = textController1.text;
    textController2.text = text1.substring(0,3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Création d\'une référence', style: textSize),
        backgroundColor: Config.color,
      ),
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Center(
              child: Column(
            children: <Widget>[
              textformREF('N° Affaire', 0),
              textformREF('Commune', 1),
              textformREF('Réf. Commune', 2),
              textformREF('Réf. Ouvrage', 3),
              Padding(
                padding: textPadding,
                child: RaisedButton(
                  splashColor: Config.splashColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  color: Config.buttonColor,
                  textColor: Colors.white,
                  onPressed: () {
                    if (testREFvalidate(formKeylist)) {
                      widget.updateNumAffaireList(controllerList[0].text,controllerList[1].text,controllerList[2].text);
                      //Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FeuilleOuvrage(),));
                    }
                  },
                  child: Text('Ajouter la Réf.', style: textSize),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
