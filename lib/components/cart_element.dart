import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/action_button.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:geteat/controllers/command_controller.dart';
import 'package:geteat/controllers/meal_controller.dart';
import 'package:geteat/controllers/restaurant_controller.dart';
import 'package:geteat/lang/lang.dart';
import 'package:geteat/models/meal_model.dart';
import 'package:geteat/models/restaurant_model.dart';
import 'package:geteat/models/sub_command_model.dart';
import 'package:provider/provider.dart';

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
  RestaurantModel? _restaurant;
  MealController _mealController = MealController();
  RestaurantController _restaurantController = RestaurantController();
  CommandController _commandController = CommandController();
  setupAll() {
    _mealController.getMealUpdate(widget.subCommand.subCommandMeal, true).then(
      (value) async {
        _restaurant = await _restaurantController.getRestaurantById(value.mealRestaurantId);
        try {
          
          setState(()  {
            _meal = value;
           
          });
          
        } catch (e) {
          print("error cart element");
        }
      },
    );
    
  }
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
    setupAll();
  }

  @override
  void didUpdateWidget(covariant CartElement oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    super.activate();
   setupAll();
  }

  @override
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
                    text: _restaurant!=null? _restaurant?.restaurantName : "",
                    color: 2,
                    size: 16,
                    thick: 7,
                  ),
                  SimpleText(
                    text:
                        "${widget.subCommand.subCommandLength}x ${_meal?.mealName ?? ''}",
                    color: 3,
                    thick: 5,
                    size: 12,
                  ),
                ],
              ),
            ),
          ),
          SimpleText(
            text:
                "${widget.subCommand.subCommandTotalPrice.toStringAsFixed(2)}€",
            color: 2,
            size: 16,
            thick: 5,
          ),
          IconButton(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: SimpleText(
                      text: Lang.l("Supressions"),
                      color: 2,
                    ),
                    content: SimpleText(
                        text:
                            Lang.l("Voulez vous vraiment supprimer cette élement de votre panier"),
                        color: 2),
                    actions: [
                      ActionButton(
                        backColor: Theme.of(context).primaryColorDark,
                        text: Lang.l("Annuler"),
                        filled: true,
                        action: () {
                          Navigator.pop(context);
                        },
                      ),
                      ActionButton(
                        filled: true,
                        text: Lang.l("Supprimer"),
                        action: () async {
                          await _commandController
                              .deleteCartSubCommand(widget.subCommand);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
