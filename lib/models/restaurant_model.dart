import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';

class RestaurantModel {
  String? _restaurantId;
  String? _restaurantName;
  String? _restaurantDescription;
  List<double>? _restaurantHours;
  String? _restaurantImageName;
  File? _restaurantImage;
  


  RestaurantModel() : super();


  set restaurantId(value) {
    _restaurantId = value;
  }
  set restaurantName(value) {
    _restaurantName = value;
  }
  set restaurantDescription(value) {
    _restaurantDescription = value;
  }
  set restaurantHours(value) {
    _restaurantHours = value;
  }
  set restaurantImage(value) {
    _restaurantImage = value;
  }
  set restaurantImageName(value) {
    _restaurantImageName = value;
  }

  get restaurantId {
    return _restaurantId;
  }
  get restaurantName {
    return _restaurantName;
  }
  get restaurantDescription {
    return _restaurantDescription;
  }
  get restaurantHours {
    return _restaurantHours;
  }
  get restaurantImage {
    return _restaurantImage;
  }
  get restaurantImageName {
    return _restaurantImageName;
  }

  dynamic toObject() {
    return {
      'restaurantName' : _restaurantName,
      'restaurantDescription' : _restaurantDescription,
      'restaurantHours' : _restaurantHours,
      
     
    };

  }
}