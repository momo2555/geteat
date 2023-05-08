import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geteat/components/action_button.dart';
import 'package:geteat/components/edit_meal/edit_meal_element.dart';
import 'package:geteat/components/simpleDropDown.dart';
import 'package:geteat/components/simple_input.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:geteat/models/meal_element_model.dart';
import 'package:geteat/models/mesl_subelement_model.dart';
import 'package:geteat/utils/meal_utils.dart';

class EditMealElementsGroup extends StatefulWidget {
  const EditMealElementsGroup({
    super.key,
    required this.elements,
    required this.onChanged,
    required this.index,
  });
  final MealElementModel elements;
  final Function(MealElementModel group, int index) onChanged;
  final int index;

  @override
  State<EditMealElementsGroup> createState() => _EditMealElementsGroupState();
}

class _EditMealElementsGroupState extends State<EditMealElementsGroup> {
  MealElementModel _elData = MealElementModel("", "");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _elData = widget.elements;
  }

  @override
  Widget build(BuildContext context) {
    int i = -1;
    List<EditMealElement> tiles =
        (_elData.subElements).map((e) {
          i++;
      return EditMealElement(
        element: e,
        index: i,
        onChanged: (subel, index) {
          _elData.subElements[index] = subel;
          widget.onChanged(_elData, widget.index);
        },
        key: ValueKey(e),
      );
    }).toList();
    return ExpansionTile(
      leading: IconButton(
        onPressed: () async {
          await _editGroup();
        },
        icon: Icon(Icons.edit),
        color: Theme.of(context).primaryColorDark,
      ),
      subtitle: SimpleText(
        text: "${_elData.type}",
        color: 3,
        center: false,
      ),
      initiallyExpanded: true,
      title: SimpleText(
        text: "${_elData.title}",
        color: 3,
        center: false,
        thick: 6,
      ),
      children: [
        ReorderableListView(
          shrinkWrap: true,
          children: tiles,
          onReorder: (oldIndex, newIndex) {
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            setState(() {
              final item = _elData.subElements.removeAt(oldIndex);
              _elData.subElements.insert(newIndex, item);
            });
          },
        ),
        _elData.type != "text"
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration:
                          BoxDecoration(color: Theme.of(context).primaryColor),
                      child: IconButton(
                        onPressed: () async {
                          MealSubelementModel? newEl =
                              await MealUtils.editSubElemen(
                                  context, MealSubelementModel("", 0), true);
                          if (newEl != null) {
                            setState(() {
                              _elData.subElements.add(newEl );
                            });
                          }
                        },
                        icon: Icon(
                          Icons.add,
                          color: Theme.of(context).primaryColorLight,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Container(),
      ],
    );
  }

  _editGroup() async {
    MealElementModel? group = await MealUtils.editGroup(context, _elData);
    if (group != null) {
      setState(() {
        _elData = group;
      });
    }
  }
}
