import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/simple_close_button.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:geteat/controllers/command_controller.dart';
import 'package:geteat/models/command_model.dart';
import 'package:geteat/models/sub_command_model.dart';
import 'package:geteat/utils/icons_utils.dart';

class CommandStatusPage extends StatefulWidget {
  const CommandStatusPage({
    Key? key,
    required this.command,
  }) : super(key: key);
  final CommandModel command;
  @override
  State<CommandStatusPage> createState() => _CommandStatusPageState();
}

class _CommandStatusPageState extends State<CommandStatusPage> {
  CommandController _commandController = CommandController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        leading: SimpleCloseButton(),
        backgroundColor: Theme.of(context).primaryColorLight,
        elevation: 0,
      ),
      body: Container(
        child: SingleChildScrollView(
            child: Column(
          children: [
            SimpleText(
              text: "Commande #${widget.command.commandNumber}",
              size: 18,
              thick: 9,
              color: 2,
            ),
            Builder(
              builder: (context) {
                List<Widget> details = [];
                for (SubCommandModel element in widget.command.subCommandList) {
                  details.add(Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SimpleText(
                        text: element.subCommandMeal.mealName,
                        color: 3,
                        size: 16,
                      ),
                      SimpleText(
                        text:
                            "${(element.subCommandTotalPrice as num).toStringAsFixed(2)}€",
                        color: 3,
                        size: 16,
                      ),
                    ],
                  ));
                }
                details.add(Divider(
                  color: Color.fromARGB(255, 75, 75, 75),
                ));
                details.add(Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SimpleText(
                      text: "TOTAL",
                      color: 2,
                      thick: 8,
                      size: 16,
                    ),
                    SimpleText(
                      text:
                          "${(widget.command.commandTotalPrice as num).toStringAsFixed(2)}€",
                      color: 2,
                      thick: 8,
                      size: 16,
                    )
                  ],
                ));
                return Padding(
                  padding: const EdgeInsets.only(right: 57, left: 57, top: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 241, 241, 241),
                    ),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: details,
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: 78,
            ),
            StreamBuilder(
              stream: _commandController.getCommandStatus(widget.command),
              builder: (context, AsyncSnapshot<String> snapshot) {
                bool confirmed = false;
                bool livering = false;
                bool received = false;
                String progress1 = "assets/images/vertical_load_before.png";
                String progress2 = "assets/images/vertical_load_before.png";


                if (snapshot.hasData) {
                  String status = snapshot.data ?? "";
                  received = (status == "received") || (status == "archieved");
                  livering = received || status == "delivery";
                  confirmed = livering || status == "kitchen"; 
                  if (confirmed) {
                    progress1 = "assets/animations/vertical_load_2.gif";
                  }
                  if(livering) {
                    progress1 = "assets/images/vertical_load_done.png";
                    progress2 = "assets/animations/vertical_load_2.gif";
                  }
                  if(received) {
                    progress1 = "assets/images/vertical_load_done.png";
                    progress2 = "assets/images/vertical_load_done.png";
                  }
                }
              
                return Container(
                  child: Column(
                    children: [
                      confirmed ? GeIcons.loadingOkGreen : GeIcons.loadingOkGrey,
                      SimpleText(
                        text: "Commande Confirmée",
                        color: confirmed ? 2 : 3,
                        thick: 7,
                        size: 18,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image(
                          image:
                              AssetImage(progress1),
                          height: 100,
                        ),
                      ),
                     livering ? GeIcons.loadingOkGreen : GeIcons.loadingOkGrey,
                      SimpleText(
                        text: "Commande en livraison",
                        color: livering ? 2 : 3,
                        thick: 7,
                        size: 18,
                      ),
                       Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image(
                          image:
                              AssetImage(progress2),
                          height: 100,
                        ),
                      ),
                      received ? GeIcons.loadingOkGreen : GeIcons.loadingOkGrey,
                      SimpleText(
                        text: "Commande reçue",
                        color: received ? 2 : 3,
                        thick: 7,
                        size: 18,
                      ),
                      SizedBox(height: 100),
                    ],
                  ),
                );
              },
            ),
          ],
        )),
      ),
    );
  }
}
