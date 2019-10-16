import 'dart:core';
import 'dart:io';

class FicheOuvrage {
  // --- Localisation de l'ouvrage --- \\
  String commune;
  String nomRue;
  List <String> implantation = new List(5);
  List <String> typeReseau = new List(4);

  // --- Caractéristique de l'ouvrage -- \\
  List <String> type = new List(6);
  String observation;
  List <String> dispositifFermeture = new List(3);
  List <String> section = new List(2);
  List <String> nature = new List(4);
  double dimension;// diamètre en mm
  List <String> dispositifAcces = new List(2);
  List <String> cunette = new List(3);

  // --- Schéma de l'ouvrage --- \\
  File photoOuvrage;
  File photoCroquis;
  int coteTN; //en m
  int profondeurRadier;// en m
  List <CaracteristiqueCanalisation> listCanalisation;

  // --- Anomalies observées --- \\
  List <String> tracesCharge = new List(2);
  List <String> perturbationEcoulement = new List(3);
  List <String> defautEtancheite = new List(3);
  List <String> tracesInfiltration = new List(3);
  List <String> defautStructure = new List(3);
  List <String> genieCivilFissure = new List(2);
  List <String> defautFermeture = new List(2);
  List <String> tamponNonAccessible = new List(2);
  List <String> presenceH2S = new List(2);
  List <String> ouiPresenceH2S = new List(2);
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