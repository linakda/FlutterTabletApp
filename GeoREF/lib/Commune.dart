import 'package:GeoREF/Ouvrage.dart';

class Commune {
  String nomCommune;
  String refCommune;
  List<Ouvrage> listOuvrage = new List<Ouvrage>();
  Commune(String nomCommune, String refCommune){
    this.nomCommune = nomCommune;
    this.refCommune = refCommune;
  }

  void addOuvrage(Ouvrage ouvrage){
    listOuvrage.add(ouvrage);
  }
}