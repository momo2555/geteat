import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geteat/components/action_button.dart';
import 'package:geteat/components/edit_address_button.dart';
import 'package:geteat/components/simple_close_button.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:geteat/controllers/command_controller.dart';
import 'package:geteat/models/command_model.dart';
import 'package:geteat/models/sub_command_model.dart';
import 'package:geteat/models/load_model.dart';
import 'package:geteat/utils/global_utils.dart';
import 'package:geteat/utils/icons_utils.dart';
import 'package:provider/provider.dart';

class ConfirmationPage extends StatefulWidget {
  const ConfirmationPage({Key? key}) : super(key: key);

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  CommandController _commandController = CommandController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColorLight,
        elevation: 0,
        leading: SimpleCloseButton(),
        toolbarHeight: 70,
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SimpleText(
              text: "Confirmation",
              color: 2,
              thick: 9,
              size: 20,
            ),
            //location
            SizedBox(height: 20),
            EditAddressButton(
              type: 1,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 60),
              child: Divider(
                color: Color.fromARGB(255, 54, 54, 54),
              ),
            ),
            //buy cash
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 15, left: 15),
                  child: GeIcons.cash,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SimpleText(
                      text: "Moyen de payement :",
                      color: 2,
                      size: 16,
                    ),
                    SimpleText(
                      text: "En Espèce (€)",
                      color: 1,
                      size: 16,
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 70,
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SimpleText(
                      text: "Detail de la commande",
                      color: 2,
                      size: 16,
                      thick: 8,
                    ),
                    Builder(
                      builder: (context) {
                        List<Widget> invoiceList = [];
                        for (SubCommandModel subCommand
                            in Globals.userCart.subCommandList) {
                          invoiceList.add(
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SimpleText(
                                  text: subCommand.subCommandMeal.mealName,
                                  color: 3,
                                ),
                                SimpleText(
                                    text:
                                        "${(subCommand.subCommandTotalPrice as num).toStringAsFixed(2)}€",
                                    color: 3),
                              ],
                            ),
                          );
                        }
                        return Column(
                          children: invoiceList,
                        );
                      },
                    )
                  ]),
            ))
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 5,
        child: Container(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ActionButton(
              text:
                  "Confirmer la commande - ${(Globals.userCart.commandTotalPrice as num).toStringAsFixed(2)}€",
              backColor: Theme.of(context).primaryColor,
              filled: true,
              expanded: true,
              color: Theme.of(context).primaryColorLight,
              action: () async {
                CommandModel command = CommandModel();
                Navigator.popAndPushNamed(
                  context,
                  '/load_page',
                  arguments: LoadModel(
                    callback: (_) async {
                      command =
                          await _commandController.confirmCart();
                      command.withCommandDetails = false;
                      Globals.persistantCommands.insert(0, command);
                      Globals.persistantCart = [];
                      Globals.homeIndex.value = 2;
                     
                    },
                    afterCallback: (_) {
                      
                      Navigator.of(_).pushNamed("/state_page",
                          arguments: command);
                      Fluttertoast.showToast(
                          msg: "Votre commande a bien été confirmée");
                    },
                    message: "Commande en cours de creéation",
                    minimumTime: 1,
                  ),
                );
              },
            ),
          )
        ),
      ),
    );
  }
}
