import 'dart:core';

class Ouvrage {
  String refOuvrage;
  List<CaracteristiqueCanalisation> listCanalisation = new List(6);
  
  Ouvrage(String refOuvrage){
    this.refOuvrage = refOuvrage;
    for(int i=0;i<6;i++){
      listCanalisation[i]= new CaracteristiqueCanalisation();
    }
  }
  // --- Localisation de l'ouvrage --- \\
  String nomRue = "";
  String implantation="";
  String typeReseau="";
  String latitude="";
  String longitude="";

  // --- Caractéristique de l'ouvrage -- \\
  String type="";
  String observationCaracteristiques="";
  String dispositifFermeture="";
  String section="";
  String nature="";
  String dimension="";// diamètre en mm
  String dispositifAcces="";
  String cunette="";

  // --- Schéma de l'ouvrage --- \\
  String photoOuvrage="";
  String coteTN=""; //en m
  String profondeurRadier="";// en m

  // --- Anomalies observées --- \\
  String tracesCharge="";
  String perturbationEcoulement="";
  String precisionPerturbationEcoulement="";
  String defautEtancheite="";
  String tracesInfiltration="";
  String branchementNonEtanche="";
  String defautStructure="";
  String genieCivilFissure="";
  String deboitement="";
  String defautFermeture="";
  String tamponDeteriore="";
  String presenceH2S="";
  String observationsAnomalies="";
}

class CaracteristiqueCanalisation{
  String role="";
  String geometrie="";
  String dimension="";
  String nature="";
  String profondeur=""; //en m
  String angle="";
  String observations="";
}