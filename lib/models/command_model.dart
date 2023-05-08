import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';

class CommandModel {
  String? _mealId;
  String? _mealDescription;
  String? _mealName;
  String? _mealImageName;
  num? _mealPrice;
  List<dynamic>? _mealStruct;
  File? _mealImage;
   
   
  CommandModel() : super();

  set mealId(value) {
    _mealId = value;
  }
  set mealName(value) {
    _mealName = value;
  }
  set mealDescription(value) {
    _mealDescription = value;
  }
  set mealPrice(value) {
    _mealPrice = value;
  }
  set mealImage(value) {
    _mealImage = value;
  }
  set mealImageName(value) {
    _mealImageName = value;
  }
  set mealStruct(value) {
    _mealStruct = value;
  }


  get mealId {
    return _mealId;
  }
  get mealName {
    return _mealName;
  }
  get mealDescription {
    return _mealDescription;
  }
  get mealPrice {
    return _mealPrice;
  }
  get mealImage {
    return _mealImage;
  }
  get mealImageName {
    return _mealImageName;
  }
  get mealStruct {
    return _mealStruct;
  }


  dynamic toObject() {
    return {
      'mealName' : _mealName,
      'mealtDescription' : _mealDescription,
      'mealPrice' : _mealPrice,
      'mealImageName' : _mealImageName,
      'mealStruct' : _mealStruct, 
    };
  }


}