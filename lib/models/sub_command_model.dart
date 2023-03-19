
import 'package:geteat/models/meal_model.dart';

class SubCommandModel {
  num? _subCommandTotalPrice;
  MealModel? _subCommandMeal;
  Map<String, dynamic>? _subCommandOptions;
  
  
   
   
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


  get subCommandTotalPrice {
    return _subCommandTotalPrice;
  }
  get subCommandMeal {
    return _subCommandMeal;
  }
  get subCommandOptions {
    return _subCommandOptions;
  }
 

  dynamic toObject() {
    return {
     
    };
  }


}