import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/address_result.dart';
import 'package:geteat/components/search_address_bar.dart';

class SearchAddressResultPage extends StatefulWidget {
  const SearchAddressResultPage({Key? key}) : super(key: key);

  @override
  State<SearchAddressResultPage> createState() => _SearchAddressResultPageState();
}

class _SearchAddressResultPageState extends State<SearchAddressResultPage> {
  List<dynamic>? _predictions = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          SearchAddressBar(static: false, onChanged: (predictions){
            setState(() {
              _predictions = predictions;
            });
          },),
          Builder(builder: ((context) {
            if(_predictions!=null) {
              return Column(children: 
                _predictions!.map((e) => AddressResult(address: e["description"])).toList()
              ,);
            }else{
              return Container();
            }
          }))
          

        ]),
      ),
    );
    
  }
}