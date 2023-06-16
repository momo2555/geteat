import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/action_button.dart';
import 'package:geteat/components/meal_thumbnail.dart';
import 'package:geteat/components/simple_close_button.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:geteat/controllers/meal_controller.dart';
import 'package:geteat/lang/lang.dart';
import 'package:geteat/models/meal_model.dart';
import 'package:geteat/models/restaurant_model.dart';
import 'package:geteat/utils/global_utils.dart';
import 'package:geteat/utils/icons_utils.dart';
import 'package:provider/provider.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({
    Key? key,
    required this.restaurant,
  }) : super(key: key);
  final RestaurantModel restaurant;
  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  MealController _mealController = MealController();
  DecorationImage? _decorationImage() {
    if (widget.restaurant.restaurantImage != null) {
      return DecorationImage(
        image: FileImage(widget.restaurant.restaurantImage),
        fit: BoxFit.cover,
        alignment: Alignment.center,
      );
    } else {
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
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: Globals.goToKart,
        builder: (context, bool value, child) {
          if (value) {
            return BottomAppBar(
              elevation: 5,
              child: Container(
                height: 130,
                child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: GeIcons.loadingOk,
                          ),
                          SimpleText(
                            text: Lang.l("Bien ajouté au panier"),
                            color: 2,
                            thick: 3,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 14),
                        child: ActionButton(
                          text: Lang.l('Voir mon panier').toUpperCase(),
                          color: Theme.of(context).primaryColor,
                          filled: true,
                          backColor: Theme.of(context).backgroundColor,
                          expanded: true,
                          action: () {
                            //go to cart
                            Globals.homeIndex.value = 1;
                            Globals.goBack(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Container(
              height: 0,
            );
          }
        },
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
                    top: 45,
                    left: 15,
                    child: SimpleCloseButton(),
                  ),
                ],
              ),
              StreamBuilder(
                stream: _mealController.getMealsOfRestaurant(widget.restaurant),
                builder: (context, AsyncSnapshot<List<MealModel>> snapshot) {
                  
                  if(snapshot.hasData){
                    return Column(
                      children: snapshot.data?.map((e) => MealThumbnail(meal: e)).toList()??[],
                    );
                  }else{
                    return Container(
                          height: 100,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        );

                  }
                       
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
