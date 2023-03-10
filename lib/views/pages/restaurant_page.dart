import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/meal_thumbnail.dart';
import 'package:geteat/components/simple_close_button.dart';
import 'package:geteat/controllers/meal_controller.dart';
import 'package:geteat/models/meal_model.dart';
import 'package:geteat/models/restaurant_model.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({Key? key,required this.restaurant,}) : super(key: key);
  final RestaurantModel restaurant;
  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  MealController _mealController = MealController();
  DecorationImage? _decorationImage() {
    if(widget.restaurant.restaurantImage != null){
      return DecorationImage(
        image: FileImage(widget.restaurant.restaurantImage) ,
        fit: BoxFit.cover,
        alignment: Alignment.center,
      );
    }else {
      return null;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
      ),
      body: Container(
        decoration: BoxDecoration(color: Theme.of(context).primaryColorLight),

        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Hero(
                    tag: widget.restaurant.restaurantId,
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        image: _decorationImage(),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 15,
                    child: SimpleCloseButton(),
                  ),
                ],
              ),
             Builder(builder: (context) {
              List<Widget> meals = [];
              for(DocumentReference ref in widget.restaurant.restaurantMeals) {
                meals.add(FutureBuilder(
                  future: _mealController.getMeal(ref),
                  builder: (context, snapshot) {
                  if(snapshot.hasData){
                    print(snapshot.data);
                    return MealThumbnail(meal: snapshot.data as MealModel);
                  }
                  return Container();
                },));
              }
              return Column(
                children: meals,
              );
             },)
            ],
          ),
        ),
      ),
    );
  }
}
