import 'dart:core';
import 'dart:io';

class FicheOuvrage {
  String refOuvrage;
  
  // --- Localisation de l'ouvrage --- \\
  String commune;
  String nomRue;
  String implantation;
  String typeReseau;

  // --- Caractéristique de l'ouvrage -- \\
  String type;
  String observation;
  String dispositifFermeture;
  String section;
  String nature;
  double dimension;// diamètre en mm
  String dispositifAcces;
  String cunette;

  // --- Schéma de l'ouvrage --- \\
  File photoOuvrage;
  File photoCroquis;
  int coteTN; //en m
  int profondeurRadier;// en m
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
  String observations;
}

class CaracteristiqueCanalisation{
  String ref;
  String role;
  String geometrie;
  String dimension;
  String nature;
  int profondeur; //en m
  String observations;
}