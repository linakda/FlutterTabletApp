
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Storage{
  String refNumAffaire;

  Storage(String refNumAffaire){
    this.refNumAffaire=refNumAffaire;
  }
  Future<String> get localPath async {
    final dir = await getExternalStorageDirectory();
    return dir.path;
  }

  Future<File> get localFile async {
    final path = await localPath;
    String refNumAffaire=this.refNumAffaire;
    return File('$path/$refNumAffaire.txt');
  }

  Future<String> readData() async {
    try {
      final file = await localFile;
      String body = await file.readAsString();

      return body;
    } catch (e) {
      return e.toString();
    }
  }

  Future<File> writeData(String data) async {
    final file = await localFile;
    return file.writeAsString("$data");
  }
}