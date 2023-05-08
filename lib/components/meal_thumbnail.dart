import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:geteat/controllers/meal_controller.dart';
import 'package:geteat/models/meal_model.dart';

class MealThumbnail extends StatefulWidget {
  const MealThumbnail({
    Key? key,
    required this.meal,
  }) : super(key: key);
  final MealModel meal;
  @override
  State<MealThumbnail> createState() => _MealThumbnailState();
}

class _MealThumbnailState extends State<MealThumbnail> {
  MealController _mealController = MealController();
  bool _diposed = false;

  _update() {
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
    _update();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if (!_diposed) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _diposed = true;
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant MealThumbnail oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    _update();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/meal', arguments: widget.meal);
        },
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SimpleText(
                  text: widget.meal.mealName,
                  size: 17,
                  color: 2,
                  thick: 6,
                ),
                SimpleText(
                  text: "5.25€",
                  color: 2,
                  thick: 6,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: SimpleText(
                    text: widget.meal.mealDescription,
                    color: 2,
                    center: false,
                  ),
                ),
              ],
            ),
          ),
          Hero(
            tag: widget.meal.mealId,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: MealController.decorationImage(widget.meal)),
            ),
          )
        ]),
      ),
    );
  }
}
