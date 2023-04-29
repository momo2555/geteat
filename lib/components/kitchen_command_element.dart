import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/action_button.dart';
import 'package:geteat/components/simple_text.dart';

class KitchenCommandElement extends StatefulWidget {
  const KitchenCommandElement({Key? key}) : super(key: key);

  @override
  State<KitchenCommandElement> createState() => _KitchenCommandElementState();
}

class _KitchenCommandElementState extends State<KitchenCommandElement> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                  text: "#00234",
                  size: 14,
                  color: 3,
                  thick: 7,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SimpleText(
                  text: "Mohamed Al Glawi",
                  size: 14,
                  color: 3,
                  thick: 5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SimpleText(
                  text: "+33783162021",
                  size: 14,
                  color: 3,
                  thick: 5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SimpleText(
                  text: "19:35",
                  size: 14,
                  color: 3,
                  thick: 5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SimpleText(
                  text: "13/02/2023",
                  size: 14,
                  color: 3,
                  thick: 5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ActionButton(
                  text: "Gati",
                  filled: true,
                ),
              )
            ],
          ),
          SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SimpleText(
                    text: "2x salmon pokebowl",
                    color: 2,
                    size: 16,
                    thick: 7,
                    center: false,
                  ),
                  Container(
                    //color: Colors.red,
                    constraints: BoxConstraints(maxWidth: 270),
                    child: SimpleText(
                      text:
                          "Small | Salce Soja (e kripur) | Mango EXTRA: Ananas | Koment: Pa karrote",
                      color: 2,
                      size: 14,
                      thick: 5,
                    ),
                  )
                ],
              ),
              SimpleText(
                text: "10.50€",
                color: 3,
                thick: 4,
                size: 16,
              )
            ],
          ),
          SizedBox(height: 18,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SimpleText(text: "TOTAL:", color: 2, thick: 8,size:16,),
              SimpleText(text: "10.50:", color: 2, thick: 8,size: 16,)
            ],
          )
        ],
      ),
    );
  }
}
