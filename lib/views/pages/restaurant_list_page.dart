import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/edit_address_button.dart';
import 'package:geteat/components/restaurant_thumbnail.dart';
import 'package:geteat/controllers/restaurant_controller.dart';
import 'package:geteat/models/restaurant_model.dart';

class RestaurantlistPage extends StatefulWidget {
  const RestaurantlistPage({Key? key}) : super(key: key);

  @override
  State<RestaurantlistPage> createState() => _RestaurantlistPageState();
}

class _RestaurantlistPageState extends State<RestaurantlistPage> {
  RestaurantController _restaurantController = RestaurantController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 5, 16, 0),
      child: StreamBuilder(
        stream: _restaurantController.getAllRestaurants(),
        builder: (context, snap){
          if(snap.hasData) {
            
            List<Widget> restaurantList = [EditAddressButton()];
            List<RestaurantModel> restaurants = snap.data as List<RestaurantModel>;
            for(RestaurantModel resto in restaurants) {
              restaurantList.add(RestaurantThumbnail(restaurant: resto));
            }
            return ListView(
              
              children: restaurantList,
            );
          }
          return Container();
      }),
    );
      
    
  }
}