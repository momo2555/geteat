import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatefulWidget {
  const ActionButton({
    Key? key,
    this.filled,
    this.focused,
    this.clear,
    this.color,
    this.text,
    this.action,
    this.hasBorder,
    this.textStyle,
  }) : super(key: key);
  final TextStyle? textStyle;
  final bool? filled;
  final bool? clear;
  final bool? focused;
  final bool? hasBorder;
  final Color? color;
  final String? text;
  final Function()? action;

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  Widget _oulinedActionButton() {
    return OutlinedButton(
      onPressed: () {
        widget.action != null ? widget.action!() : () {};
      },
      child: Text(widget.text ?? '',
          style:
              TextStyle(color: widget.color ?? Theme.of(context).accentColor)),
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Theme.of(context).backgroundColor),
          padding: MaterialStateProperty.all(
              const EdgeInsets.fromLTRB(25, 11, 25, 11)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
          side: MaterialStateProperty.all(BorderSide(
              color: widget.color ?? Theme.of(context).accentColor, width: 1))),
    );
  }

  Widget _emptyActionButton() {
    return OutlinedButton(
      onPressed: () {
        widget.action != null ? widget.action!() : () {};
      },
      child: Text(widget.text ?? '',
          style:
              TextStyle(color: widget.color ?? Theme.of(context).primaryColor, fontStyle:FontStyle.italic, fontWeight: FontWeight.w200, fontSize: 16), ),
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Theme.of(context).backgroundColor),
          padding: MaterialStateProperty.all(
              const EdgeInsets.fromLTRB(25, 11, 25, 11)),
          side: MaterialStateProperty.all(
              const BorderSide(color: Colors.transparent, width: 0))),
    );
  }

  Widget _filledActionButton() {
    return TextButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              widget.color ?? Theme.of(context).primaryColor),
          padding: MaterialStateProperty.all(
              const EdgeInsets.fromLTRB(25, 15, 25, 15)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
      onPressed: () {
        widget.action != null ? widget.action!() : () {};
      },
      child: Text(widget.text ?? '',
          style: TextStyle(color: Theme.of(context).primaryColorLight)),
    );
  }

  Widget _clearActionButton() {
    return TextButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              widget.color ?? Theme.of(context).primaryColorDark),
          padding: MaterialStateProperty.all(
              const EdgeInsets.fromLTRB(25, 15, 25, 15)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
      onPressed: () {
        widget.action != null ? widget.action!() : () {};
      },
      child: Text(widget.text ?? '',
          style: TextStyle(color: Theme.of(context).primaryColorLight)),
    );
  }

  Widget _selectedActionButton() {
    return TextButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              widget.color ?? Theme.of(context).primaryColorLight),
          padding: MaterialStateProperty.all(
              const EdgeInsets.fromLTRB(25, 15, 25, 15)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
      onPressed: () {
        widget.action != null ? widget.action!() : () {};
      },
      child: Text(widget.text ?? '',
          style: TextStyle(color: Theme.of(context).primaryColor)),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.focused ?? false) {
      return _selectedActionButton();
    } else if (widget.filled ?? false) {
      if (widget.clear ?? false) {
        return _clearActionButton();
      } else {
        return _filledActionButton();
      }
    } else {
      if (widget.hasBorder ?? true) {
        return _oulinedActionButton();
      } else {
        return _emptyActionButton();
      }
    }
  }
}
