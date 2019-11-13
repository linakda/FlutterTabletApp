
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Storage{

  Future<String> get localPath async {
    final dir = await getExternalStorageDirectory();
    return dir.path;
  }

  Future<File> get localFile async {
    final path = await localPath;
    print('path = $path');
    return File('$path');
  }

  Future<String> readData(String path) async {
    try {
      final file = await localFile;
      final file2 = File('$path');
      
      String body = await file2.readAsString();
      print(body);
      return body;

    } catch (e) {
      return e.toString();
    }
  }

  Future<File> writeData(String data, String dirPath, String fileName) async {
    File file= new File('$dirPath/$fileName.txt');
    //await localFile.then((onValue){file = File("$onValue/$fileName.txt");});
    return file.writeAsString("$data");
  }
}