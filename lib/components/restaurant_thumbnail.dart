import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:geteat/controllers/restaurant_controller.dart';
import 'package:geteat/models/restaurant_model.dart';

class RestaurantThumbnail extends StatefulWidget {
  const RestaurantThumbnail({Key? key, required this.restaurant})
      : super(key: key);
  final RestaurantModel restaurant;
  @override
  State<RestaurantThumbnail> createState() => _RestaurantThumbnailState();
}

class _RestaurantThumbnailState extends State<RestaurantThumbnail> {
  RestaurantController _restaurantController = RestaurantController();
  
  @override
  void initState() {
    // get imaqge
    super.initState();
    _restaurantController.getImage(widget.restaurant).then((value) {
      setState(() {
        
        widget.restaurant.restaurantImage = value.restaurantImage;
        
      });
    }
    );
  }
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
    return InkWell(
      onTap: (() {
        Navigator.pushNamed(context, '/restaurant', arguments: widget.restaurant);
      }),
      child: SizedBox(
        height: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: widget.restaurant.restaurantId,
              child: Container(
                height: 160,
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
