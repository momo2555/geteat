import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/action_button.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:geteat/models/command_model.dart';
import 'package:geteat/models/sub_command_model.dart';

class CommandDetails extends StatefulWidget {
  const CommandDetails({
    Key? key,
    required this.command,
  }) : super(key: key);
  final CommandModel command;
  @override
  State<CommandDetails> createState() => _CommandDetailsState();
}

class _CommandDetailsState extends State<CommandDetails> {
  List<SimpleText> _commandsDetail = [];
  @override
  Widget build(BuildContext context) {
    _commandsDetail = [];
    
    for (SubCommandModel subCommand in widget.command.subCommandList) {
      _commandsDetail.add(
        SimpleText(
          text:
              "${subCommand.subCommandLength}x ${subCommand.subCommandMeal.mealName}",
          color: 3,
        ),
      );
    }
    _commandsDetail.last = SimpleText(
          text:
              "${_commandsDetail.last.text} | ${(widget.command.commandTotalPrice as num).toStringAsFixed(2)}€",
          color: 3,
        );
    
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SimpleText(text: "Command #${widget.command.commandNumber}", color: 2, size: 16, thick: 6,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _commandsDetail,
              ),
              Builder(builder: 
              (context)  {
                if(widget.command.commandStatus != "archived") {
                  return ActionButton(
                    text: "En cours",
                    filled: true,
                    hasBorder: false,
                    rounded: true,
                    color: Theme.of(context).primaryColorLight,
                    backColor: Theme.of(context).primaryColor,
                    action: () {
                      widget.command.withCommandDetails = true;
                      Navigator.pushNamed(context, "/state_page", arguments: widget.command);
                    },
                  );
                }else {
                  return SimpleText(text: "Commmande terminée", color: 3,);
                }
                
              }) 
              
            ],
          ),
          Divider(color: Color.fromARGB(255, 72, 72, 72),),
        ],
      ),
    );
  }
}
