import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:geteat/components/action_button.dart';

class FocusButton extends StatefulWidget {
  const FocusButton({
    Key? key,
    required this.buttonList,
    required this.byDefault,
    this.onChange,
  }) : super(key: key);
  final List<String> buttonList;
  final String byDefault;
  final Function(String)? onChange;
  @override
  State<FocusButton> createState() => _FocusButtonState();
}

class _FocusButtonState extends State<FocusButton> {
  String _focus = "";
  List<ChoiceChip> _buttons() {
    List<ChoiceChip> buttons = [];
    for (String button in widget.buttonList) {
      buttons.add(ChoiceChip(
        label: Text(button),
        labelStyle: TextStyle(
            color: _focus == button
                ? Theme.of(context).primaryColor
                : Theme.of(context).primaryColorLight),
        selectedColor: Theme.of(context).primaryColorLight,
        selected: _focus == button,
        backgroundColor: Theme.of(context).primaryColorDark,
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        onSelected: (value) {
          setState(() {
            _focus = button;
            widget.onChange != null ? widget.onChange!(_focus) : () {};
          });
        },
      ));
    }
    return buttons;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focus = widget.byDefault;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: _buttons(),
    );
  }
}
