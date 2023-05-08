import 'package:flutter/material.dart';
import 'package:geteat/components/simple_text.dart';

class SimpleDropDown extends StatefulWidget {
  const SimpleDropDown({
    Key? key,
    required this.items,
    this.initialValue,
    this.focusNode,
    this.nextNode,
    this.onChange,
  }) : super(key: key);
  final List<String> items;
  final String? initialValue;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final Function(String value)? onChange;
  @override
  State<SimpleDropDown> createState() => _SimpleDropDownState();
}

class _SimpleDropDownState extends State<SimpleDropDown> {
  String _value = '';
  get getValue {
    return _value;
  }

  InputDecoration _lightDecorationFilled() {
    return InputDecoration(
      /*prefixIcon: widget.icon,
      hintText: widget.placeholder ?? '',
      prefixText: widget.type == "phone" ? "+33" : null,*/
      prefixStyle: TextStyle(
          color: Colors.green, fontWeight: FontWeight.bold, fontSize: 17),
      hintStyle: TextStyle(
          color: Theme.of(context).primaryColorLight,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w100),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
        borderSide: BorderSide(
          color: Color.fromARGB(255, 241, 241, 241),
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
        borderSide:
            BorderSide(color: Theme.of(context).backgroundColor, width: 2),
      ),

      fillColor: Color.fromARGB(255, 241, 241, 241),
      filled: true,
      contentPadding: const EdgeInsets.all(17),

      focusColor: Theme.of(context).primaryColorLight,
      suffixIconColor: Theme.of(context).accentColor,

      //labelText: widget.placeholder ?? '',
    );
  }

  @override
  void initState() {
    _value = widget.initialValue ?? (widget.items.length > 0 ? widget.items[0] : "");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      items: widget.items
          .map(
            (e) => DropdownMenuItem<String>(
              value: e,
              child: SimpleText(
                text: e,
                color: 3,
              ),
            ),
          )
          .toList(),
      onChanged: (val) {
        _value = val.toString();
        widget.onChange!(val.toString());
      },
      value: _value,
      isExpanded: true,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      dropdownColor: Theme.of(context).primaryColorLight,
      decoration: _lightDecorationFilled(),
      focusNode: widget.focusNode,
      onSaved: (value) {
        widget.nextNode?.requestFocus();
      },
    );
  }
}
