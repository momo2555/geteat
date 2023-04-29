import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:geteat/models/user_model.dart';

class UserProfileModel extends UserModel {
  String? _userName;
  String? _userFirstName;
  String? _userLastName;
  String? _userProfileImage;
  String? _userProfileImageURL;
  double? _userRate;
  String? _userDescription;
  String? _userAddress;
  String? _userCity;
  GeoPoint? _userPosition;
  String? _userType = "client";
  File? _userProfileImageFile;
  UserProfileModel(email, phone, password, uid) : super(email, phone, password, uid);
  UserProfileModel.byModel(UserModel user)
      : super(user.email, user.phone,'', user.uid);
  set userName(String? value) {
    _userName = value;
  }
 
  set userFirstName(String? value) {
    _userFirstName = value;
  }

  set userLastName(String? value) {
    _userLastName = value;
  }

  set userProfileImage(String? value) {
    _userProfileImage = value;
  }

  set userProfileImageURL(String? value) {
    _userProfileImageURL = value;
  }

  set userRate(double? value) {
    _userRate = value;
  }

  set userDescription(String? value) {
    _userDescription = value;
  }
  set userProfileImageFile(value) {
    _userProfileImageFile = value;
  }
  set userAddress(value) {
    _userAddress = value;
  }
  set userCity(value) {
    _userCity = value;
  }
  set userType(value) {
    _userType = value;
  }
  set userPosition(value) {
    _userPosition = value;
  }
  String? get userName {
    return _userName;
  }

  String? get userFirstName {
    return _userFirstName;
  }

  String? get userLastName {
    return _userLastName;
  }

  String? get userProfileImage {
    return _userProfileImage;
  }

  String? get userProfileImageURL {
    return _userProfileImageURL;
  }

  double? get userRate {
    return _userRate;
  }

  String? get userDescription {
    return _userDescription;
  }
  String? get userAddress {
    return _userAddress;
  }

  String? get userCity{
    return _userCity;
  }
  get userProfileImageFile {
    return _userProfileImageFile;
  }
  get userType {
    return _userType;
  }
  get userPosition {
    return _userPosition;
  }

  Map<String, dynamic> toObject() {
    return {
      'userUid' : uid,
      'userPhone' : phone,
      'userEmail' : email,
      'userType' : _userType ?? 0,
      'userName' : _userName ?? '',
      'userCity' : _userCity ?? "",
      'userAddress' : _userAddress ?? "",
      'userProfileImage' : _userProfileImageURL ?? '',
      'userRate' : _userRate ?? 0.0,
      'userPosition' : _userPosition ?? const GeoPoint(0, 0),
    };

  }
}
