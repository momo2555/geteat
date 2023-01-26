import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:geteat/models/restaurant_model.dart';

class RestaurantThumbnail extends StatefulWidget {
  const RestaurantThumbnail({Key? key, required this.restaurant})
      : super(key: key);
  final RestaurantModel restaurant;
  @override
  State<RestaurantThumbnail> createState() => _RestaurantThumbnailState();
}

class _RestaurantThumbnailState extends State<RestaurantThumbnail> {
  DecorationImage? _decorationImage() {
    return DecorationImage(
      image: AssetImage(widget.restaurant.restaurantImage),
      fit: BoxFit.cover,
      alignment: Alignment.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        Navigator.pushNamed(context, '/restaurant');
      }),
      child: SizedBox(
        height: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: widget.restaurant.restaurantName.trim(),
              child: Container(
                height: 130,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(15),
                  image: _decorationImage(),
                ),
              ),
            ),
            SizedBox(height: 15,),
            SimpleText(
              text: widget.restaurant.restaurantName,
              size: 15,
              color: 0,
              thick: 9,
            ),
            SimpleText(
              text: "Ferme à 2:00",
              size: 13,
              color: 1,
             
            ),
          ],
        ),
      ),
    );
  }
}
