import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/simple_text.dart';

class KitchenMenuElement extends StatefulWidget {
  const KitchenMenuElement({
    Key? key,
    required this.onClick,
    required this.text,
  }) : super(key: key);
  final String text;
  final Function() onClick;

  @override
  State<KitchenMenuElement> createState() => _KitchenMenuElementState();
}

class _KitchenMenuElementState extends State<KitchenMenuElement> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        widget.onClick();
      }),
      child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 16, top: 20, bottom: 20),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 1, color: Theme.of(context).colorScheme.secondary))
          ),
          child: SimpleText(
            text: widget.text,
            color: 2,
            size: 16,
            thick: 6,
            center: false,
          )),
    );
  }
}
