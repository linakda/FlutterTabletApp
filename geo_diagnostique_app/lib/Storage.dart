
import 'dart:io';
import 'dart:async';
import 'package:geo_diagnostique_app/Affaire.dart';
import 'package:geo_diagnostique_app/Commune.dart';
import 'package:geo_diagnostique_app/Ouvrage.dart';
import 'package:path_provider/path_provider.dart';
import 'main.dart';

class Storage{

  Future<String> get localPath async {
    final dir = await getExternalStorageDirectory();
    return dir.path;
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

  void  writeData(String data, String fileName) async {
    File file= new File('${myDir.path}/$fileName.txt');
    List<String> lines;
    int index=1;
    if(await file.exists()){
      lines=await file.readAsLines();
      int index=lines.length;
      lines[0]="Numéro d'Affaire,Référence de l\'ouvrage,Commune,Nom de la rue,Implantation,Type de réseau,Type d'ouvrage,Observation,Dispositif de fermeture,Section,Nature,Dimension,Dispositif d'accés,Cunette,Photo,Côte tn,Profondeur radier,Rôle(fs),Géométrie(fs),Dimension(fs),Nature(fs),Profondeur(fs),Observation(fs),Rôle(f1),Géométrie(f1),Dimension(f1),Nature(f1),Profondeur(f1),Angle(f1),Observation(f1),Rôle(f2),Géométrie(f2),Dimension(f2),Nature(f2),Profondeur(f2),Angle(f2),Observation(f2),Rôle(f3),Géométrie(f3),Dimension(f3),Nature(f3),Profondeur(f3),Angle(f3),Observation(f3),Rôle(f4),Géométrie(f4),Dimension(f4),Nature(f4),Profondeur(f4),Angle(f4),Observation(f4),Rôle(f5),Géométrie(f5),Dimension(f5),Nature(f5),Profondeur(f5),Angle(f5),Observation(f5),Traces de mises en charge,Perturbation de l'écoulement,Précision,Défaut d\'étanchéité,Traces d'infiltration,Branchement non étanche,Défaut de structure,Génie civil fissuré,Déboitement,Défaut de fermeture,Tampon détérioré,Présence d\'H2S,Autres observations,$index";
      await file.writeAsString("${lines[0]}");
      for(var i=1;i<lines.length;i++){await file.writeAsString("\n${lines[i]}",mode:FileMode.writeOnlyAppend);}
      await file.writeAsString("\n$data",mode:FileMode.writeOnlyAppend);
    }
    else{
      await file.writeAsString("Numéro d'Affaire,Référence de l'ouvrage,Commune,Nom de la rue,Implantation,Type de réseau,Type d'ouvrage,Observation,Dispositif de fermeture,Section,Nature,Dimension,Dispositif d'accés,Cunette,Photo,Côte tn,Profondeur radier,Rôle(fs),Géométrie(fs),Dimension(fs),Nature(fs),Profondeur(fs),Observation(fs),Rôle(f1),Géométrie(f1),Dimension(f1),Nature(f1),Profondeur(f1),Angle(f1),Observation(f1),Rôle(f2),Géométrie(f2),Dimension(f2),Nature(f2),Profondeur(f2),Angle(f2),Observation(f2),Rôle(f3),Géométrie(f3),Dimension(f3),Nature(f3),Profondeur(f3),Angle(f3),Observation(f3),Rôle(f4),Géométrie(f4),Dimension(f4),Nature(f4),Profondeur(f4),Angle(f4),Observation(f4),Rôle(f5),Géométrie(f5),Dimension(f5),Nature(f5),Profondeur(f5),Angle(f5),Observation(f5),Traces de mises en charge,Perturbation de l'écoulement,Précision,Défaut d'étanchéité,Traces d'infiltration,Branchement non étanche,Défaut de structure,Génie civil fissuré,Déboitement,Défaut de fermeture,Tampon détérioré,Présence d'H2S,Autres observations,$index");
      await file.writeAsString("\n$data",mode:FileMode.writeOnlyAppend);
    }
  }

  //ajoute un ouvrage avec si besoin un numéro d'affaire et/ou une commune
  Future readAndUpdateList() async{
    List<FileSystemEntity> listFile = new List<FileSystemEntity>();
    listFile = myDir.listSync(recursive: true, followLinks: false);
    List<String> textSplit;
    List<String> lineSplit;

    for(FileSystemEntity tmp in listFile){
      String text = await readData(tmp.path);
      lineSplit = text.split("\n");

      for(var i=1;i<lineSplit.length-1;i++){
        textSplit = lineSplit[i].split(",");
        addREFOuvrage(textSplit[0], textSplit[1], textSplit[2], textSplit[3]);
      }
    }
    print("list retourné");
  }

  void addREFOuvrage(String numeroAffaire,String nomCommune,String refCommune,String refOuvrage){
    
    Commune _nouvelCommune = new Commune(nomCommune,refCommune);
    Ouvrage _nouvelOuvrage = new Ouvrage(refOuvrage);
    _nouvelCommune.addOuvrage(_nouvelOuvrage);
    dernierNumeroAffaire = numeroAffaire;
    derniereCommune = _nouvelCommune;
      
    if (affaireIndex(numeroAffaire) != null){
      //numero d'affaire existant
      int index = affaireIndex(numeroAffaire);
      if(communeIndex(listNumeroAffaire[index].listCommune, nomCommune)==null){
        //commune non existante
        listNumeroAffaire[index].addCommune(_nouvelCommune);
      }
      else{
        //commune existante -> nouvel ouvrage
        int index2 = communeIndex(listNumeroAffaire[index].listCommune, nomCommune);
        listNumeroAffaire[index].listCommune[index2].addOuvrage(_nouvelOuvrage);
      }
    }
    else{
      //numéro d'affaire non-existant
      listNumeroAffaire.add(new NumeroAffaire(numeroAffaire,));
      listNumeroAffaire[listNumeroAffaire.length-1].addCommune(_nouvelCommune);
    }
  }

   //Méthode qui renvoie l'index d'un NuméroAffaire qui existe déjà
  int affaireIndex(String numero){
    if(listNumeroAffaire.isNotEmpty){
      for(int index=0;index<listNumeroAffaire.length;index++){
        if(listNumeroAffaire[index].numeroAffaire == numero){return index;}
      }
    }
    return null;
  }

  //Méthode qui renvoie l'index d'une commune qui existe déjà
  int communeIndex(List<Commune> listCommune, String nomCommune){
    if(listCommune.isNotEmpty){
      for(int index=0;index<listCommune.length;index++){
          if(listCommune[index].nomCommune == nomCommune){return index;}
      }
    }
    return null;
  }

}