import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/action_button.dart';
import 'package:geteat/components/cart_element.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:geteat/controllers/command_controller.dart';
import 'package:geteat/models/sub_command_model.dart';
import 'package:geteat/utils/global_utils.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class cartPage extends StatefulWidget {
  const cartPage({Key? key}) : super(key: key);

  @override
  State<cartPage> createState() => _cartPageState();
}

class _cartPageState extends State<cartPage> {
  CommandController _commandController = CommandController();
  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
      width: double.infinity,
      color: Colors.white,
      child: Column(children: [
        SizedBox(
          height: 40,
        ),
        SimpleText(
          text: "Mon panier",
          color: 2,
          thick: 7,
          size: 20,
        ),
        Expanded(
          child: Container(
            child: ListView(
              children: [
                StreamBuilder(
                  stream: _commandController.getSubCommands(),
                  builder:
                      (context, AsyncSnapshot<List<SubCommandModel>> snapshot) {
                    print("data = ");
                    print(snapshot.data);
                    if (snapshot.hasData) {
                      return Column(
                        children: snapshot.data!
                            .map((subCommand) => Padding(
                                  padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                                  child: CartElement(subCommand: subCommand),
                                ))
                            .toList(),
                      );
                    } else {
                      return Column();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(16.0),
          height: 95,
          child: FutureBuilder(
            future: _commandController.getCartTotalPrice(),
            builder: (context, AsyncSnapshot<num>  snapshot) {
              return ActionButton(
                  text: "Valider Commande - ${snapshot.hasData ? snapshot.data?.toStringAsFixed(2)??'':''}€",
                  backColor: Theme.of(context).backgroundColor,
                  filled: true,
                  expanded: true,
                  color: Theme.of(context).primaryColorLight,
                  action: () async {
                    Globals.userCart = await _commandController.getCartAsCommandModel(false) ;
                    Navigator.pushNamed(context, "/confirmation_page");
                  });
            },
          ),
        ),
      ]),
    );
  }
}
