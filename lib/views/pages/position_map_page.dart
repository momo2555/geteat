import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/action_button.dart';
import 'package:geteat/components/simple_input.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:geteat/views/pages/location_tool.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

class PositionMapPage extends StatefulWidget {
  const PositionMapPage({Key? key}) : super(key: key);

  @override
  State<PositionMapPage> createState() => _PositionMapPageState();
}

class _PositionMapPageState extends State<PositionMapPage> {
  String _mapStyle = "";
  LocationTools _locationTools = LocationTools();
  CameraPosition _userPosition() {
    List position = _locationTools.getPositionValue();
    return CameraPosition(
        target: LatLng(position[0] as double, position[1] as double),
        zoom: 19.151926040649414);
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_userPosition()));
  }

  Set<Marker> _markers () { 
    List position = _locationTools.getPositionValue();
    Set<Marker>  markers = Set<Marker>();
    markers.add(
    Marker(
      markerId: MarkerId("je sais pas trop"),
      position: LatLng(position[0], position[1]),
      icon: BitmapDescriptor.defaultMarker,
    )
    
  );
  return markers;}
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      rootBundle.loadString("assets/style/map.json").then((string) {
        _mapStyle = string;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorLight,
        elevation: 0,
        title: SimpleText(
          text: "Adresse",
          color: 2,
          thick: 7,
        ),
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
      body: Column(
        children: [
          Container(
            height: 260,
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _userPosition(),
              myLocationEnabled: true,
              compassEnabled: false,
              markers: _markers(),
              onCameraMove: (CameraPosition cameraPosition) {
                List<num> position = [cameraPosition.target.latitude, cameraPosition.target.longitude];
                setState(() {
                  _locationTools.updatePosition(position);
                });
              },
              onMapCreated: (GoogleMapController controller) async {
                controller.setMapStyle(_mapStyle);
                _controller.complete(controller);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 10, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SimpleText(
                  text: "Ajouter des précisions",
                  thick: 6,
                  color: 2,
                ),
                SimpleInput(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
