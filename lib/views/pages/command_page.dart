import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/command_details.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:geteat/controllers/command_controller.dart';
import 'package:geteat/lang/lang.dart';
import 'package:geteat/models/command_model.dart';
import 'package:geteat/utils/global_utils.dart';

class CommandPage extends StatefulWidget {
  const CommandPage({Key? key}) : super(key: key);

  @override
  State<CommandPage> createState() => _CommandPageState();
}

class _CommandPageState extends State<CommandPage> {
  CommandController _commandController = CommandController();
  Widget _loading(BuildContext context) {
    print("loading");
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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          SimpleText(text: Lang.l("Commandes"), thick: 8, size: 20, color: 2),
          Expanded(
            child: StreamBuilder(
              stream: _commandController.getAllUserCommands(),
              initialData: Globals.persistantCommands,
              builder: (context, AsyncSnapshot<List<CommandModel>> snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  
                  Globals.persistantCommands = snapshot.data ?? [];
                  List<CommandDetails> details = snapshot.data!
                      .map((e) => CommandDetails(command: e))
                      .toList();
                  return ListView(
                    children: details,
                  );
                }
                return _loading(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
