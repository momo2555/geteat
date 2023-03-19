import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/action_button.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

class PositionMapPage extends StatefulWidget {
  const PositionMapPage({Key? key}) : super(key: key);

  @override
  State<PositionMapPage> createState() => _PositionMapPageState();
}

class _PositionMapPageState extends State<PositionMapPage> {
  static const CameraPosition _kLake = CameraPosition(
     
      target: LatLng(37.43296265331129, -122.08832357078792),
      
      zoom: 19.151926040649414);
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorLight,
        elevation: 0,
        title: SimpleText(text: "Adresse", color: 2, thick: 7,),
        centerTitle: true,
        automaticallyImplyLeading: true,
        foregroundColor: Theme.of(context).primaryColorDark,
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 5,
        child: Container(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(7.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ActionButton(
                  text: 'Confirmer ma position',
                  color: Theme.of(context).primaryColor,
                  filled: true,
                  hasBorder: true,
                  expanded: true,
                  action: () {},
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        height: 260,
        child: GoogleMap(
          mapType: MapType.hybrid,
          initialCameraPosition: _kLake,
          liteModeEnabled: true,
          myLocationEnabled: true,
          compassEnabled: false,
          

          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            controller.setMapStyle("[]");
          },
        ),
      ),
    );
    
  }
}