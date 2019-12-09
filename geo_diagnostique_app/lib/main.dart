import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geo_diagnostique_app/Affaire.dart';
import 'package:geo_diagnostique_app/Commune.dart';
import 'package:geo_diagnostique_app/Storage.dart';
import 'package:geo_diagnostique_app/Home.dart';
import 'package:flutter/services.dart';

List<NumeroAffaire> listNumeroAffaire = new List<NumeroAffaire>();
String dernierNumeroAffaire;
Commune derniereCommune;
Storage storage = new Storage();
//création d'un répertoire dans lequel on va enregistrer nos fichiers
Directory myDir;

main()async{
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight]);
  String path = await storage.localPath;
  print(path);
  myDir = new Directory(path+"/fiches");
  myDir.create()
    // The created directory is returned as a Future.
    .then((Directory directory) {
  });
  runApp(App());
}


class App extends StatelessWidget {

  //création d'un répertoire dans lequel on va enregistrer nos fichiers

  @override
  build(BuildContext context){
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
