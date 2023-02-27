import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/simple_text.dart';

class EditAddressButton extends StatefulWidget {
  const EditAddressButton({Key? key}) : super(key: key);

  @override
  State<EditAddressButton> createState() => _EditAddressButtonState();
}

class _EditAddressButtonState extends State<EditAddressButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/search_address");
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SimpleText(text: "Mon Adresse", thick: 5,size: 15,),
                Row(
                  children: [
                    SimpleText(text: "39 avenue du Général de Gaulle ...", color: 1,thick: 8,size: 15,),
                    Icon(Icons.expand_more, color: Theme.of(context).primaryColorLight,)
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
    
  }
}