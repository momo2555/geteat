import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/simple_text.dart';

class ActualPositionButton extends StatefulWidget {
  const ActualPositionButton({Key? key}) : super(key: key);

  @override
  State<ActualPositionButton> createState() => _ActualPositionButtonState();
}

class _ActualPositionButtonState extends State<ActualPositionButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.near_me_rounded, color: Theme.of(context).primaryColor, size: 30,),
            Padding(
              padding: const EdgeInsets.only(left: 23),
              child: Column(
                children: [
                  SimpleText(
                    text: "Ma position actuelle",
                    thick: 5,
                  ),
                  SimpleText(
                    text: "adress blablablabla",
                    thick: 4,
                    color: 1,
                  )
                ],
              ),
            ),
          ],
        ),
        Icon(Icons.navigate_next, color: Theme.of(context).primaryColorLight)
      ],
    );
  }
}
