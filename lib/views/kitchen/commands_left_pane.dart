import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/kitchen_command_element.dart';
import 'package:geteat/components/kitchen_drawer_menu.dart';
import 'package:geteat/components/kitchen_menu_element.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:geteat/controllers/user_connection.dart';
import 'package:geteat/themes/main_theme.dart';

class CommandLeftPane extends StatefulWidget {
  const CommandLeftPane({Key? key}) : super(key: key);

  @override
  State<CommandLeftPane> createState() => _CommandLeftPaneState();
}

class _CommandLeftPaneState extends State<CommandLeftPane> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorLight,
        elevation: 2,
        foregroundColor: Theme.of(context).backgroundColor,
        title: SimpleText(
          text: "Commandes actifs",
          color: 2,
          thick: 6,
          size: 16,
        ),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
      ),
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(children: [
          KitchenCommandElement()
        ]),
      ),
      drawer: KitchenDrawerMenu(),

    );
  }
}
