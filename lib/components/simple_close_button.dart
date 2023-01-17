import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class SimpleCloseButton extends StatefulWidget {
  const SimpleCloseButton({Key? key}) : super(key: key);

  @override
  State<SimpleCloseButton> createState() => _SimpleCloseButtonState();
}

class _SimpleCloseButtonState extends State<SimpleCloseButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(19)),
        color: Theme.of(context).primaryColorLight,
      ),
      child: CloseButton(
        color: Theme.of(context).backgroundColor,
        onPressed: (){
          Navigator.pop(context);
        },

      ),
    );
    
  }
}