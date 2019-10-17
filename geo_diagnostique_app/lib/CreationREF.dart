import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geo_diagnostique_app/Affaire.dart';
import 'package:geo_diagnostique_app/Commune.dart';
import 'package:geo_diagnostique_app/Size.dart';

class CreationREF extends StatefulWidget {
  final Function updateNumAffaireList;
  final List<NumeroAffaire> numAffaireList;

  CreationREF(this.updateNumAffaireList, this.numAffaireList);
  @override
  _CreationREFState createState() => _CreationREFState();
}

class _CreationREFState extends State<CreationREF> {
  final TextStyle textSize = new TextStyle(fontSize: SizeConfig.fontSize);
  final Color color = Colors.green;
  final EdgeInsetsGeometry textPadding =
      EdgeInsets.all(SizeConfig.screenPadding);
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
                return 'Veuillez entrez un champ';
              }
              return null;
            },
            textFieldConfiguration: TextFieldConfiguration(
              controller: controllerList[index],
              cursorColor: color,
              style: textSize,
              decoration: InputDecoration(
                labelText: label,
                labelStyle: TextStyle(color: Colors.grey[700]),
                focusColor: color,
                fillColor: Colors.white,
                focusedBorder: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(color: color),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
            suggestionsCallback: (pattern){
              switch(index){
              case 0:
                return numAffaires(widget.numAffaireList);
                break;
              case 1:
                return communeList(actuelNumAffaire(widget.numAffaireList));
                break;
              default :
              return null;
              }
            },
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
    List<Commune> communes=affaire.listCommune;
    List<String> listString=new List<String>();
    for(var i=0;i<communes.length;i++){
      listString.add(communes[i].nomCommune);
    }
    return listString;
  }

  //Méthode qui à partir de la liste des numéros d'affaire, nous donne le numéro d'affaire taper précédemment
  NumeroAffaire actuelNumAffaire(List<NumeroAffaire> affaire){
    int index;
    for(index=0;index<affaire.length;index++){
      if(affaire[index].numeroAffaire==controllerList[0].text){
        break;
      }
    }
    return affaire[index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Création d\'une référence', style: textSize),
        backgroundColor: color,
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
                  splashColor: Colors.greenAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  color: color,
                  textColor: Colors.white,
                  onPressed: () {
                    if (testREFvalidate(formKeylist)) {
                      widget.updateNumAffaireList(controllerList[0].text,controllerList[1].text);
                      Scaffold.of(context).showSnackBar(SnackBar(
                        duration: new Duration(seconds: 3),
                        backgroundColor: color,
                        content: Text(
                          'Ajouter avec Succés !',
                          style: TextStyle(fontSize: SizeConfig.fontSize / 2),
                        ),
                        action: SnackBarAction(
                          label: 'Annuler',
                          textColor: Colors.redAccent,
                          onPressed: () {
                            //Code pour annuler l'ajout
                          },
                        ),
                      ));
                      Navigator.pop(context);
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
