import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:geteat/controllers/meal_controller.dart';
import 'package:geteat/models/meal_model.dart';
import 'package:geteat/models/sub_command_model.dart';

class CartElement extends StatefulWidget {
  const CartElement({
    Key? key,
    required this.subCommand,
  }) : super(key: key);
  final SubCommandModel subCommand;
  @override
  State<CartElement> createState() => _CartElementState();
}

class _CartElementState extends State<CartElement> {
  MealModel? _meal;
  MealController _mealController = MealController();
  @override
  DecorationImage? _decorationImage() {
    if (_meal != null && _meal!.mealImage != null) {
      return DecorationImage(
        image: FileImage(_meal?.mealImage),
        fit: BoxFit.cover,
        alignment: Alignment.center,
        
      );
    } else {
      return null;
    }
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mealController.getMealUpdate(widget.subCommand.subCommandMeal, true).then((value) {
      setState(() {
        _meal = value;
      });
    });
  }

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        children: [
          Container(
            height: 54,
            width: 54,
            decoration: BoxDecoration(
              image: _decorationImage(),
              borderRadius: BorderRadius.all(Radius.circular(15)),
              
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SimpleText(
                    text: "Pokea",
                    color: 2,
                    size: 16,
                    thick: 7,
                  ),
                  SimpleText(
                    text: "${widget.subCommand.subCommandLength}x ${_meal?.mealName ?? ''}",
                    color: 3,
                    thick: 5,
                    size: 12,
                  ),
                ],
              ),
            ),
          ),
          SimpleText(
            text: "${widget.subCommand.subCommandTotalPrice.toStringAsFixed(2)}€" ,
            color: 2,
            size: 16,
            thick: 5,
          )
        ],
      ),
    );
  }
}
