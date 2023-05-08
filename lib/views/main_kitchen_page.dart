
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dual_screen/dual_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:geteat/components/action_button.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:geteat/controllers/command_controller.dart';
import 'package:geteat/controllers/profil_controller.dart';
import 'package:geteat/models/command_model.dart';
import 'package:geteat/models/sub_command_model.dart';
import 'package:geteat/models/user_profile_model.dart';
import 'package:geteat/utils/command_utils.dart';
import 'package:geteat/utils/global_utils.dart';
import 'package:geteat/views/kitchen/commands_left_pane.dart';
import 'package:geteat/views/kitchen/commands_right_pane.dart';

class MainKitchenPage extends StatefulWidget {
  const MainKitchenPage({Key? key}) : super(key: key);

  @override
  State<MainKitchenPage> createState() => _MainKitchenPageState();
}

class _MainKitchenPageState extends State<MainKitchenPage> {
  CommandController _commandController = CommandController();
  ProfileController _profileController = ProfileController();
  
  waitForCommands() async {
    _commandController.getWipedCommands().listen((commands) async {
      for (CommandModel c in commands) {
        if (!Globals.commandPopupOn) {
         
          Globals.commandPopupOn = true;
          //_audiaPlayer.play(AssetSource("assets/sounds/notification.wav"));
          await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              
              return AlertDialog(
                title: SimpleText(
                  text: "Nouvelle commande",
                  color: 2,
                  size: 16,
                ),
                content: Container(
                  padding: EdgeInsets.all(8),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SimpleText(
                              text: "${CommandUtils.commandNumber(c)}",
                              color: 3,
                              thick: 7,
                            ),
                            FutureBuilder(
                              future: _profileController
                                  .getUserProfileById(c.commandUserId),
                              builder: (context,
                                  AsyncSnapshot<UserProfileModel?> snapshot) {
                                if (snapshot.hasData) {
                                  return SimpleText(
                                    text: snapshot.data?.userName ?? "",
                                    color: 3,
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                        ...(c.subCommandList as List<SubCommandModel>).map(
                          (e) {
                            return Column(
                              children: [
                                SimpleText(
                                  text:
                                      "${e.subCommandLength}x ${e.subCommandMeal.mealName}",
                                  thick: 7,
                                  color: 2,
                                ),
                                SimpleText(
                                  text: "${e.getOptionsAsText()}",
                                  color: 2,
                                )
                              ],
                            );
                          },
                        ).toList(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SimpleText(
                              text: "TOTAL:",
                              thick: 8,
                              color: 2,
                              size: 16,
                            ),
                            SimpleText(
                              text:
                                  "${(c.commandTotalPrice as num).toStringAsFixed(2)}€",
                              thick: 8,
                              color: 2,
                              size: 16,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                actions: [
                  ActionButton(
                    backColor: Theme.of(context).primaryColorDark,
                    text: "Refuser",
                    filled: true,
                    action: () {
                      _commandController.updateCommandStatus(c, "refused");
                      Globals.commandPopupOn = false;
                      Navigator.pop(context);
                    },
                  ),
                  ActionButton(
                    filled: true,
                    text: "Prendre",
                    action: () async {
                      _commandController.updateCommandStatus(c, "kitchen");
                      Globals.commandPopupOn = false;
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    waitForCommands();
  }

  @override
  Widget build(BuildContext context) {
    return TwoPane(
      paneProportion: 0.6,
      startPane: CommandLeftPane(),
      endPane: CommandsRightPane(),
    );
  }
}
