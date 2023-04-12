import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/cart_element.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:geteat/models/sub_command_model.dart';

class cartPage extends StatefulWidget {
  const cartPage({Key? key}) : super(key: key);

  @override
  State<cartPage> createState() => _cartPageState();
}

class _cartPageState extends State<cartPage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
        width: double.infinity,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40,),
            SimpleText(text: "Mon panier", color: 2,thick: 7,size: 20,),
            Column(
              children: [
                CartElement(subCommand: SubCommandModel(),),
                CartElement(subCommand: SubCommandModel(),),
              ],
            )
          ],
        ),
      ),
    );
  }
}