import 'package:geteat/models/mesl_subelement_model.dart';

class MealElementModel {
   MealElementModel(String title, String type, [List<MealSubelementModel> subelements = const [], max = 0, min = 0]){
    _type = type;
    _title = title;
    _min = min;
    _max = max;
    _subElements = subelements;
  }
  factory MealElementModel.fromObject(Map<String, dynamic> element) {
    var title = "";
    var type = "";
    var min = 0;
    var max = 0;
    List<MealSubelementModel> subElements = [];

    if (element.containsKey("title")) {
      title = element["title"];
    }
    if (element.containsKey("type")) {
      type = element["type"];
    }
    if (element.containsKey("max")) {
      max = element["max"];
    }
    if (element.containsKey("min")) {
      min = element["min"];
    }
    if (element.containsKey("elements")) {
      if (element["elements"] != null) {
        for (var subel in element["elements"]) {
          subElements.add(MealSubelementModel.fromObject(subel));
        }
      }
    }
    return MealElementModel(title, type, subElements, max, min);
  }
  String _title = "";
  String _type = "";
  int? _max;
  int? _min;
  List<MealSubelementModel> _subElements = [];



   set title(value) {
    _title = value;
  }
  set type(value) {
    _type = value;
  }
  set min(value) {
    _min = value;
  }
  set max(value) {
    _max = value;
  }
  set subElements(value) {
    _subElements = value;
  }

  get title{
    return _title;
  }
  get type{
    return _type;
  }
  get min {
    return _min;
  }
  get max{
    return _max;
  }
  List<MealSubelementModel> get subElements {
    return _subElements;
  }

  Map<String, dynamic> toObject() {
    Map<String, dynamic> obj =  {
      "title" : _title,
      "type" : _type,
      "elements" : _subElements.map((e) => e.toObject()).toList(),
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