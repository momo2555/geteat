import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:geteat/utils/global_utils.dart';
import 'package:geteat/utils/icons_utils.dart';
import 'package:geteat/views/pages/location_tool.dart';

class EditAddressButton extends StatefulWidget {
  const EditAddressButton({
    Key? key,
    this.type,
  }) : super(key: key);
  final int? type;
  @override
  State<EditAddressButton> createState() => _EditAddressButtonState();
}

class _EditAddressButtonState extends State<EditAddressButton> {
  LocationTools _locationTools = LocationTools();
  int _intCounter = 0;
  String _address = "...";
  String _city = "";
  List<num> _position = [0.0,0.0];
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _locationTools.handleLocationPermission(context).then((permission) {
        if (permission) {
          _locationTools.getCurrentPosition(context).then((position) {
            print("lat: " +
                position.latitude.toString() +
                "; long: " +
                position.longitude.toString());
             _locationTools.getAddressFromLatLng(position).then((places) {
             
              if (places.length > 0) {
                
                  _address = places[0].street ?? "";
                  _city = places[0].locality ?? "";
                  _position = [position.latitude, position.longitude];
                  _locationTools.updateAddress(_address, _city);
                  _locationTools.updatePosition(_position);
                  
                
                for (var place in places) {
                  print(place.street);
                }
              }
            });
          });
        }
      });
  }
  @override
  Widget build(BuildContext context) {
    
    if ((widget.type ?? 0) == 0) {
      return Container(
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, "/search_address");
              },
              
                child: Column(
                  
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    SimpleText(
                      text: "Mon Adresse",
                      thick: 5,
                      size: 15,
                    ),
                    Row(
                      children: [
                        ValueListenableBuilder(
                            valueListenable: Globals.userAddress,
                            builder: (context, String value, widget) {
                              return Expanded(
                                child: SimpleText(
                                  text:
                                      "${value}, ${_locationTools.getCityValue()}",
                                  color: 1,
                                  thick: 8,
                                  size: 15,
                                  cut: true,
                                  center: false,
                                ),
                              );
                            }),
                        Icon(
                          Icons.expand_more,
                          color: Theme.of(context).primaryColorLight,
                        )
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              
            ),
            
        
      );
    } else if ((widget.type ?? 0) == 1) {
      return Container(
        child: InkWell(
          onTap: () {
                Navigator.pushNamed(context, "/search_address");
              },
          child: Row(
            
            children: [
              Padding(
                padding: EdgeInsets.only(right: 20, left: 20),
                child: GeIcons.locationMarkerBlack,
              ),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ValueListenableBuilder(
                        valueListenable: Globals.userAddress,
                        builder: (context, String value, widget) {
                          return Padding(
                            padding: const EdgeInsets.only( right: 16),
                            child: SimpleText(
                              text: "$value, ${_locationTools.getCityValue()}",
                              color: 2,
                              thick: 8,
                              size: 16,
                              cut: true,
                            ),
                          );
                        })
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).backgroundColor,
                size: 18,
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
