import 'package:flutter/material.dart';

class LoadModel {
  const LoadModel({required this.callback, this.afterCallback, this.minimumTime, this.message});
  final Function(BuildContext context) callback;
  final Function(BuildContext context)? afterCallback;
  final int? minimumTime;
  final String? message;
}