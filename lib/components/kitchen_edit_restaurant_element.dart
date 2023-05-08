import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:geteat/controllers/restaurant_controller.dart';
import 'package:geteat/models/restaurant_model.dart';
import 'package:geteat/utils/global_utils.dart';
import 'package:geteat/views/kitchen/edit_restaurant_page.dart';

class KitchenEditRestaurantElement extends StatefulWidget {
  const KitchenEditRestaurantElement({
    super.key,
    required this.restaurant,
  });
  final RestaurantModel restaurant;
  @override
  State<KitchenEditRestaurantElement> createState() =>
      _KitchenEditRestaurantElementState();
}

class _KitchenEditRestaurantElementState
    extends State<KitchenEditRestaurantElement> {
  RestaurantController _restaurantController = RestaurantController();
  bool _selected = false;
  void _updateAll() {
    _restaurantController.getImage(widget.restaurant).then((value) {
      setState(() {
        widget.restaurant.restaurantImage = value.restaurantImage;
      });
    });
  }
  void _selectListener() {
    if(Globals.kitchenSelectedRestaurantEdition.value == widget.restaurant.restaurantId) {
        setState(() {
          _selected = true;
        });
      }else {
        setState(() {
          _selected = false;
        });
      }
  }
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
  void initState() {
    // TODO: implement initState
    super.initState();
    _updateAll();
    Globals.kitchenSelectedRestaurantEdition.addListener(_selectListener);
  }

  @override
  void didUpdateWidget(covariant KitchenEditRestaurantElement oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    _updateAll();
    
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Globals.kitchenSelectedRestaurantEdition.removeListener(_selectListener);
    super.dispose();
    

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: InkWell(
        onTap: () {
          Globals.selectedRestaurantEdition = widget.restaurant;
          Globals.kitchenSelectedRestaurantEdition.value = widget.restaurant.restaurantId;
          
        },
        child: Container(
          clipBehavior: Clip.antiAlias,
          height: 150,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.all(Radius.circular(6)),
            image: _decorationImage(),
            border: _selected ? Border.all(color: Theme.of(context).primaryColorDark, width: 3):null
            
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color.fromARGB(105, 0, 0, 0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SimpleText(
                      text: "${widget.restaurant.restaurantName}",
                      size: 16,
                      thick: 5,
                    ),
                    IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return EditRestaurantPage(
                                restaurant: widget.restaurant,
                                isNew: false,
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.edit),
                        color: Theme.of(context).primaryColorLight)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
