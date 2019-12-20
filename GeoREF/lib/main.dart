import 'dart:io';
import 'package:flutter/material.dart';
import 'package:GeoREF/Affaire.dart';
import 'package:GeoREF/Commune.dart';
import 'package:GeoREF/Storage.dart';
import 'package:GeoREF/Home.dart';
import 'package:flutter/services.dart';

List<NumeroAffaire> listNumeroAffaire = new List<NumeroAffaire>();
String dernierNumeroAffaire;
Commune derniereCommune;
Storage storage = new Storage();
//création d'un répertoire dans lequel on va enregistrer nos fichiers
Directory myDir;
Directory picturesDir;

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String path = await storage.localPath;
  myDir = new Directory(path + "/fiches");
  myDir.create();
  picturesDir = new Directory(path + "/Pictures");
  picturesDir.create();
  runApp(App());
}

class App extends StatelessWidget {
  //création d'un répertoire dans lequel on va enregistrer nos fichiers

  @override
  build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
