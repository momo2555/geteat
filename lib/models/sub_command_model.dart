
import 'package:geteat/controllers/meal_controller.dart';
import 'package:geteat/models/meal_model.dart';

class SubCommandModel {
  
  num? _subCommandTotalPrice = 0;
  MealModel _subCommandMeal = MealModel();
  List<dynamic>? _subCommandOptions = [];
  num? _subCommandLength = 1;
  String? _subCommandId = "";
  
  
   
   
  SubCommandModel() : super();

  set subCommandTotalPrice(value) {
    _subCommandTotalPrice = value;
  }
  set subCommandMeal(value) {
    _subCommandMeal = value;
  }
  set subCommandOptions(value) {
    _subCommandOptions = value;
  }
  set subCommandLength(value) {
    _subCommandLength = value;
  }
 set subCommandId(value) {
    _subCommandId = value;
  }

  
  get subCommandTotalPrice  {
    return _subCommandTotalPrice;
  }
   get subCommandId  {
    return _subCommandId;
  }
  MealModel get subCommandMeal {
    return _subCommandMeal;
  }
  get subCommandOptions {
    return _subCommandOptions;
  }
  get subCommandLength {
    return _subCommandLength;
  }
 
  String getOptionsAsText() {
    List<String> options = [];
    
    for (Map<String, dynamic> option in _subCommandOptions??[]) {
      
      if (option.keys.contains("contents")) {
        options.add((option["contents"] as List).join(","));
      }
      
    }
    return options.join(" | ");
  }

  dynamic toObject() {
    return {
     "subCommandLength" : _subCommandLength,
     "subCommandMealRef" : "${_subCommandMeal.mealId}",
     "subCommandOptions" : _subCommandOptions,
     "subCommandTotalPrice" : subCommandTotalPrice,
    };
  }

  factory SubCommandModel.fromDataBase(Map<String, dynamic> data) {
    SubCommandModel subCommandModel = SubCommandModel();
    subCommandModel.subCommandLength = data["subCommandLength"];
    subCommandModel.subCommandOptions = data["subCommandOptions"];
    subCommandModel.subCommandTotalPrice = data["subCommandTotalPrice"];
    
    //get meal obj
    return SubCommandModel();
  }


}