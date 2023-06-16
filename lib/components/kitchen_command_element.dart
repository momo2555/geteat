import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/action_button.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:geteat/controllers/command_controller.dart';
import 'package:geteat/controllers/profil_controller.dart';
import 'package:geteat/lang/lang.dart';
import 'package:geteat/models/command_model.dart';
import 'package:geteat/models/sub_command_model.dart';
import 'package:geteat/models/user_profile_model.dart';
import 'package:geteat/utils/command_utils.dart';

class KitchenCommandElement extends StatefulWidget {
  const KitchenCommandElement({
    Key? key,
    required this.command,
  }) : super(key: key);
  final CommandModel command;
  @override
  State<KitchenCommandElement> createState() => _KitchenCommandElementState();
}

class _KitchenCommandElementState extends State<KitchenCommandElement> {
  CommandController _commandController = CommandController();
  ProfileController _profileController = ProfileController();
   bool _loading = false;
  Widget _subCommand(SubCommandModel subCommand) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SimpleText(
              text:
                  "${subCommand.subCommandLength}x ${subCommand.subCommandMeal.mealName}",
              color: 2,
              size: 16,
              thick: 7,
              center: false,
            ),
            Container(
              //color: Colors.red,
              constraints: BoxConstraints(maxWidth: 270),
              child: SimpleText(
                text: subCommand.getOptionsAsText(),
                color: 2,
                size: 14,
                thick: 5,
              ),
            )
          ],
        ),
        SimpleText(
          text:
              "${(subCommand.subCommandTotalPrice as num).toStringAsFixed(2)}€",
          color: 3,
          thick: 4,
          size: 16,
        )
      ],
    );
  }

  Widget _topText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SimpleText(
        text: text,
        size: 14,
        color: 3,
        thick: 5,
      ),
    );
  }
   @override
  void didUpdateWidget(covariant KitchenCommandElement oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
     setState(() {
      _loading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SimpleText(
                    text: "${CommandUtils.commandNumber(widget.command)}",
                    size: 14,
                    color: 3,
                    thick: 7,
                  ),
                ),
                 FutureBuilder(
                  future: _profileController.getUserProfileById(widget.command.commandUserId),
                  builder: (context, AsyncSnapshot<UserProfileModel?> snapshot) {
                    if(snapshot.hasData) {
                      return _topText(
                       "${snapshot.data?.userName ?? ""} | ${snapshot.data?.phone ?? ""}"
                    );
                    }else {

                      return Container();
                    }
                    
                  },
                ),
                Builder(builder: ((context) {
                  var date = (widget.command.commandDate ?? Timestamp(0, 0)).toDate();
                  return _topText("${date.hour}:${date.minute} ${date.day}/${date.month}/${date.year}");
                })),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ActionButton(
                    text: "Gati",
                    wait: _loading,
                    filled: true,
                    action: () {
                      setState(() {
                        _loading = true;
                      });
                      _commandController.updateCommandStatus(
                          widget.command, "delivery");
                    },
                  ),
                )
              ],
            ),
            SizedBox(height: 18),
            Builder(
              builder: (context) {
                return Column(
                  children: (widget.command.subCommandList as List)
                      .map((e) => _subCommand(e))
                      .toList(),
                );
              },
            ),
            SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SimpleText(
                  text: Lang.l("TOTAL:"),
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
            )
          ],
        ),
      ),
    );
  }
}
