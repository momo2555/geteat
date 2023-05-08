import 'package:flutter/material.dart';
import 'package:geteat/components/action_button.dart';
import 'package:geteat/components/simpleDropDown.dart';
import 'package:geteat/components/simple_input.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:geteat/models/meal_element_model.dart';
import 'package:geteat/models/mesl_subelement_model.dart';

class MealUtils {
  static Future<MealSubelementModel?> editSubElemen(BuildContext context, MealSubelementModel subelement,[ bool isNew = false]) async {
    MealSubelementModel _copy = MealSubelementModel.fromObject(subelement.toObject());
    int? isOk = await showDialog<int>(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, _setState) {
          return AlertDialog(
            title: SimpleText(
              text: "Modification/Création d'un sous Element",
              color: 2,
              thick: 5,
              size: 20,
            ),
            scrollable: true,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SimpleText(
                  text: "Nom de l'élement",
                  color: 2,
                  thick: 6,
                ),
                SimpleInput(
                  style: "light",
                  value: _copy.value,
                  onChange: (value) {
                    _copy.value = value;
                  },
                ),
                SizedBox(height: 20),
                // ----------------------------------
                SimpleText(
                  text: "Prix supplément (0.0 = gratuit)",
                  color: 2,
                  thick: 6,
                ),
                SimpleInput(
                  style: "light",
                  type: "spinbox",
                  value: _copy.price.toString(),
                  onChange: (value) {
                    _copy.price = num.parse(value);
                  },
                ),
                SizedBox(height: 20),
                // ----------------------------------

                SimpleText(
                  text: "Minimum (seulment si multilist)",
                  color: 2,
                  thick: 6,
                ),
                SimpleDropDown(
                  items: [
                    "0",
                    "1",
                    "2",
                    "3",
                    "4",
                    "5",
                    "6",
                    "7",
                    "8",
                    "9",
                    "10"
                  ],
                  initialValue: (_copy.min ?? 0).toString(),
                  onChange: (value) {
                    _setState(() {
                      _copy.min = int.parse(value);
                    });
                  },
                ),
                SizedBox(height: 20),
                // ----------------------------------
                SimpleText(
                  text: "Maximum (seulment si multilist)",
                  color: 2,
                  thick: 6,
                ),
                SimpleDropDown(
                  items: [
                    "0",
                    "1",
                    "2",
                    "3",
                    "4",
                    "5",
                    "6",
                    "7",
                    "8",
                    "9",
                    "10"
                  ],
                  initialValue: (_copy.max ?? 0).toString(),
                  onChange: (value) {
                    _setState(() {
                      _copy.max = int.parse(value);
                    });
                  },
                ),
                SizedBox(height: 20),
                // ----------------------------------
              ],
            ),
            actions: [
              ActionButton(
                backColor: Theme.of(context).primaryColorDark,
                text: "Annuler",
                filled: true,
                action: () {
                  Navigator.pop(context, 0);
                },
              ),
              ActionButton(
                filled: true,
                text: "Enregistrer",
                action: () async {
                  Navigator.pop(context, 1);
                },
              ),
            ],
          );
        });
      },
    );
    if (isOk == 1) {
     return _copy;
    }else {
      return isNew ? null : subelement;
    }
  }

  static Future<MealElementModel?> editGroup(BuildContext context, MealElementModel group,[ bool isNew = false]) async {
    MealElementModel _copy =MealElementModel.fromObject(group.toObject());
    if( _copy.type == "") {
      _copy.type = "radiolist";
    }
    int? isOk = await showDialog<int>(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, _setState) {
          return AlertDialog(
            title: SimpleText(
              text: "Modification/Création d'un Element",
              color: 2,
              thick: 5,
              size: 20,
            ),
            scrollable: true,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SimpleText(
                  text: "Nom du choix",
                  color: 2,
                  thick: 6,
                ),
                SimpleInput(
                  style: "light",
                  value: _copy.title,
                  onChange: (value) {
                    _copy.title = value;
                  },
                ),
                SizedBox(height: 20),
                // ----------------------------------
                SimpleText(
                  text: "Type de choix",
                  color: 2,
                  thick: 6,
                ),
                SimpleDropDown(
                  items: ["checklist", "radiolist", "multilist", "text"],
                  initialValue: _copy.type,
                  onChange: (value) {
                    _setState(() {
                      _copy.type = value;
                    });
                    print(_copy.type);
                  },
                ),
                SizedBox(height: 20),
                // ----------------------------------
                if (_copy.type == "checklist") ...[
                  SimpleText(
                    text: "Minimum",
                    color: 2,
                    thick: 6,
                  ),
                  SimpleDropDown(
                    items: [
                      "0",
                      "1",
                      "2",
                      "3",
                      "4",
                      "5",
                      "6",
                      "7",
                      "8",
                      "9",
                      "10"
                    ],
                    initialValue: (_copy.min ?? 0).toString(),
                    onChange: (value) {
                      _setState(() {
                        _copy.min = int.parse(value);
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  // ----------------------------------
                  SimpleText(
                    text: "Maximum",
                    color: 2,
                    thick: 6,
                  ),
                  SimpleDropDown(
                    items: [
                      "0",
                      "1",
                      "2",
                      "3",
                      "4",
                      "5",
                      "6",
                      "7",
                      "8",
                      "9",
                      "10"
                    ],
                    initialValue: (_copy.max ?? 0).toString(),
                    onChange: (value) {
                      _setState(() {
                        _copy.max = int.parse(value);
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  // ----------------------------------
                ] else
                  Container(),
              ],
            ),
            actions: [
              ActionButton(
                backColor: Theme.of(context).primaryColorDark,
                text: "Annuler",
                filled: true,
                action: () {
                  Navigator.pop(context, 0);
                },
              ),
              ActionButton(
                filled: true,
                text: "Enregistrer",
                action: () async {
                  Navigator.pop(context, 1);
                },
              ),
            ],
          );
        });
      },
    );
    if (isOk == 1) {
      return _copy;
    }else {
      
      return isNew ? null : group;
    }
  }
}