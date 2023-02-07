import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/menu_thumbnail.dart';
import 'package:geteat/components/simple_close_button.dart';
import 'package:geteat/models/restaurant_model.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({Key? key,required this.restaurant,}) : super(key: key);
  final RestaurantModel restaurant;
  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
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
              MenuThumbnail(),
              MenuThumbnail(),
              MenuThumbnail(),
              MenuThumbnail(),
              MenuThumbnail(),
              MenuThumbnail(),
              MenuThumbnail(),
              MenuThumbnail(),
              MenuThumbnail(),
              MenuThumbnail(),
            ],
          ),
        ),
      ),
    );
  }
}
