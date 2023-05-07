import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geteat/components/action_button.dart';
import 'package:geteat/components/simple_input.dart';
import 'package:geteat/components/simpleDropDown.dart';
import 'package:geteat/components/simple_text.dart';

class EditMealElement extends StatefulWidget {
  const EditMealElement({super.key, required this.element});
  final Map<String, dynamic> element;

  @override
  State<EditMealElement> createState() => _EditMealElementState();
}

class _EditMealElementState extends State<EditMealElement> {
  String _value = "";
  num _price = 0.0;
  int? _max;
  int? _min;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.element.containsKey("value")) {
      _value = widget.element["value"];
    }
    if (widget.element.containsKey("price")) {
      _price = widget.element["price"];
    }
    if (widget.element.containsKey("max")) {
      _max = widget.element["max"];
    }
    if (widget.element.containsKey("min")) {
      _min = widget.element["min"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, top: 5, bottom: 5, right: 5),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: () async {
                await _editGroup(context);
              },
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColorDark,
            ),
            Expanded(
              child: SimpleText(
                text: "$_value",
                color: 2,
                center: false,
              ),
            ),
            SimpleText(
              text: "${_price.toStringAsFixed(2)}€",
              color: 2,
              center: false,
            ),
            IconButton(
              onPressed: () async {
                //await _editGroup(context);
              },
              icon: Icon(Icons.delete),
              color: Theme.of(context).primaryColorDark,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _editGroup(BuildContext context) async {
    String valueCopy = _value;
    num priceCopy = _price;
    int? maxCopy = _max;
    int? minCopy = _min;

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
                  value: valueCopy,
                  onChange: (value) {
                    valueCopy = value;
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
                  value: priceCopy.toString(),
                  onChange: (value) {
                    priceCopy = num.parse(value);
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
                  initialValue: (maxCopy ?? 0).toString(),
                  onChange: (value) {
                    _setState(() {
                      maxCopy = int.parse(value);
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
      setState(() {
        _value = valueCopy;
        _price = priceCopy;
        _min = minCopy;
        _max = maxCopy;
      });
    }
  }
}
