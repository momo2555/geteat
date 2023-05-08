import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geteat/components/action_button.dart';
import 'package:geteat/components/simple_input.dart';
import 'package:geteat/components/simple_input_label.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:geteat/controllers/restaurant_controller.dart';
import 'package:geteat/models/restaurant_model.dart';

class EditRestaurantPage extends StatefulWidget {
  const EditRestaurantPage({super.key, required this.restaurant, this.isNew});
  final bool? isNew;
  final RestaurantModel restaurant;
  @override
  State<EditRestaurantPage> createState() => _EditRestaurantPageState();
}

class _EditRestaurantPageState extends State<EditRestaurantPage> {
  RestaurantModel _copy = RestaurantModel();
  bool _isLoading = false;
  RestaurantController _restaurantController = RestaurantController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _copy = widget.restaurant;
  }

  DecorationImage? _decorationImage() {
    if (_copy.restaurantImage != null) {
      return DecorationImage(
        image: FileImage(_copy.restaurantImage),
        fit: BoxFit.cover,
        alignment: Alignment.center,
      );
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: SimpleText(
        text: widget.isNew ?? false
            ? "Créer un restaurant"
            : "Modifier un restaurant",
        color: 2,
        size: 16,
        thick: 5,
      ),
      content: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SimpleText(
              text: "Nom du restaurant",
              color: 2,
              thick: 6,
            ),
            SimpleInput(
              style: "light",
              value: _copy.restaurantName ?? "",
              onChange: (value) {
                _copy.restaurantName = value;
              },
            ),
            SizedBox(height: 15),
            // ----------------------------------
            SimpleText(
              text: "Description du restaurant",
              color: 2,
              thick: 6,
            ),
            SimpleInput(
              style: "light",
              maxLines: 3,
              type: "multiline",
              value: _copy.restaurantDescription ?? "",
              onChange: (value) {
                _copy.restaurantDescription = value;
              },
            ),
            SizedBox(height: 15),
            // ----------------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SimpleText(
                  text: "Heure d'ouverture : ${_copy.getOpenTimeAsString()}",
                  color: 2,
                  thick: 6,
                ),
                SizedBox(width: 25),
                ActionButton(
                  text: "Modifier",
                  filled: true,
                  backColor: Theme.of(context).primaryColorDark,
                  action: () async {
                    _copy.setOpenTime(await showTimePicker(
                          context: context,
                          initialTime: _copy.getOpenTime(),
                        ) ??
                        _copy.getOpenTime());
                    setState(() {
                      _copy = _copy;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 15),
            // ----------------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SimpleText(
                  text: "Heure de fermeture : ${_copy.getCloseTimeAsString()}",
                  color: 2,
                  thick: 6,
                ),
                SizedBox(width: 25),
                ActionButton(
                  text: "Modifier",
                  filled: true,
                  backColor: Theme.of(context).primaryColorDark,
                  action: () async {
                    _copy.setCloseTime(await showTimePicker(
                          context: context,
                          initialTime: _copy.getCloseTime(),
                        ) ??
                        _copy.getCloseTime());
                    setState(() {
                      _copy = _copy;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 15),
            // ----------------------------------
            SimpleText(
              text: "Photo de présentation",
              color: 2,
              thick: 6,
            ),
            Container(
              width: double.infinity,
              height: 130,
              decoration: BoxDecoration(
                  image: _decorationImage(),
                  color: Theme.of(context).colorScheme.surface),
            ),
            ActionButton(
              text: "Modifier",
              filled: true,
              backColor: Theme.of(context).primaryColorDark,
              expanded: true,
              action: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.image,
                  allowMultiple: false,
                );
                if(result!=null){
                  if(result.paths.length > 0) {
                    if(result.paths[0]!=null) {
                      setState(() {
                        _copy.restaurantImage = File(result.paths[0]!);
                      });
                      
                    }
                    
                  }
                }

              },
            ),
            SizedBox(height: 15),
            // ----------------------------------
          ],
        ),
      ),
      actions: [
        ActionButton(
          backColor: Theme.of(context).primaryColorDark,
          text: "Annuler",
          filled: true,
          action: () {
            Navigator.pop(context);
          },
        ),
        ActionButton(
          wait : _isLoading,
          filled: true,
          text: widget.isNew ?? false ? "Créer" : "Modifier",
          action: () async {
            setState(() {
              _isLoading = true;
            });
            if(widget.isNew??false) {   
              await _restaurantController.createRestaurant(_copy);
            }else {
              await _restaurantController.editRestaurant(_copy);
            }
            Navigator.pop(context);

          },
        ),
      ],
    );
  }
}
