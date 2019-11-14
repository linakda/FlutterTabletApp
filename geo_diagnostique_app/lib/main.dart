import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geo_diagnostique_app/Affaire.dart';
import 'package:geo_diagnostique_app/Commune.dart';
import 'package:geo_diagnostique_app/MenuAffaire.dart';
import 'package:geo_diagnostique_app/Storage.dart';
import 'package:geo_diagnostique_app/Home.dart';

List<NumeroAffaire> listNumeroAffaire = new List<NumeroAffaire>();
String dernierNumeroAffaire;
Commune derniereCommune;
Storage storage = new Storage();
//création d'un répertoire dans lequel on va enregistrer nos fichiers
Directory myDir = new Directory('/storage/emulated/0/Android/data/com.example.geo_diagnostique_app/files/fiches');

main()async{
  myDir.create()
    // The created directory is returned as a Future.
    .then((Directory directory) {
      print(directory.path);
  });
  await storage.readAndUpdateList();
  //print("retour de storage read and update length = ${storage.readAndUpdateList(myDir,myMainlistNumeroAffaire).length}");
  runApp(App());
}


class App extends StatelessWidget {

  //création d'un répertoire dans lequel on va enregistrer nos fichiers

  @override
  build(BuildContext context){
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    );
  }
}
