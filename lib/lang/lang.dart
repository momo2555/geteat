import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';

class Lang {
  static const langCode = "al";
  static Future initLang() async {
    if(Lang.langCode!="fr") {
      String data = await rootBundle.loadString("assets/langs/$langCode.json");
      final jsonResult = jsonDecode(data); //latest Dart
      tradCache = jsonResult;

    }
  }
  static Map<String, dynamic> tradCache = {};
  static String l(String phrase, [List params = const []]) {
    if(Lang.langCode != "fr") {
      if(Lang.tradCache.containsKey(phrase)){
        phrase = Lang.tradCache[phrase];
      }
    }
    int i = 0;
    for(dynamic param in params) {
      phrase = phrase.replaceAll('\$$i', param.toString());
      i++;
    }
    return phrase;
  }
}

/*class FileSystemManager {
  static final FileSystemManager _instance = FileSystemManager._internal();
  // https://flutterbyexample.com/lesson/singletons
  // using a factory is important
  // because it promises to return _an_ object of this type
  // but it doesn't promise to make a new one.
  /*factory FileSystemManager() {
    return _instance();
  }*/
  
  // This named constructor is the "real" constructor
  // It'll be called exactly once, by the static property assignment above
  // it's also private, so it can only be called in this class
  FileSystemManager._internal() {
    // initialization logic 
  }
  
  // rest of class as normal, for example:
  void openFile() {}
  void writeFile() {}
}
*/
