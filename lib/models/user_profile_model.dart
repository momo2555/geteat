import 'dart:io';

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
  get userProfileImageFile {
    return _userProfileImageFile;
  }

  Map<String, dynamic> toObject() {
    return {
      'userUid' : uid,
      'userPhone' : phone,
      'userEmail' : email,
      
      'userName' : _userName ?? '',
      'userProfileImage' : _userProfileImageURL ?? '',
      'userRate' : _userRate ?? 0.0
    };

  }
}
