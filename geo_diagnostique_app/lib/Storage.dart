import 'dart:io';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:geo_diagnostique_app/Affaire.dart';
import 'package:geo_diagnostique_app/Commune.dart';
import 'package:geo_diagnostique_app/Ouvrage.dart';
import 'package:geo_diagnostique_app/main.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:permission_handler/permission_handler.dart';
import 'main.dart';

class Storage {
  Future<String> get localPath async { 
    Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.storage]);
    final dir = await PathProviderEx.getStorageInfo();
    return dir.last.appFilesDir;
  }

  Future<File> get localFile async {
    final path = await localPath;
    return File('$path');
  }

  Future<String> readData(String path) async {
    try {
      final file2 = File('$path');

      String body = await file2.readAsString();
      return body;
    } catch (e) {
      return e.toString();
    }
  }

  void writeData(
    String data, String fileName, String refOuvrageSelected) async {
    File file = new File('${myDir.path}/$fileName.txt');
    List<String> lines;
    List<String> parameters;
    int index = 1;
    bool alreadyWrite = false;
    if (await file.exists()) {
      lines = await file.readAsLines();
      //Test si la ligne est à réécrire
      for (var i = 1; i < lines.length; i++) {
        parameters = lines[i].split(',');
        for (var j = 0; j < parameters.length; j++) {
          if (parameters[j] == refOuvrageSelected) {
            lines[i] = data;
            alreadyWrite = true;
          }
        }
      }
      if (alreadyWrite) {
        index = lines.length - 1;
      } else {
        index = lines.length;
      }
      lines[0] =
          "Numéro d'Affaire,Référence de l\'ouvrage,Commune,Nom de la rue,Implantation,Type de réseau,Type d'ouvrage,Observation,Dispositif de fermeture,Section,Nature,Dimension,Dispositif d'accés,Cunette,Photo,Côte tn,Profondeur radier,Rôle(fs),Géométrie(fs),Dimension(fs),Nature(fs),Profondeur(fs),Observation(fs),Rôle(f1),Géométrie(f1),Dimension(f1),Nature(f1),Profondeur(f1),Angle(f1),Observation(f1),Rôle(f2),Géométrie(f2),Dimension(f2),Nature(f2),Profondeur(f2),Angle(f2),Observation(f2),Rôle(f3),Géométrie(f3),Dimension(f3),Nature(f3),Profondeur(f3),Angle(f3),Observation(f3),Rôle(f4),Géométrie(f4),Dimension(f4),Nature(f4),Profondeur(f4),Angle(f4),Observation(f4),Rôle(f5),Géométrie(f5),Dimension(f5),Nature(f5),Profondeur(f5),Angle(f5),Observation(f5),Traces de mises en charge,Perturbation de l'écoulement,Précision,Défaut d\'étanchéité,Traces d'infiltration,Branchement non étanche,Défaut de structure,Génie civil fissuré,Déboitement,Défaut de fermeture,Tampon détérioré,Présence d\'H2S,Autres observations,$index";
      await file.writeAsString("${lines[0]}");
      for (var i = 1; i < lines.length; i++) {
        await file.writeAsString("\n${lines[i]}",
            mode: FileMode.writeOnlyAppend);
      }
      if (!alreadyWrite) {
        await file.writeAsString("\n$data", mode: FileMode.writeOnlyAppend);
      }
    } else {
      await file.writeAsString(
          "Numéro d'Affaire,Référence de l'ouvrage,Commune,Nom de la rue,Implantation,Type de réseau,Type d'ouvrage,Observation,Dispositif de fermeture,Section,Nature,Dimension,Dispositif d'accés,Cunette,Photo,Côte tn,Profondeur radier,Rôle(fs),Géométrie(fs),Dimension(fs),Nature(fs),Profondeur(fs),Observation(fs),Rôle(f1),Géométrie(f1),Dimension(f1),Nature(f1),Profondeur(f1),Angle(f1),Observation(f1),Rôle(f2),Géométrie(f2),Dimension(f2),Nature(f2),Profondeur(f2),Angle(f2),Observation(f2),Rôle(f3),Géométrie(f3),Dimension(f3),Nature(f3),Profondeur(f3),Angle(f3),Observation(f3),Rôle(f4),Géométrie(f4),Dimension(f4),Nature(f4),Profondeur(f4),Angle(f4),Observation(f4),Rôle(f5),Géométrie(f5),Dimension(f5),Nature(f5),Profondeur(f5),Angle(f5),Observation(f5),Traces de mises en charge,Perturbation de l'écoulement,Précision,Défaut d'étanchéité,Traces d'infiltration,Branchement non étanche,Défaut de structure,Génie civil fissuré,Déboitement,Défaut de fermeture,Tampon détérioré,Présence d'H2S,Autres observations,$index");
      await file.writeAsString("\n$data", mode: FileMode.writeOnlyAppend);
    }
  }

  //ajoute un ouvrage avec si besoin un numéro d'affaire et/ou une commune
  Future readAndUpdateList() async {
    List<FileSystemEntity> listFileSystemeEntity = new List<FileSystemEntity>();
    List<File> listFile = new List<File>();
    List<String> textSplit;
    List<String> lineSplit;
    //récupération de tous les fichiers du répertoire
    listFileSystemeEntity = myDir.listSync(recursive: true, followLinks: false);
    //Génération d'un list de fichier
    listFile = await orderedListFile(listFileSystemeEntity);
    String refCommune;

    for (File tmp in listFile) {
      String text = await tmp.readAsString();
      lineSplit = text.split("\n");

      for (var i = 1; i < lineSplit.length; i++) {
        if (lineSplit[i] != "") {
          textSplit = lineSplit[i].split(",");
          refCommune = textSplit[1].substring(0, textSplit[1].length - 3);
          if (textSplit.length == 3) {
            addREFOuvrage(textSplit[0], textSplit[2], refCommune, textSplit[1]);
          } else {
            addREFOuvrage2(
                addREFOuvrage(
                    textSplit[0], textSplit[2], refCommune, textSplit[1]),
                textSplit[3],
                textSplit[4],
                textSplit[5],
                textSplit[6],
                textSplit[7],
                textSplit[8],
                textSplit[9],
                textSplit[10],
                textSplit[11],
                textSplit[12],
                textSplit[13],
                textSplit[14],
                textSplit[15],
                textSplit[16],
                textSplit[17],
                textSplit[18],
                textSplit[19],
                textSplit[20],
                textSplit[21],
                textSplit[22],
                textSplit[23],
                textSplit[24],
                textSplit[25],
                textSplit[26],
                textSplit[27],
                textSplit[28],
                textSplit[29],
                textSplit[30],
                textSplit[31],
                textSplit[32],
                textSplit[33],
                textSplit[34],
                textSplit[35],
                textSplit[36],
                textSplit[37],
                textSplit[38],
                textSplit[39],
                textSplit[40],
                textSplit[41],
                textSplit[41],
                textSplit[42],
                textSplit[43],
                textSplit[44],
                textSplit[45],
                textSplit[46],
                textSplit[47],
                textSplit[48],
                textSplit[49],
                textSplit[50],
                textSplit[51],
                textSplit[52],
                textSplit[53],
                textSplit[54],
                textSplit[55],
                textSplit[56],
                textSplit[57],
                textSplit[58],
                textSplit[59],
                textSplit[60],
                textSplit[61],
                textSplit[62],
                textSplit[63],
                textSplit[64],
                textSplit[65],
                textSplit[66],
                textSplit[67],
                textSplit[68],
                textSplit[69]);
          }
        }
      }
    }
  }

  Future<List<File>> orderedListFile(List<FileSystemEntity> list) async {
    List<File> listFile = new List<File>();
    List<File> orderedListFile = new List<File>();
    List<DateTime> listDateTime = new List<DateTime>();
    for (FileSystemEntity tmp in list) {
      listFile.add(File(tmp.path));
      DateTime tmpDateTime = await listFile[listFile.length - 1].lastModified();
      listDateTime.add(tmpDateTime);
    }
    listDateTime.sort((b, a) => a.compareTo(b));

    for (DateTime tmp in listDateTime) {
      for (File tmp2 in listFile) {
        DateTime tmpDateTime = await tmp2.lastModified();
        if (tmpDateTime == tmp) {
          orderedListFile.add(tmp2);
        }
      }
    }
    return orderedListFile;
  }

  Ouvrage addREFOuvrage(String numeroAffaire, String nomCommune,
      String refCommune, String refOuvrage) {
    Commune _nouvelCommune = new Commune(nomCommune, refCommune);
    Ouvrage _nouvelOuvrage = new Ouvrage(refOuvrage);
    _nouvelCommune.addOuvrage(_nouvelOuvrage);
    dernierNumeroAffaire = numeroAffaire;
    derniereCommune = _nouvelCommune;

    if (affaireIndex(numeroAffaire) != null) {
      //numero d'affaire existant
      int index = affaireIndex(numeroAffaire);
      if (communeIndex(listNumeroAffaire[index].listCommune, nomCommune) ==
          null) {
        //commune non existante
        listNumeroAffaire[index].addCommune(_nouvelCommune);
      } else {
        //commune existante -> nouvel ouvrage
        int index2 =
            communeIndex(listNumeroAffaire[index].listCommune, nomCommune);
        listNumeroAffaire[index].listCommune[index2].addOuvrage(_nouvelOuvrage);
      }
    } else {
      //numéro d'affaire non-existant
      listNumeroAffaire.add(new NumeroAffaire(
        numeroAffaire,
      ));
      listNumeroAffaire[listNumeroAffaire.length - 1]
          .addCommune(_nouvelCommune);
    }
    return _nouvelOuvrage;
  }

  void addREFOuvrage2(
      Ouvrage selectedOuvrage,
      String nomRue,
      String implantation,
      String typeReseau,
      String type,
      String observationCaracteristiques,
      String dispositifFermeture,
      String section,
      String natureCaracteristique,
      String dimensionCaracteristique,
      String dispositifAcces,
      String cunette,
      /*File photoOuvrage,File photoCroquis à remplacer par les noms des photos */ String
          coteTN,
      String profondeurRadier,
      String rolefs,
      String geometriefs,
      String dimensionfs,
      String naturefs,
      String profondeurfs,
      String anglefs,
      String observationsfs,
      String rolef1,
      String geometrief1,
      String dimensionf1,
      String naturef1,
      String profondeurf1,
      String anglef1,
      String observationsf1,
      String rolef2,
      String geometrief2,
      String dimensionf2,
      String naturef2,
      String profondeurf2,
      String anglef2,
      String observationsf2,
      String rolef3,
      String geometrief3,
      String dimensionf3,
      String naturef3,
      String profondeurf3,
      String anglef3,
      String observationsf3,
      String rolef4,
      String geometrief4,
      String dimensionf4,
      String naturef4,
      String profondeurf4,
      String anglef4,
      String observationsf4,
      String rolef5,
      String geometrief5,
      String dimensionf5,
      String naturef5,
      String profondeurf5,
      String anglef5,
      String observationsf5,
      String tracesCharge,
      String perturbationEcoulement,
      String defautEtancheite,
      String tracesInfiltration,
      String branchementNonEtanche,
      String defautStructure,
      String genieCivilFissure,
      String deboitement,
      String defautFermeture,
      String tamponDeteriore,
      String tamponNonAccessible,
      String presenceH2S,
      String observationsAnomalies) async {
//Localisation---------------
    selectedOuvrage.nomRue = nomRue;
    selectedOuvrage.implantation = implantation;
    selectedOuvrage.typeReseau = typeReseau;
//Caracteristiques------------
    selectedOuvrage.type = type;
    selectedOuvrage.observationCaracteristiques = observationCaracteristiques;
    selectedOuvrage.dispositifFermeture = dispositifFermeture;
    selectedOuvrage.section = section;
    selectedOuvrage.nature = natureCaracteristique;
    selectedOuvrage.dimension = dimensionCaracteristique;
    selectedOuvrage.dispositifAcces = dispositifAcces;
    selectedOuvrage.cunette = cunette;
//Schema------------
    //selectedOuvrage.photoCroquis = photoCroquis;
    //selectedOuvrage.photoOuvrage = photoOuvrage;
    selectedOuvrage.coteTN = coteTN;
    selectedOuvrage.profondeurRadier = profondeurRadier;
    //Caracteristique canalisation---------
    selectedOuvrage.listCanalisation[0].role = rolefs;
    selectedOuvrage.listCanalisation[0].geometrie = geometriefs;
    selectedOuvrage.listCanalisation[0].dimension = dimensionfs;
    selectedOuvrage.listCanalisation[0].nature = naturefs;
    selectedOuvrage.listCanalisation[0].profondeur = profondeurfs;
    selectedOuvrage.listCanalisation[0].angle = anglefs;
    selectedOuvrage.listCanalisation[0].observations = observationsfs;
    selectedOuvrage.listCanalisation[1].role = rolef1;
    selectedOuvrage.listCanalisation[1].geometrie = geometrief1;
    selectedOuvrage.listCanalisation[1].dimension = dimensionf1;
    selectedOuvrage.listCanalisation[1].nature = naturef1;
    selectedOuvrage.listCanalisation[1].profondeur = profondeurf1;
    selectedOuvrage.listCanalisation[1].angle = anglef1;
    selectedOuvrage.listCanalisation[1].observations = observationsf1;
    selectedOuvrage.listCanalisation[2].role = rolef2;
    selectedOuvrage.listCanalisation[2].geometrie = geometrief2;
    selectedOuvrage.listCanalisation[2].dimension = dimensionf2;
    selectedOuvrage.listCanalisation[2].nature = naturef2;
    selectedOuvrage.listCanalisation[2].profondeur = profondeurf2;
    selectedOuvrage.listCanalisation[2].angle = anglef2;
    selectedOuvrage.listCanalisation[2].observations = observationsf2;
    selectedOuvrage.listCanalisation[3].role = rolef3;
    selectedOuvrage.listCanalisation[3].geometrie = geometrief3;
    selectedOuvrage.listCanalisation[3].dimension = dimensionf3;
    selectedOuvrage.listCanalisation[3].nature = naturef3;
    selectedOuvrage.listCanalisation[3].profondeur = profondeurf3;
    selectedOuvrage.listCanalisation[3].angle = anglef3;
    selectedOuvrage.listCanalisation[3].observations = observationsf3;
    selectedOuvrage.listCanalisation[4].role = rolef4;
    selectedOuvrage.listCanalisation[4].geometrie = geometrief4;
    selectedOuvrage.listCanalisation[4].dimension = dimensionf4;
    selectedOuvrage.listCanalisation[4].nature = naturef4;
    selectedOuvrage.listCanalisation[4].profondeur = profondeurf4;
    selectedOuvrage.listCanalisation[4].angle = anglef4;
    selectedOuvrage.listCanalisation[4].observations = observationsf4;
    selectedOuvrage.listCanalisation[5].role = rolef5;
    selectedOuvrage.listCanalisation[5].geometrie = geometrief5;
    selectedOuvrage.listCanalisation[5].dimension = dimensionf5;
    selectedOuvrage.listCanalisation[5].nature = naturef5;
    selectedOuvrage.listCanalisation[5].profondeur = profondeurf5;
    selectedOuvrage.listCanalisation[5].angle = anglef5;
    selectedOuvrage.listCanalisation[5].observations = observationsf5;
//Anomalies observees------------
    selectedOuvrage.tracesCharge = tracesCharge;
    selectedOuvrage.perturbationEcoulement = perturbationEcoulement;
    selectedOuvrage.defautEtancheite = defautEtancheite;
    selectedOuvrage.tracesInfiltration = tracesInfiltration;
    selectedOuvrage.branchementNonEtanche = branchementNonEtanche;
    selectedOuvrage.defautStructure = defautStructure;
    selectedOuvrage.genieCivilFissure = genieCivilFissure;
    selectedOuvrage.deboitement = deboitement;
    selectedOuvrage.defautFermeture = defautFermeture;
    selectedOuvrage.tamponDeteriore = tamponDeteriore;
    selectedOuvrage.presenceH2S = presenceH2S;
    selectedOuvrage.observationsAnomalies = observationsAnomalies;
  }

  //Méthode qui renvoie l'index d'un NuméroAffaire qui existe déjà
  int affaireIndex(String numero) {
    if (listNumeroAffaire.isNotEmpty) {
      for (int index = 0; index < listNumeroAffaire.length; index++) {
        if (listNumeroAffaire[index].numeroAffaire == numero) {
          return index;
        }
      }
    }
    return null;
  }

  //Méthode qui renvoie l'index d'une REFOuvrage qui existe déjà
  int refOuvrageIndex(List<Ouvrage> listOuvrage,String refOuvrageSelected){
    if(listOuvrage.isNotEmpty){
      for(int index=0; index<listOuvrage.length;index++){
        if(listOuvrage[index].refOuvrage==refOuvrageSelected){
          return index;
        }
      }
    }
    return null;
  }
  //Méthode qui renvoie l'index d'une commune qui existe déjà
  int communeIndex(List<Commune> listCommune, String nomCommune) {
    if (listCommune.isNotEmpty) {
      for (int index = 0; index < listCommune.length; index++) {
        if (listCommune[index].nomCommune == nomCommune) {
          return index;
        }
      }
    }
    return null;
  }

  //Supprime la ligne dans le fichier .csv selectionné
  void deleteSelectedOuvrageLine(
      String numeroAffaire, String ouvrageSelected) async {
    File file = new File('${myDir.path}/$numeroAffaire.txt');
    List<String> lines;
    List<String> parameters;
    if (await file.exists()) {
      lines = await file.readAsLines();
      var i = 1;
      while (i < lines.length) {
        parameters = lines[i].split(',');
        if (parameters[1] == ouvrageSelected) {
          break;
        }
        i++;
      }
      lines.removeAt(i);
      if (lines.length == 1) {
        file.delete();
      } else {
        var index = lines.length - 1;
        lines[0] =
            "Numéro d'Affaire,Référence de l\'ouvrage,Commune,Nom de la rue,Implantation,Type de réseau,Type d'ouvrage,Observation,Dispositif de fermeture,Section,Nature,Dimension,Dispositif d'accés,Cunette,Photo,Côte tn,Profondeur radier,Rôle(fs),Géométrie(fs),Dimension(fs),Nature(fs),Profondeur(fs),Observation(fs),Rôle(f1),Géométrie(f1),Dimension(f1),Nature(f1),Profondeur(f1),Angle(f1),Observation(f1),Rôle(f2),Géométrie(f2),Dimension(f2),Nature(f2),Profondeur(f2),Angle(f2),Observation(f2),Rôle(f3),Géométrie(f3),Dimension(f3),Nature(f3),Profondeur(f3),Angle(f3),Observation(f3),Rôle(f4),Géométrie(f4),Dimension(f4),Nature(f4),Profondeur(f4),Angle(f4),Observation(f4),Rôle(f5),Géométrie(f5),Dimension(f5),Nature(f5),Profondeur(f5),Angle(f5),Observation(f5),Traces de mises en charge,Perturbation de l'écoulement,Précision,Défaut d\'étanchéité,Traces d'infiltration,Branchement non étanche,Défaut de structure,Génie civil fissuré,Déboitement,Défaut de fermeture,Tampon détérioré,Présence d\'H2S,Autres observations,$index";
        await file.writeAsString("${lines[0]}");
        for (var i = 1; i < lines.length; i++) {
          await file.writeAsString("\n${lines[i]}",
              mode: FileMode.writeOnlyAppend);
        }
      }
    }
  }

  //Méthode qui renvoi la prochaine reférence d'ouvrage
  String nextRefOuvrage(Commune dernierCommune){
    if(derniereCommune.listOuvrage.isNotEmpty){
      int index = derniereCommune.listOuvrage.length -1;
      int refCommuneLength = derniereCommune.refCommune.length;
      int nextRefOuvrage = int.parse(derniereCommune.listOuvrage[index].refOuvrage.substring(refCommuneLength))+1;
      return nextRefOuvrage.toString().padLeft(3,'0');
    }
    return null;
  }

  //Méthode pour supprimer un Ouvrage dans l'appli et dans le fichier .csv
  void deleteOuvrage(
      NumeroAffaire numeroAffaireSelected,
      Commune communeSelected,
      String refOuvrageSelected,
      BuildContext context) {
    int i;
    for (i = 0; i < communeSelected.listOuvrage.length; i++) {
      if (communeSelected.listOuvrage[i].refOuvrage == refOuvrageSelected)
        break;
    }
    deleteSelectedOuvrageLine(numeroAffaireSelected.numeroAffaire,
        communeSelected.listOuvrage[i].refOuvrage);
    communeSelected.listOuvrage.removeAt(i);
    if (communeSelected.listOuvrage.length == 0) {
      numeroAffaireSelected.listCommune
          .removeAt(numeroAffaireSelected.listCommune.indexOf(communeSelected));
      Navigator.pop(context);
    }
    if(numeroAffaireSelected.listCommune.length == 0) {
      listNumeroAffaire.removeAt(listNumeroAffaire.indexOf(numeroAffaireSelected));
    }
  }
}