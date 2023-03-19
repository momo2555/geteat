import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:geteat/utils/global_utils.dart';
import 'package:geteat/views/pages/location_tool.dart';


class EditAddressButton extends StatefulWidget {
  const EditAddressButton({Key? key}) : super(key: key);

  @override
  State<EditAddressButton> createState() => _EditAddressButtonState();
}

class _EditAddressButtonState extends State<EditAddressButton> {
  LocationTools _locationTools = LocationTools();
  int _intCounter = 0;
  String _address = "...";
  String _city = "";
  List<num> _position = [];
  @override
  Widget build(BuildContext context) {
    if(_intCounter==0){
      _locationTools.handleLocationPermission(context).then((permission) {
        if(permission) {
          _locationTools.getCurrentPosition(context).then((position) {
            print("lat: "+ position.latitude.toString() + "; long: " + position.longitude.toString());
            _locationTools.getAddressFromLatLng(position).then((places) {
              if(places.length>0){
                setState(() {
                  
                  _address = places[0].street ?? "";
                  _city = places[0].locality ?? "";
                  _position = [position.latitude, position.longitude];
                  _locationTools.updateAddress(_address, _city);
                  _locationTools.updatePosition(_position);
                  
                });
                
              }
              
              for(var place in places) {
                print(place.street);
                
              }
            });
          });
        }

      });
      _intCounter++;
    }
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
                    ValueListenableBuilder(valueListenable: Globals.userAddress, builder: (context, String value, widget){
                      return SimpleText(text: "${value}, ${_locationTools.getCityValue()}", color: 1,thick: 8,size: 15,);
                    }),
                    
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