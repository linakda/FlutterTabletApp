import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geo_diagnostique_app/Affaire.dart';
import 'package:geo_diagnostique_app/Commune.dart';
import 'package:geo_diagnostique_app/Config.dart';
import 'package:geo_diagnostique_app/Ouvrage.dart';
import 'package:geo_diagnostique_app/main.dart';

class CreationREF extends StatefulWidget {
  @override
  _CreationREFState createState() => _CreationREFState();
} 

class _CreationREFState extends State<CreationREF> {
  
  final TextStyle textSize = new TextStyle(fontSize: Config.fontSize);
  final EdgeInsetsGeometry textPadding = EdgeInsets.all(Config.screenPadding);
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

  //AutoCompletion
  @override
  void initState() {
    for (int i = 0; i < controllerList.length; i++) {
      controllerList[i] = new TextEditingController(text: '');
      formKeylist[i] = new GlobalKey<FormState>();
      switch(i){
        case 0 :
          controllerList[i].text=dernierNumeroAffaire;
          break;
        case 1 :
           if (derniereCommune!=null) {controllerList[i].text=derniereCommune.nomCommune;}
          break;
        case 2 :
          if (derniereCommune!=null) {controllerList[i].text=derniereCommune.refCommune;}
          break;
        case 3 :
          if(derniereCommune!=null){
            int index = derniereCommune.listOuvrage.length -1;
            if(derniereCommune.listOuvrage[index].refOuvrage.isNotEmpty){
              controllerList[i].text = derniereCommune.refCommune +nextRefOuvrage(derniereCommune);
            }
          }
        break;
        default :
          break;
      }
    }
    super.initState();
  }

  //Méthode qui renvoi la prochaine reférence d'ouvrage
  String nextRefOuvrage(Commune dernierCommune){
    if(derniereCommune.listOuvrage.isNotEmpty){
      int index = derniereCommune.listOuvrage.length -1;
      int refCommuneLength = derniereCommune.refCommune.length;
      int nextRefOuvrage = int.parse(derniereCommune.listOuvrage[index].refOuvrage.substring(refCommuneLength))+1;
      return nextRefOuvrage.toString().padLeft(3,'0');
    }
    return null;
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
              else if(index==3 && _isOuvrageExist(controllerList[0].text,controllerList[1].text,value)){
                return 'Reférence ouvrage déja existante';
              }
              else if (index==3 && _isREFOuvrageValid(value,controllerList[2].text)){
                return 'La référence ouvrage n\'est pas valide (min. 3 chiffres)';
              }
              return null;
            },
            textFieldConfiguration: TextFieldConfiguration(
              textCapitalization: TextCapitalization.characters,
              onChanged: (text)
              {
                setState(() {
                  if(index==1){
                   showFirst3Letters(controllerList[1],controllerList[2]);
                   showFirst3Letters(controllerList[2], controllerList[3]);
                  }
                  else if (index==2){
                   showFirst3Letters(controllerList[2], controllerList[3]);
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
                return filtreSuggestion(pattern, numAffaires(listNumeroAffaire)) ;
                break;
              case 1:
                  return filtreSuggestion(pattern, communeList(actuelNumAffaire(listNumeroAffaire))) ;
              
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
            if(index==1){
             showFirst3Letters(controllerList[1],controllerList[2]);
             showFirst3Letters(controllerList[2], controllerList[3]);
            }
            else if (index==2){
             showFirst3Letters(controllerList[2], controllerList[3]);
            }
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

  //Méthode pour vérifier si l'ouvrage existe dans la même commune du même numéro d'affaire
  bool _isOuvrageExist(String numAffaire,String commune, String refOuvrage){
    var index1=0;
    for(var numAffairetmp in listNumeroAffaire){
      if(numAffairetmp.numeroAffaire==numAffaire){
        var index2=0;
        for(var communetmp in listNumeroAffaire[index1].listCommune){
          if(communetmp.nomCommune==commune){
            for(var refOuvragetmp in listNumeroAffaire[index1].listCommune[index2].listOuvrage){
              if(refOuvragetmp.refOuvrage==refOuvrage){return true;}
            }
          }
          index2++;
        }
      }
      index1++;
    }
    return false;
  } 

  //Méthode pour vérifier que l'utilisateur a entré 3 chiffre à la fin de la refOuvrage
  bool _isREFOuvrageValid(String refOuvrage,String refCommune){
      int refCommuneLength = refCommune.length;
      if(refOuvrage.substring(refCommuneLength).length==3 && int.parse(refOuvrage.substring(refCommuneLength)) is int){
        return false;
      }
      return true;
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
  void showFirst3Letters(TextEditingController textController1,TextEditingController textController2){
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
                      storage.addREFOuvrage(controllerList[0].text,controllerList[1].text,controllerList[2].text,controllerList[3].text);
                      storage.writeData(controllerList[0].text+','+controllerList[1].text+','+controllerList[2].text+','+controllerList[3].text+'\n',controllerList[0].text);
                      Navigator.pop(context);
                    }
                    else{

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
