import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class Globals {
  static var userPosition = ValueNotifier<List<num>>([0.0,0.0]);
  static var userAddress = ValueNotifier<String>("");
  static var userCity = ValueNotifier<String>("");
  static var goToKart = ValueNotifier<bool>(false);
  static void goBack(context) {
    Globals.goToKart.value = false;
    Navigator.pop(context);
  }

}
