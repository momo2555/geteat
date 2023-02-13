import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/action_button.dart';
import 'package:geteat/components/meal_elements.dart';
import 'package:geteat/components/simple_close_button.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:geteat/models/meal_model.dart';
import 'package:geteat/themes/main_theme.dart';

class MealPage extends StatefulWidget {
  const MealPage({
    Key? key,
    required this.meal,
  }) : super(key: key);
  final MealModel meal;
  @override
  State<MealPage> createState() => _MealPageState();
}

class _MealPageState extends State<MealPage> {
  int _lenght = 0;
  DecorationImage? _decorationImage() {
    if(widget.meal.mealImage != null) {
      print(widget.meal.mealImage);
      return DecorationImage(
        image: FileImage(widget.meal.mealImage) ,
        fit: BoxFit.cover                       ,
        alignment: Alignment.center             ,
      );
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 241, 241),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 5,
        child: Container(
          height: 130,
          child: Padding(
            padding: const EdgeInsets.all(7.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: (() {}),
                        icon: Icon(Icons.do_not_disturb_on_outlined)),
                    SimpleText(
                      text: '${_lenght}',
                      color: 2,
                      thick: 7,
                      size: 15,
                    ),
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.add_circle_outline))
                  ],
                ),
                ActionButton(
                  text: 'Ajouter ${_lenght} au panier - ',
                  color: Theme.of(context).primaryColor,
                  filled: true,
                  hasBorder: true,
                  expanded: true,
                  action: () {},
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Hero(
                    tag: widget.meal.mealId,
                    child: Container(
                      width: double.infinity,
                      height: 150,
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
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  width: double.infinity,
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColorLight),
                  padding: EdgeInsets.fromLTRB(16, 18, 16, 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SimpleText(
                        text: widget.meal.mealName.toUpperCase(),
                        size: 20,
                        color: 2,
                        thick: 6,
                      ),
                      SimpleText(
                        text: "5.25€",
                        size: 16,
                        color: 2,
                        thick: 6,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: SimpleText(
                          text:
                              widget.meal.mealDescription,
                          color: 2,
                          center: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              MealElements(elementData: {
                "title": "Choisissez votre base",
                "type": "radiolist",
                "elements": [
                  {"value": "Riz vinaingré", "price": "0"},
                  {"value": "Carottes rappées", "price": "0"}
                ]
              }),
              MealElements(elementData: {
                "title": "Choisissez votre boisson",
                "type": "checklist",
                "elements": [
                  {"value": "Coca-Cola", "price": "0"},
                  {"value": "Fanta", "price": "0"},
                  {"value": "Orangina", "price": "0"}
                ]
              }),
              MealElements(elementData: {
                "title": "Choisissez vos sauces",
                "type": "multilist",
                "elements": [
                  {"value": "Harissa", "price": "0"},
                  {"value": "Andalous", "price": "0"},
                  {"value": "Samouraï", "price": "0"}
                ]
              }),
            ],
          ),
        ),
      ),
    );
  }
}
