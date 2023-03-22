import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:geteat/utils/global_utils.dart';
import 'package:geteat/views/pages/location_tool.dart';

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
  LocationTools _locationTools = LocationTools();
  @override
  void initState() {
    // TODO: implement initState
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<String> details = widget.address.split(", ");
    String address = details[0];
    List<String> cityTab = [];
    String city = "";
    for (int i = 1; i < details.length; i++) {
      cityTab.add(details[i]);
    }
    city = cityTab.join(', ');
    return GestureDetector(
      onTap: () {
        _locationTools.updateAddress(address, city);
        _locationTools.getPlacePosition(widget.address).then((position) {
          List<num> pos = [position.latitude, position.longitude];
          _locationTools.updatePosition(pos);
        });
        Globals.goBack(context);
        
      },
      child: Container(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(Icons.location_on,
                    color: Theme.of(context).primaryColorLight, size: 40),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SimpleText(
                      text: address,
                      thick: 5,
                    ),
                    SimpleText(
                      text: city,
                      color: 1,
                    ),
                    /*Expanded(
                        child: Divider(
                      thickness: 0.5,
                      color: Colors.grey,
                    )),*/
                  ],
                ),
              ),
            ],
          ),
        
      ),
    );
  }
}
