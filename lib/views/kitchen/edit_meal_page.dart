import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geteat/components/action_button.dart';
import 'package:geteat/components/edit_meal/edit_meal_elements_group.dart';
import 'package:geteat/components/simple_close_button.dart';
import 'package:geteat/components/simple_input.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:geteat/controllers/meal_controller.dart';
import 'package:geteat/models/meal_element_model.dart';
import 'package:geteat/models/meal_model.dart';
import 'package:geteat/utils/meal_utils.dart';

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
  List<MealElementModel> _elements = [];
  bool _saving = false;
  bool _dispoed = false;
  bool _isNew = false;

  Widget _showProperties() {
    List<EditMealElementsGroup> tiles = [];
    int i = 0;

    for (MealElementModel el in _elements) {
      tiles.add(
        EditMealElementsGroup(
          elements: el,
          index: i,
          key: ValueKey(el),
          onChanged: (group, index) {
            _elements[index] = group;
          },
        ),
      );
      i++;
    }

    return ReorderableListView(
      shrinkWrap: true,
      onReorder: (oldIndex, newIndex) {
        if (newIndex > oldIndex) {
          newIndex -= 1;
        }
        setState(() {
          final item = _elements.removeAt(oldIndex);
          _elements.insert(newIndex, item);
        });
      },
      children: tiles,
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _copy = widget.meal;

    if (_copy.mealId == null || _copy.mealId == "") {
      _isNew = true;
    }
    if (_copy.mealStruct != null) {
      for (MealElementModel el in _copy.getMealStruct()) {
        _elements.add(el);
      }
    } else {
      _elements = [];
    }
    _mealController.getImage(_copy).then((value) {
      setState(() {
        _copy = value;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _dispoed = true;
    super.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if (!_dispoed) {
      super.setState(fn);
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
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 170,
                        decoration: BoxDecoration(
                          image: MealController.decorationCoverImage(_copy),
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 50,
                        color: Colors.transparent,
                      ),
                    ],
                  ),
                  Positioned(
                    right: 100,
                    bottom: 50,
                    child: _editButton(() async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        type: FileType.image,
                        allowMultiple: false,
                      );
                      if (result != null) {
                        if (result.paths.length > 0) {
                          if (result.paths[0] != null) {
                            setState(() {
                              _copy.mealCoverImage = File(result.paths[0]!);
                            });
                          }
                        }
                      }
                    }),
                  ),
                  Positioned(
                    top: 45,
                    left: 15,
                    child: SimpleCloseButton(),
                  ),
                  Positioned(
                    left: 100,
                    top: 80,
                    child: Stack(
                      children: [
                        Hero(
                          tag: widget.meal.mealId,
                          child: Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                                image: MealController.decorationImage(_copy),
                                color: Theme.of(context).colorScheme.surface,
                                border: Border.all(
                                    color: Theme.of(context).primaryColorLight,
                                    width: 8)),
                          ),
                        ),
                        Positioned(
                          right: 8,
                          bottom: 8,
                          child: _editButton(() async {
                            print("object");
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles(
                              type: FileType.image,
                              allowMultiple: false,
                            );
                            if (result != null) {
                              if (result.paths.length > 0) {
                                if (result.paths[0] != null) {
                                  setState(() {
                                    _copy.mealImage = File(result.paths[0]!);
                                  });
                                }
                              }
                            }
                          }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
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
                    SimpleText(
                      text: "Groupes de choix",
                      color: 2,
                      thick: 6,
                    ),
                    _showProperties(),
                    SizedBox(
                      height: 15,
                    ),
                    ActionButton(
                      filled: true,
                      text: "Nouveau Groupe de choix",
                      expanded: true,
                      action: () async {
                        MealElementModel? newGroup = await MealUtils.editGroup(
                            context, MealElementModel("", ""), true);
                        if (newGroup != null) {
                          setState(() {
                            _elements.add(newGroup);
                          });
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ActionButton(
                          backColor: Theme.of(context).primaryColorDark,
                          text: "Annuler",
                          filled: true,
                          action: () {
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        ActionButton(
                          filled: true,
                          wait: _saving,
                          text: "Enregistrer",
                          action: () async {
                            setState(() {
                              _saving = true;
                            });
                            _copy.mealStruct =
                                _elements.map((e) => e.toObject()).toList();
                            if (_isNew) {
                              await _mealController.createMeal(_copy);
                            } else {
                              await _mealController.editMeal(_copy);
                            }
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
