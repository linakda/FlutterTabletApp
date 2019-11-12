import 'package:flutter/material.dart';
import 'package:geo_diagnostique_app/Affaire.dart';
import 'package:geo_diagnostique_app/FeuilleOuvrage.dart';
import 'package:geo_diagnostique_app/MenuAffaire.dart';
import 'package:geo_diagnostique_app/Storage.dart';

List<NumeroAffaire> listNumeroAffaire = new List<NumeroAffaire>();

main() {
  runApp(App());
}


class App extends StatelessWidget {
  @override
  build(BuildContext context){
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MenuAffaire(),
    );
  }
}
