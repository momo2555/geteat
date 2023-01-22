import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/restaurant_thumbnail.dart';

class RestaurantlistPage extends StatefulWidget {
  const RestaurantlistPage({Key? key}) : super(key: key);

  @override
  State<RestaurantlistPage> createState() => _RestaurantlistPageState();
}

class _RestaurantlistPageState extends State<RestaurantlistPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        children: [
          SizedBox(height: 100,),
          RestaurantThumbnail(image: "assets/images/resto_1.jpg", name : "POKE - Hawaiian Food"),
          RestaurantThumbnail(image: "assets/images/resto_2.jpg", name : "FRENCHIE - French Tacos"),
          RestaurantThumbnail(image: "assets/images/resto_3.jpg", name : "ITALIAN - Napolitan Pizza"),
        ],
      ),
    );
  }
}