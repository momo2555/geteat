import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:geteat/controllers/meal_controller.dart';
import 'package:geteat/models/meal_model.dart';

class KitchenEditMealElement extends StatefulWidget {
  const KitchenEditMealElement({
    super.key,
    required this.meal,
  });
  final MealModel meal;
  @override
  State<KitchenEditMealElement> createState() => _KitchenEditMealElementState();
}

class _KitchenEditMealElementState extends State<KitchenEditMealElement> {
  MealController _mealController = MealController();
  bool _dispoed = false;
  
  _updateAll() {
    _mealController.getImage(widget.meal).then((value) {
      setState(() {
        widget.meal.mealImage = value.mealImage;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _updateAll();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _updateAll();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _dispoed = true;
    super.dispose();
    
  }
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if(!_dispoed){
      super.setState(fn);
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, "/edit_meal", arguments: widget.meal);
        },
        child: Container(
          clipBehavior: Clip.antiAlias,
          width: double.infinity,
          height: 110,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          child: Row(
            
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SimpleText(
                        text:
                            "${widget.meal.mealName} - ${(widget.meal.mealPrice as num).toStringAsFixed(2)}€",
                        color: 2,
                        size: 16,
                        thick: 6,
                      ),
                      SimpleText(text: "${widget.meal.mealDescription}", color: 3, center: false,),
                    ],
                  ),
                ),
              ),
              Hero(
                tag: widget.meal.mealId,
                child: Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    image: MealController.decorationImage(widget.meal),
                  ),
                  child: widget.meal.mealImage != null ? null : Center(
                    child: Container(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
