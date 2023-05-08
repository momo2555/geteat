import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uuid/uuid.dart';
import 'package:permission_handler/permission_handler.dart';

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:geolocator/geolocator.dart';

class LocationTools {
  late String _id; 
  final _client = Client();
  final _apiKey = 'AIzaSyD5VXcD6HG9fZzz8d1E9S-UqVPqjUkE5Kc';
  final _lang = "fr";

  LocationTools () {
    var uuid = Uuid();
    
    _id = uuid.v4();
    print(_id);
  }


  Future<List<dynamic>?> getPredictions(String query) async {
    if(query!=""){
      final request =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&types=address&language=$_lang&key=$_apiKey&sessiontoken=$_id';
      Uri url = Uri.parse(request);
      final response = await _client.get(url);
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        if (result['status'] == 'OK') {
          // compose suggestions in a list
          print(result['predictions']);
          return result['predictions'];
            
        }
        if (result['status'] == 'ZERO_RESULTS') {
          return [];
        }
        throw Exception(result['error_message']);
      } else {
        throw Exception('Failed to fetch suggestion');
      }
      

    }
    
  }


  Future<bool> handleLocationPermission(context) async {
  bool serviceEnabled;
  LocationPermission permission;
  if (await Permission.location.request().isGranted) {
    // Either the permission was already granted before or the user just granted it.
    return  true;
  }else{
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location services are disabled. Please enable the services')));
    return false;
  }

  
    /*serviceEnabled = await Geolocator.isLocationServiceEnabled();
    var status = await Permission.location.status;
    if(status.isGranted) {
      return true;
    }else {
       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location services are disabled. Please enable the services')));
      return false;
    }

    if (!serviceEnabled) {
     
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {   
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;*/
  }
  Future<Position> getCurrentPosition(context) async {
    
   
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    
      return position;
    
    
  }
  Future<List<Placemark>> getAddressFromLatLng(Position position) async {
    List<Placemark> places = await placemarkFromCoordinates(
            position.latitude, position.longitude);
    return places;
  }  


}