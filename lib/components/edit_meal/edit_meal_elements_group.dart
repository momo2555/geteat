import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geteat/components/action_button.dart';
import 'package:geteat/components/edit_meal/edit_meal_element.dart';
import 'package:geteat/components/simpleDropDown.dart';
import 'package:geteat/components/simple_input.dart';
import 'package:geteat/components/simple_text.dart';

class EditMealElementsGroup extends StatefulWidget {
  const EditMealElementsGroup({
    super.key,
    required this.elements,
  });
  final Map<String, dynamic> elements;

  @override
  State<EditMealElementsGroup> createState() => _EditMealElementsGroupState();
}

class _EditMealElementsGroupState extends State<EditMealElementsGroup> {
  String _title = "";
  int? _max;
  int? _min;
  String _type = "";
  List<dynamic> _subElements = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.elements.containsKey("title")) {
      _title = widget.elements["title"];
    }
    if (widget.elements.containsKey("max")) {
      _max = widget.elements["max"];
    }
    if (widget.elements.containsKey("min")) {
      _min = widget.elements["min"];
    }
    if (widget.elements.containsKey("type")) {
      _type = widget.elements["type"];
    }
    if (widget.elements.containsKey("type")) {
      _type = widget.elements["type"];
    }
    if (widget.elements.containsKey("elements")) {
      if (widget.elements["elements"] != null) {
        _subElements = widget.elements["elements"];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: true,
      title: Row(
        children: [
          IconButton(
            onPressed: () async {
              await _editGroup(context);
            },
            icon: Icon(Icons.edit),
            color: Theme.of(context).primaryColorDark,
          ),
          const SizedBox(
            width: 30,
          ),
          Expanded(
            child: SimpleText(
              text: "$_title",
              color: 3,
              center: false,
              thick: 6,
            ),
          ),
          SimpleText(
            text: "$_type",
            color: 3,
          ),
        ],
      ),
      children: [
        ReorderableListView(
          shrinkWrap: true,
          children: _subElements
              .map((e) => EditMealElement(
                    element: e,
                    key: ValueKey(e),
                  ))
              .toList(),
          onReorder: (oldIndex, newIndex) {
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            setState(() {
              final item = _subElements.removeAt(oldIndex);
              _subElements.insert(newIndex, item);
            });
          },
        ),
        _type != "text" ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor
                ),
                child: IconButton(onPressed: () {}, icon: Icon(
                  Icons.add,
                  color: Theme.of(context).primaryColorLight,
              
                ),),
              ),
            ],
          ),
        ) : Container(),
      ],
    );
  }

  Future<void> _editGroup(BuildContext context) async {
    String titleCopy = _title;
    String typeCopy = _type;
    int? maxCopy = _max;
    int? minCopy = _min;

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
                  value: titleCopy,
                  onChange: (value) {
                    titleCopy = value;
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
                  initialValue: typeCopy,
                  onChange: (value) {
                    _setState(() {
                      typeCopy = value;
                    });
                    print(typeCopy);
                  },
                ),
                SizedBox(height: 20),
                // ----------------------------------
                if (typeCopy == "checklist") ...[
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
                    initialValue: (minCopy ?? 0).toString(),
                    onChange: (value) {
                      _setState(() {
                        minCopy = int.parse(value);
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
                    initialValue: (maxCopy ?? 0).toString(),
                    onChange: (value) {
                      _setState(() {
                        maxCopy = int.parse(value);
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
      setState(() {
        _type = typeCopy;
        _title = titleCopy;
        _min = minCopy;
        _max = maxCopy;
      });
    }
  }
}
