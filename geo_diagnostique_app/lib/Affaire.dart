import 'package:geo_diagnostique_app/Commune.dart';

class NumeroAffaire {
  final List<Commune> listCommune = new List<Commune>();
  String numeroAffaire;
  NumeroAffaire(String numeroAffaire,){
    this.numeroAffaire = numeroAffaire;
  }

  void addCommune(Commune commune){
    listCommune.add(commune);
  }
  
}