import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geteat/components/edit_meal/edit_meal_elements_group.dart';
import 'package:geteat/components/simple_close_button.dart';
import 'package:geteat/components/simple_input.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:geteat/controllers/meal_controller.dart';
import 'package:geteat/models/meal_model.dart';

class EditMealPage extends StatefulWidget {
  const EditMealPage({
    super.key,
    required this.meal,
  });
  final MealModel meal;

  @override
  State<EditMealPage> createState() => _EditMealPageState();
}

class _EditMealPageState extends State<EditMealPage> {
  MealController _mealController = MealController();
  MealModel _copy = MealModel();
  List<Widget> _tiles = [];
  bool _isNew = false;
  Widget _showProperties() {
    return ReorderableListView(
      
      shrinkWrap: true,
      onReorder: (oldIndex, newIndex) {
        if (newIndex > oldIndex) {
          newIndex -= 1;
        }
        setState(() {
          final item = _tiles.removeAt(oldIndex);
          _tiles.insert(newIndex, item);
        });
      },
      children: _tiles,
    );
  }

  Widget _editButton(Function() onClick) {
    return Container(
      width: 45,
      height: 45,
      color: Theme.of(context).primaryColorDark,
      child: IconButton(
        color: Theme.of(context).primaryColorLight,
        icon: Icon(Icons.edit),
        onPressed: () {
          onClick();
        },
      ),
    );
  }

  DecorationImage? _decorationImage() {
    if (_copy.mealImage != null) {
      return DecorationImage(
        image: FileImage(_copy.mealImage),
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
    _copy = widget.meal;
    if (_copy.mealId == null || _copy.mealId == "") {
      _isNew = true;
    }
    if (widget.meal.mealStruct != null) {
      for (Map<String, dynamic> el in widget.meal.mealStruct) {
        _tiles.add(EditMealElementsGroup(elements: el, key: ValueKey(el)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColorLight,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 0,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: double.infinity,
                    height: 170,
                    decoration: BoxDecoration(
                      image: _decorationImage(),
                    ),
                  ),
                  Positioned(
                    right: 100,
                    bottom: 0,
                    child: _editButton(() {}),
                  ),
                  Positioned(
                    top: 45,
                    left: 15,
                    child: SimpleCloseButton(),
                  ),
                  Positioned(
                    left: 100,
                    top: 80,
                    child: Hero(
                      tag: widget.meal.mealId,
                      child: Stack(
                        children: [
                          Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                                image: _decorationImage(),
                                border: Border.all(
                                    color: Theme.of(context).primaryColorLight,
                                    width: 8)),
                          ),
                          Positioned(
                            right: 8,
                            bottom: 8,
                            child: _editButton(() {}),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 100,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SimpleText(
                      text: "Nom du Menu",
                      color: 2,
                      thick: 6,
                    ),
                    SimpleInput(
                      style: "light",
                      value: _copy.mealName ?? "",
                      onChange: (value) {
                        _copy.mealName = value;
                      },
                    ),
                    SizedBox(height: 20),
                    // ----------------------------------
                    SimpleText(
                      text: "Description du Menu",
                      color: 2,
                      thick: 6,
                    ),
                    SimpleInput(
                      style: "light",
                      maxLines: 3,
                      type: "multiline",
                      value: _copy.mealDescription ?? "",
                      onChange: (value) {
                        _copy.mealDescription = value;
                      },
                    ),
                    SizedBox(height: 20),
                    // ----------------------------------
                    SimpleText(
                      text: "Prix du Menu",
                      color: 2,
                      thick: 6,
                    ),
                    SimpleInput(
                      style: "light",
                      maxLines: 3,
                      type: "spinbox",
                      value: _copy.mealPrice.toString(),
                      onChange: (value) {
                        _copy.mealPrice = num.parse(value);
                      },
                    ),
                    SizedBox(height: 20),
                    _showProperties(),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
