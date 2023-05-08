import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geteat/components/kitchen_edit_meal_element.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:geteat/controllers/meal_controller.dart';
import 'package:geteat/models/meal_model.dart';
import 'package:geteat/utils/global_utils.dart';

class EditMealListPage extends StatefulWidget {
  const EditMealListPage({super.key});

  @override
  State<EditMealListPage> createState() => _EditMealListPageState();
}

class _EditMealListPageState extends State<EditMealListPage> {
  MealController _mealController = MealController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorLight,
        elevation: 2,
        foregroundColor: Theme.of(context).backgroundColor,
        title: SimpleText(
          text: "Menus",
          color: 2,
          thick: 6,
          size: 16,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: ValueListenableBuilder(
          valueListenable: Globals.kitchenSelectedRestaurantEdition,
          builder: (context, String value, widget) {
            if (value != "") {
              return FloatingActionButton(
                onPressed: () {
                  MealModel newMeal = MealModel();
                  newMeal.mealRestaurantId =
                      Globals.kitchenSelectedRestaurantEdition.value;
                  Navigator.pushNamed(context, "/edit_meal",
                      arguments: newMeal);
                },
                backgroundColor: Theme.of(context).primaryColor,
                child:
                    Icon(Icons.add, color: Theme.of(context).primaryColorLight),
                heroTag: "add_meal",
              );
            }else {
              return Container();
            }
          }),
      body: ValueListenableBuilder(
        valueListenable: Globals.kitchenSelectedRestaurantEdition,
        builder: (context, String value, child) {
          if (value != "") {
            return Container(
              padding: EdgeInsets.all(10),
              child: StreamBuilder(
                stream: _mealController
                    .getMealsOfRestaurant(Globals.selectedRestaurantEdition),
                builder: (context, AsyncSnapshot<List<MealModel>> snapshot) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          ...(snapshot.data ?? [])
                              .map((e) => KitchenEditMealElement(meal: e))
                              .toList(),
                          SizedBox(
                            height: 50,
                          )
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: Container(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    );
                  }
                },
              ),
            );
          } else {
            return Center(
              child: SimpleText(
                text: "Pas de restaurant sélectionné",
                color: 3,
                size: 24,
              ),
            );
          }
        },
      ),
    );
  }
}
