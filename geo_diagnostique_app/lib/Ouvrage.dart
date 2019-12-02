import 'dart:core';
import 'dart:io';

class Ouvrage {
  String refOuvrage;
  
  Ouvrage(String refOuvrage){
    this.refOuvrage = refOuvrage;
  }
  // --- Localisation de l'ouvrage --- \\
  String nomRue;
  String implantation;
  String typeReseau;

  // --- Caractéristique de l'ouvrage -- \\
  String type;
  String observationCaracteristiques;
  String dispositifFermeture;
  String section;
  String nature;
  String dimension;// diamètre en mm
  String dispositifAcces;
  String cunette;

  // --- Schéma de l'ouvrage --- \\
  File photoOuvrage;
  File photoCroquis;
  String coteTN; //en m
  String profondeurRadier;// en m
  CaracteristiqueCanalisation listCanalisation;

  // --- Anomalies observées --- \\
  String tracesCharge;
  String perturbationEcoulement;
  String defautEtancheite;
  String tracesInfiltration;
  String defautStructure;
  String genieCivilFissure;
  String defautFermeture;
  String tamponNonAccessible;
  String presenceH2S;
  String ouiPresenceH2S;
  String observationsAnomalies;
}

class CaracteristiqueCanalisation{
  String ref;
  String role;
  String geometrie;
  String dimension;
  String nature;
  String profondeur; //en m
  String observationsAnomalies;
}