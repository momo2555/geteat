import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/menu_thumbnail.dart';
import 'package:geteat/components/simple_close_button.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({Key? key}) : super(key: key);

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
      ),
      body: Container(
        decoration: BoxDecoration(color: Theme.of(context).primaryColorLight),

        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Hero(
                    tag: "FRENCHIE - French Tacos".trim(),
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/resto_2.jpg'),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 15,
                    child: SimpleCloseButton(),
                  ),
                ],
              ),
              MenuThumbnail(),
              MenuThumbnail(),
              MenuThumbnail(),
              MenuThumbnail(),
              MenuThumbnail(),
              MenuThumbnail(),
              MenuThumbnail(),
              MenuThumbnail(),
              MenuThumbnail(),
              MenuThumbnail(),
            ],
          ),
        ),
      ),
    );
  }
}
