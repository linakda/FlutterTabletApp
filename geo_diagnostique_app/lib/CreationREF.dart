import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geo_diagnostique_app/Size.dart';

class CreationREF extends StatefulWidget {
  @override
  CreationREFState createState() => CreationREFState();
}

class CreationREFState extends State<CreationREF> {
  final TextStyle textSize = new TextStyle(fontSize: SizeConfig.fontSize);
  final Color color = Colors.teal[700];
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

  Padding textformREF(String label, int index) {
    return Padding(
        padding: textPadding,
        child: Form(
          key: formKeylist[index],
          child: TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Veuillez entrez un champ';
              }
              return null;
            },
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
        ));
  }

  bool testREFvalidate(List<GlobalKey<FormState>> formKeylist) {
    bool validate = true;
    for (var i = 0; i < formKeylist.length; i++) {
      if (!formKeylist[i].currentState.validate()) {
        validate=false;
      }
    }
    if(validate==false){
      return false;
    }
    else{
      return true;
    }
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
                  splashColor: Colors.teal[500],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  color: Colors.teal[700],
                  textColor: Colors.white,
                  onPressed: () {
                    if (testREFvalidate(formKeylist)) {
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
