import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatefulWidget {
  const ActionButton({
    Key? key,
    this.filled,
    this.focused,
    this.clear,
    this.color,
    this.backColor,
    this.borderColor,
    this.rounded,
    this.text,
    this.action,
    this.hasBorder,
    this.textStyle,
    this.expanded,
  }) : super(key: key);
  final TextStyle? textStyle;
  final bool? filled;
  final bool? clear;
  final bool? focused;
  final bool? hasBorder;
  final Color? color;
  final String? text;
  final Function()? action;
  final bool? expanded;
  final bool? rounded;
  final Color? backColor;
  final Color? borderColor;
  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  Widget _button() {
     return OutlinedButton(
      onPressed: () {
        widget.action != null ? widget.action!() : () {};
      },
      
      child: Text(widget.text ?? '',
          style:
              TextStyle(color: widget.color ?? Theme.of(context).primaryColorLight)),
      style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(widget.expanded ?? false ? Size.fromHeight(60) : null),
          backgroundColor:
              MaterialStateProperty.all(
                widget.filled??false?
                (widget.backColor??Theme.of(context).primaryColor):
                Colors.transparent,
                ),
          padding: MaterialStateProperty.all(
              const EdgeInsets.fromLTRB(25, 11, 25, 11)),
          shape: widget.rounded??false ?
                MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
          )) : null,
          side: widget.hasBorder??false ? MaterialStateProperty.all(BorderSide(
              color: widget.color ?? Theme.of(context).accentColor, width: 1)):null
              ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _button();
  }
}
