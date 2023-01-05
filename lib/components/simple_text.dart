import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SimpleText extends StatefulWidget {
  const SimpleText({Key? key,
  required this.text,
  this.size,
  this.thick,
  this.italic,
  this.color,

  }) : super(key: key);
  final String text;
  final int? thick;
  final bool? italic;
  final double? size;
  final int? color;

  @override
  State<SimpleText> createState() => _SimpleTextState();
}

class _SimpleTextState extends State<SimpleText> {
  Color? _color;
  FontWeight _thick = FontWeight.normal;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    List<FontWeight> weightList = [
      FontWeight.normal, FontWeight.w100, FontWeight.w200, FontWeight.w300, FontWeight.w400, FontWeight.w500, FontWeight.w600, FontWeight.w700,
      FontWeight.w800, FontWeight.w900,
    ];
    _thick = weightList[widget.thick??0];
  }

  @override
  Widget build(BuildContext context) {
    _color = Theme.of(context).primaryColorLight;
    if (widget.color == 0) {
      _color = Theme.of(context).primaryColorLight;
    }else if (widget.color == 1) {
      _color = Theme.of(context).primaryColor;
    }
    return Text(widget.text, style: TextStyle(
      color: _color ?? Theme.of(context).primaryColorLight,
      fontWeight: _thick,
      fontStyle: widget.italic ?? false ? FontStyle.italic : FontStyle.normal,
      fontSize: widget.size ?? 14,
    ),);
  }
}