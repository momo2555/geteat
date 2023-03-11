import 'package:uuid/uuid.dart';

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';

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
}