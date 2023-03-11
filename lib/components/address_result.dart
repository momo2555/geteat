import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/simple_text.dart';

class AddressResult extends StatefulWidget {
  const AddressResult({
    Key? key,
    required this.address,
  }) : super(key: key);
  final String address;

  @override
  State<AddressResult> createState() => _AddressResultState();
}

class _AddressResultState extends State<AddressResult> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Icon(Icons.location_on,
                color: Theme.of(context).primaryColorLight, size: 40),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SimpleText(
                text: widget.address,
                thick: 5,
              ),
              SimpleText(
                text: "Ville",
                color: 1,
              ),
              /*Expanded(
                  child: Divider(
                thickness: 0.5,
                color: Colors.grey,
              )),*/
            ],
          ),
        ],
      ),
    );
  }
}
