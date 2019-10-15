import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geo_diagnostique_app/Size.dart';

class CreationREF extends StatelessWidget {
  TextStyle textSize = new TextStyle(fontSize: SizeConfig.fontSize);
  Color color = Colors.teal[700];
  EdgeInsetsGeometry textPadding = EdgeInsets.all(SizeConfig.screenPadding);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Création d\'une référence', style: textSize),
        backgroundColor: color,
      ),
      body: Builder(
          builder: (context) => Center(
                child: Padding(
                  padding: textPadding,
                  child: Column(children: [
                    Padding(
                      padding: textPadding,
                      child: TextFormField(
                        cursorColor: color,
                        style: textSize,
                        decoration: InputDecoration(
                          labelText: 'N°Affaire',
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
                    ),
                    Padding(
                      padding: textPadding,
                      child: TextFormField(
                        cursorColor: color,
                        style: textSize,
                        decoration: InputDecoration(
                          labelText: 'Commune',
                          labelStyle: TextStyle(color: Colors.grey[700]),
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
                    ),
                    Padding(
                      padding: textPadding,
                      child: TextFormField(
                        cursorColor: color,
                        style: textSize,
                        decoration: InputDecoration(
                          labelText: 'Réf. Commune',
                          labelStyle: TextStyle(color: Colors.grey[700]),
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
                    ),
                    Padding(
                      padding: textPadding,
                      child: TextFormField(
                        cursorColor: color,
                        style: textSize,
                        decoration: InputDecoration(
                          labelText: 'Réf. Ouvrage',
                          labelStyle: TextStyle(color: Colors.grey[700]),
                          fillColor: Colors.white,
                          focusColor: Colors.teal[700],
                          focusedBorder: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(color: color),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: textPadding,
                      child: RaisedButton(
                        splashColor: Colors.teal[500],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        color: Colors.teal[700],
                        textColor: Colors.white,
                        onPressed: () {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            duration: new Duration(seconds: 3),
                            backgroundColor: color,
                            content: Text(
                              'Ajouter avec Succés !',
                              style:
                                  TextStyle(fontSize: SizeConfig.fontSize / 2),
                            ),
                            action: SnackBarAction(
                              label: 'Annuler',
                              textColor: Colors.redAccent,
                              onPressed: () {
                                //Code pour annuler l'ajout
                              },
                            ),
                          ));
                        },
                        child: Text('Ajouter la Réf.', style: textSize),
                      ),
                    ),
                  ]),
                ),
              )),
    );
  }
}
