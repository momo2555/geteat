import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/action_button.dart';
import 'package:geteat/components/simple_input.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:geteat/utils/global_utils.dart';
import 'package:geteat/utils/icons_utils.dart';
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
  List<num> _position = [];
  String _positionComment = "";

  LocationTools _locationTools = LocationTools();
  BitmapDescriptor? _locationMarker;
  CameraPosition _userPosition(List<num> position) {
   
    return CameraPosition(
        target: LatLng(position[0] as double, position[1] as double),
        zoom: 19.151926040649414);
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  /*Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_userPosition()));
  }*/

  Set<Marker> _markers() {
    
    Set<Marker> markers = Set<Marker>();
    markers.add(
      Marker(
        markerId: MarkerId("je sais pas trop"),
        position: LatLng(_position[0] as double, _position[1] as double),
        icon: _locationMarker ?? BitmapDescriptor.defaultMarker,
      ),
    );
    return markers;
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _position =_locationTools.getPositionValue();
    _positionComment = _locationTools.getPositionCommentValue();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      rootBundle.loadString("assets/style/map.json").then((string) {
        _mapStyle = string;
      });
    });
    //load the marker
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, "assets/icons/location_marker_black.png").then((value){
      setState(() {
        _locationMarker = value;
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
        automaticallyImplyLeading: false,
        leading: BackButton(onPressed: (){
          List<num> savedPos =_locationTools.getPositionValue(); 
          print(savedPos);
          print(_position);
          if(_position[0]!= savedPos[0]||_position[1]!= savedPos[1]|| _positionComment !=_locationTools.getPositionCommentValue()){
            showDialog(context: context, builder: (context){
                return AlertDialog(
                  title: SimpleText(text: "Annulation", color: 2,),
                  content: SimpleText(text: "Voulez vous vraiment annuler le choix de votre position ?", color: 2),
                  actions: [
                    ActionButton(
                      backColor: Theme.of(context).primaryColorDark,
                      text: "Annuler",
                      filled: true,
                      action: () {
                        Navigator.pop(context);
                      },
                      
                    ),
                    ActionButton(
                      filled: true,
                      text: "Confirmer",
                      action: () async {
                        
                        Navigator.pop(context);
                        Globals.goBack(context);
                      },
                    ),
                  ],
                );
              },);
          }else{
            Globals.goBack(context);
          }

          
          
        }),
        foregroundColor: Theme.of(context).primaryColorDark,
      ),
      bottomNavigationBar: Padding(
       padding: MediaQuery.of(context).viewInsets,
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
                  backColor: Theme.of(context).backgroundColor,
                  filled: true,
                  expanded: true,
                  action: () {
                    
                    _locationTools.updatePosition(_position);
                    _locationTools.updatePositionComment(_positionComment);
                    Globals.goBack(context);

                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 200,
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _userPosition(_position),
                  myLocationEnabled: true,
                  compassEnabled: false,
                  markers: _markers(),
                  onCameraMove: (CameraPosition cameraPosition) {
                    setState(() {
                      _position = [
                      cameraPosition.target.latitude,
                      cameraPosition.target.longitude
                    ];
                    });
                    
                    
                  },
                  onMapCreated: (GoogleMapController controller) async {
                    controller.setMapStyle(_mapStyle);
                    _controller.complete(controller);
                  },
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 30,
                child: IgnorePointer(
                  child: Center(
                    child: Container(
                      height: 35,
                      width: 130,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorDark,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                          child: SimpleText(
                        text: "Régler position",
                        size: 12,
                      )),
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 15, 18, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SimpleText(
                  text: "Ajouter des précisions",
                  thick: 6,
                  color: 2,
                ),
                SizedBox(
                  height: 15,
                ),
                SimpleInput(
                  style: "light",
                  value: _positionComment,
                  onChange: (val) {
                    _positionComment = val;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
