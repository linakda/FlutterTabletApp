
import 'package:geo_diagnostique_app/FicheOuvrage.dart';

class Commune {
  String nomCommune;
  List<FicheOuvrage> listFicheOuvrage;
  Commune(String nomCommune){
    this.nomCommune = nomCommune;
  }
}