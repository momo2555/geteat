import 'package:flutter/foundation.dart';

class MealSubelementModel {
  MealSubelementModel(String value, num price, [max = 0, min = 0]){
    _price = price;
    _value = value;
    _max = max;
    _min = min;
  }
  factory MealSubelementModel.fromObject(Map<String, dynamic> element) {
    var value = "";
    num price = 0.0;
    var min = 0;
    var max = 0;

    if (element.containsKey("value")) {
      value = element["value"];
    }
    if (element.containsKey("price")) {
      price = element["price"];
    }
    if (element.containsKey("max")) {
      max = element["max"];
    }
    if (element.containsKey("min")) {
      min = element["min"];
    }
    return MealSubelementModel(value, price, max, min);
  }
  String _value = "";
  num _price = 0.0;
  int? _max;
  int? _min;

  set value(value) {
    _value = value;
  }
  set price(value) {
    _price = value;
  }
  set min(value) {
    _min = value;
  }
  set max(value) {
    _max = value;
  }

  get value{
    return _value;
  }
  get price{
    return _price;
  }
  get min {
    return _min;
  }
  get max{
    return _max;
  }

  Map<String, dynamic> toObject() {
    Map<String, dynamic> obj =  {
      "value" : _value,
      "price" : _price,
    };
    if (_min!=null) {
      obj["min"] = _min;
    }
    if(_max!=null) {
      obj["max"] = _max;
    }
    return obj;
  }



}