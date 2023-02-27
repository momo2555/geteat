import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/simple_close_button.dart';

class SearchAddressPage extends StatefulWidget {
  const SearchAddressPage({Key? key}) : super(key: key);

  @override
  State<SearchAddressPage> createState() => _SearchAddressPageState();
}

class _SearchAddressPageState extends State<SearchAddressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 241, 241),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
      ),
      
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                      width: double.infinity,
                      height: 150,
                      color: Theme.of(context).primaryColor,
                    ),
                  
                  Positioned(
                    top: 10,
                    left: 15,
                    child: SimpleCloseButton(),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  width: double.infinity,
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColorLight),
                  padding: EdgeInsets.fromLTRB(16, 18, 16, 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     
                    



                    ],
                  ),
                ),
              ),
              
             
              
            ],
          ),
        ),
      ),
    );
  }
}