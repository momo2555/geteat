import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geteat/models/meal_element_model.dart';
import 'package:geteat/models/restaurant_model.dart';

class MealModel {
  String? _mealId = "";
  String? _mealDescription = "";
  String? _mealName = "";
  String? _mealImageName = "meal.jpg";
  String? _mealCoverImageName = "meal_cover.png";
  num? _mealPrice = 0.0;
  List<dynamic>? _mealStruct;
  File? _mealImage;
  File? _mealCoverImage;
  String? _mealRestaurantId = "";
  MealModel() : super();

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
  set mealCoverImage(value) {
    _mealCoverImage = value;
  }
  set mealCoverImageName(value) {
    _mealCoverImageName = value;
  }
  set mealStruct(value) {
    _mealStruct = value;
  }
  set mealRestaurantId(value) {
   _mealRestaurantId = value;
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
  get mealCoverImage {
    return _mealCoverImage;
  }
  get mealCoverImageName {
    return _mealCoverImageName;
  }
  get mealStruct {
    return _mealStruct;
  }
  get mealRestaurantId {
    return _mealRestaurantId;
  }

  List<MealElementModel> getMealStruct() {
    List<MealElementModel> elemnts = [];
    for(var el in _mealStruct??[]) {
      elemnts.add(MealElementModel.fromObject(el));
    }
    return elemnts;
  }

  dynamic toObject() {
    return {
      'mealName' : _mealName,
      'mealDescription' : _mealDescription,
      'mealPrice' : _mealPrice,
      'mealImageName' : _mealImageName,
      'mealCoverImageName' : _mealCoverImageName,
      'mealStruct' : _mealStruct, 
      'mealRestaurantId' : _mealRestaurantId,
    };
  }


}