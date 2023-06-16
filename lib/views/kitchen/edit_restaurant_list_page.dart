import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geteat/components/kitchen_edit_restaurant_element.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:geteat/controllers/restaurant_controller.dart';
import 'package:geteat/lang/lang.dart';
import 'package:geteat/models/restaurant_model.dart';
import 'package:geteat/views/kitchen/edit_restaurant_page.dart';

class EditRestaurantListPage extends StatefulWidget {
  const EditRestaurantListPage({super.key});

  @override
  State<EditRestaurantListPage> createState() => _EditRestaurantListPageState();
}

class _EditRestaurantListPageState extends State<EditRestaurantListPage> {
  @override
  RestaurantController _restaurantController = RestaurantController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorLight,
        elevation: 2,
        foregroundColor: Theme.of(context).backgroundColor,
        title: SimpleText(
          text: Lang.l("Restaurants"),
          color: 2,
          thick: 6,
          size: 16,
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      backgroundColor: Theme.of(context).primaryColorLight,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return EditRestaurantPage(
                restaurant: RestaurantModel(),
                isNew: true,
              );
            },
          );
        },
        backgroundColor: Theme.of(context).primaryColorDark,
        child: Icon(Icons.add, color: Theme.of(context).primaryColorLight),
        heroTag: "add_restaurant",
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder(
            stream: _restaurantController.getAllRestaurants(),
            builder: (context, AsyncSnapshot<List<RestaurantModel>?> snapshot) {
             
              if (snapshot.hasData) {
                return ListView(
                  children: [...(snapshot.data?.map(
                        (e) {
                          return KitchenEditRestaurantElement(
                            restaurant: e,
                          );
                        },
                      ).toList() ??
                      []), SizedBox(height: 50,)],
                );
              } else {
                return Center(
                  child: Container(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
