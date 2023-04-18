import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/command_details.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:geteat/controllers/command_controller.dart';
import 'package:geteat/models/command_model.dart';
import 'package:geteat/utils/global_utils.dart';

class CommandPage extends StatefulWidget {
  const CommandPage({Key? key}) : super(key: key);

  @override
  State<CommandPage> createState() => _CommandPageState();
}

class _CommandPageState extends State<CommandPage> {
  CommandController _commandController = CommandController();
 
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
          height: 40,
        ),
          SimpleText(text: "Commandes", thick: 8, size: 20, color: 2),
          Expanded(
            child: StreamBuilder(
              stream: _commandController.getAllUserCommands(),
              initialData: Globals.persistantCommands,
              builder: (context, AsyncSnapshot<List<CommandModel>> snapshot) {
                if (snapshot.hasData) {
                 Globals.persistantCommands = snapshot.data ?? [];
                  List<CommandDetails> details = snapshot.data!.map((e) => CommandDetails(command: e)).toList();
                  return ListView(
                    children: details,
                  );
                }
                return Container();

              },
            ),
          ),
        ],
      ),
    );
  }
}
