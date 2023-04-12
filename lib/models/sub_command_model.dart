
import 'package:geteat/models/meal_model.dart';

class SubCommandModel {
  num? _subCommandTotalPrice = 0;
  MealModel? _subCommandMeal;
  List<Map<String, dynamic>>? _subCommandOptions = [];
  num? _subCommandLength = 1;
  
  
   
   
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

  
  get subCommandTotalPrice {
    return _subCommandTotalPrice;
  }
  get subCommandMeal {
    return _subCommandMeal;
  }
  get subCommandOptions {
    return _subCommandOptions;
  }
  get subCommandLength {
    return _subCommandLength;
  }
 

  dynamic toObject() {
    return {
     
    };
  }


}