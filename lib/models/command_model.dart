import 'dart:core';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geteat/models/sub_command_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CommandModel {
  bool? _withCommandDetails;
  String? _commandId = "";
  GeoPoint? _commandPosition = const GeoPoint(0, 0);
  Timestamp? _commandDate = Timestamp(0, 0);
  num? _commandNumber = 0;
  String? _commandStatus = "";
  num? _commandTotalPrice = 0;
  String? _commandUserId = "";
  String? _commandPositionComment = "";

  List<SubCommandModel> _subCommands = [];
   
   
  CommandModel() : super();
  
  set withCommandDetails(value) {
    _withCommandDetails = value;
  }
  set commandId(value) {
    _commandId = value;
  }
  set commandPosition(value) {
    _commandPosition = value;
  }
  set commandDate(value) {
    _commandDate = value;
  }
  set commandNumber(value) {
    _commandNumber = value;
  }
  set commandStatus(value) {
    _commandStatus = value;
  }
  set commandTotalPrice(value) {
    _commandTotalPrice = value;
  }
  set commandUserId(value) {
    _commandUserId = value;
  }
  set commandPositionComment(value) {
    _commandPositionComment = value;
  }

 
  get withCommandDetails {
    return _withCommandDetails;
  }
  get commandId {
    return _commandId;
  } 
  get commandPosition {
    return _commandPosition;
  }
  Timestamp? get commandDate {
    return _commandDate;
  }
  get commandNumber {
    return _commandNumber;
  }
  get commandStatus {
    return _commandStatus;
  }
  get commandTotalPrice {
    return _commandTotalPrice;
  }
  get commandUserId {
    return _commandUserId;
  }
  get subCommandList {
    return _subCommands;
  }
  get commandPositionComment {
    return _commandPositionComment;
  }
 
  void addSubCommand(SubCommandModel subCommand) {
    _subCommands.add(subCommand);
  }
  void updateSubCommand(SubCommandModel subCommand, int index){
    _subCommands[index] = subCommand;
  }
  SubCommandModel? getSubCommand(SubCommandModel subCommand, int index) {
    return _subCommands[index];
  }
  SubCommandModel getLastAddedSubCommand() {
    return _subCommands.last;
  }

  dynamic toObject() {
    return {
      'commandPosition' : commandPosition,
      'commandDate' : _commandDate,
      'commandNumber' : _commandNumber,
      'commandStatus' : _commandStatus,
      'commandTotalPrice' : commandTotalPrice, 
      'commandUserId' : _commandUserId,
      'commandPositionComment' : _commandPositionComment,
    };
  }


}