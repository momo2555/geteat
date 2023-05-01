import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

class KitchenDeliveryElement extends StatefulWidget {
  const KitchenDeliveryElement({Key? key, required this.command})
      : super(key: key);
  final CommandModel command;
  @override
  State<KitchenDeliveryElement> createState() => _KitchenDeliveryElementState();
}

class _KitchenDeliveryElementState extends State<KitchenDeliveryElement> {
  CommandController _commandController = CommandController();
  ProfileController _profileController = ProfileController();
  bool _loading = false;
  String _subCommandSumup() {
    List<String> sumups = [];
    for (SubCommandModel subCommand in widget.command.subCommandList) {
      sumups.add(
          "${subCommand.subCommandLength}x ${subCommand.subCommandMeal.mealName}");
    }
    return sumups.join(", ");
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
  void didUpdateWidget(covariant KitchenDeliveryElement oldWidget) {
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
        width: double.infinity,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        child: Column(
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
               
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SimpleText(
                    text: "En livraison",
                    color: 3,
                  ),
                  ActionButton(
                    text: "Fin",
                    filled: true,
                    wait: _loading,
                    action: () {
                      setState(() {
                        _loading = true;
                      });
                      _commandController.updateCommandStatus(
                          widget.command, "archived");
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.pin_drop,
                  color: Theme.of(context).primaryColorDark,
                ),
                SimpleText(
                  text:
                      "[${(widget.command.commandPosition as GeoPoint).latitude}, ${(widget.command.commandPosition as GeoPoint).longitude}]",
                  color: 2,
                  size: 16,
                  thick: 8,
                ),
              ],
            ),
            SimpleText(text: _subCommandSumup(), color: 2, thick: 5, size: 16),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SimpleText(
                  text: "TOTAL:",
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
