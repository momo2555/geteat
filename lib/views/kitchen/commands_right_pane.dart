import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/kitchen_command_element.dart';
import 'package:geteat/components/kitchen_delivery_element.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:geteat/controllers/command_controller.dart';
import 'package:geteat/lang/lang.dart';
import 'package:geteat/models/command_model.dart';

class CommandsRightPane extends StatefulWidget {
  const CommandsRightPane({Key? key}) : super(key: key);

  @override
  State<CommandsRightPane> createState() => _CommandsRightPaneState();
}

class _CommandsRightPaneState extends State<CommandsRightPane> {
  CommandController _commandController = CommandController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorLight,
        elevation: 2,
        foregroundColor: Theme.of(context).backgroundColor,
        title: SimpleText(
          text: Lang.l("Livraisons"),
          color: 2,
          thick: 6,
          size: 16,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: StreamBuilder(
            stream: _commandController.getOnDeliveryCommands(),
            builder: (context,
                AsyncSnapshot<List<KitchenDeliveryElement>> snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: snapshot.data ?? [],
                );
              } else {
                return Center(
                  child: Container(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
