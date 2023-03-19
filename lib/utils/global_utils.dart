import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class Globals {
  static var userPosition = ValueNotifier<List<num>>([0,0]);
  static var userAddress = ValueNotifier<String>("");
  static var userCity = ValueNotifier<String>("");

}
