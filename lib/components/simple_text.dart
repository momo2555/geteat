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
  this.center,
  this.cut,

  }) : super(key: key);
  final String text;
  final int? thick;
  final bool? italic;
  final double? size;
  final int? color;
  final bool? center;
  final bool? cut;

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
    
    
  }

  @override
  Widget build(BuildContext context) {
    List<FontWeight> weightList = [
      FontWeight.normal, FontWeight.w100, FontWeight.w200, FontWeight.w300, FontWeight.w400, FontWeight.w500, FontWeight.w600, FontWeight.w700,
      FontWeight.w800, FontWeight.w900,
    ];
    _thick = weightList[widget.thick??0];
    _color = Theme.of(context).primaryColorLight;
    List<Color> colors = [Theme.of(context).primaryColorLight,Theme.of(context).primaryColor, Theme.of(context).primaryColorDark, Color.fromARGB(255, 124, 124, 124), Colors.red ];
    _color = colors[widget.color??0];
    return Text(widget.text, 
      overflow: widget.cut ?? false ? TextOverflow.ellipsis : TextOverflow.visible,
      style: TextStyle(
        color: _color ?? Theme.of(context).primaryColorLight,
        fontWeight: _thick,
        fontStyle: widget.italic ?? false ? FontStyle.italic : FontStyle.normal,
        fontSize: widget.size ?? 14,
      ), 
      textAlign: widget.center ?? true ?  TextAlign.center : TextAlign.left);
  }
}