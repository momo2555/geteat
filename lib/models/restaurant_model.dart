import 'dart:core';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RestaurantModel {
  String? _restaurantId;
  String? _restaurantName;
  String? _restaurantDescription;
  List<dynamic>? _restaurantHours = [Timestamp(0, 0),Timestamp(0, 0)];
  String? _restaurantImageName;
  File? _restaurantImage;
  List<dynamic>? _restaurantMeals = [];

  


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
  set restaurantMeals(value) {
    _restaurantMeals = value;
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
  get restaurantMeals {
    return _restaurantMeals;
  }

  String getOpenTimeAsString() {
    int hours = (_restaurantHours??[Timestamp(0, 0),Timestamp(0, 0)])[0].toDate().hour;
    int minutes = (_restaurantHours??[Timestamp(0, 0),Timestamp(0, 0)])[0].toDate().minute;
    return "${(hours/100).toStringAsFixed(2).split(".")[1]}:${(minutes/100).toStringAsFixed(2).split(".")[1]}";
  }
  String getCloseTimeAsString() {
    int hours = (_restaurantHours??[Timestamp(0, 0),Timestamp(0, 0)])[1].toDate().hour;
    int minutes = (_restaurantHours??[Timestamp(0, 0),Timestamp(0, 0)])[1].toDate().minute;
    return "${(hours/100).toStringAsFixed(2).split(".")[1]}:${(minutes/100).toStringAsFixed(2).split(".")[1]}";
  }
  TimeOfDay getOpenTime() {
    DateTime open = (_restaurantHours??[Timestamp(0, 0),Timestamp(0, 0)])[0].toDate();
    return TimeOfDay(minute: open.minute, hour: open.hour);
  }
  TimeOfDay getCloseTime() {
    DateTime open = (_restaurantHours??[Timestamp(0, 0),Timestamp(0, 0)])[1].toDate();
    return TimeOfDay(minute: open.minute, hour: open.hour);
  }

  setOpenTime(TimeOfDay time) {
     (_restaurantHours??[Timestamp(0, 0),Timestamp(0, 0)])[0] = Timestamp.fromDate(DateTime(1970, 1, 1, time.hour, time.minute));
  }
  setCloseTime(TimeOfDay time) {
     (_restaurantHours??[Timestamp(0, 0),Timestamp(0, 0)])[1] = Timestamp.fromDate(DateTime(1970, 1, 1, time.hour, time.minute));
  }

  dynamic toObject() {
    return {
      'restaurantName' : _restaurantName,
      'restaurantDescription' : _restaurantDescription,
      'restaurantHours' : _restaurantHours,
      'restaurantMeals' : _restaurantMeals,
      "restaurantImageName" : _restaurantImageName,
      
     
    };

  }
}