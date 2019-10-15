import 'package:flutter/material.dart';
import 'package:geo_diagnostique_app/MenuAffaire.dart';


List listNumeroAffaire = new List();

main() {
  runApp(App());
}


class App extends StatelessWidget {

  @override
  build(BuildContext ctxt) {

    
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MenuAffaire(),
    );
  }
}
