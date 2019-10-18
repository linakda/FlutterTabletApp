
import 'package:geo_diagnostique_app/FicheOuvrage.dart';

class Commune {
  String nomCommune;
  String refCommune;
  List<FicheOuvrage> listFicheOuvrage;
  Commune(String nomCommune, String refCommune){
    this.nomCommune = nomCommune;
    this.refCommune = refCommune;
  }
}