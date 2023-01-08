import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/simple_text.dart';

class RestaurantThumbnail extends StatefulWidget {
  const RestaurantThumbnail({Key? key, required this.image, required this.name})
      : super(key: key);
  final String image;
  final String name;
  @override
  State<RestaurantThumbnail> createState() => _RestaurantThumbnailState();
}

class _RestaurantThumbnailState extends State<RestaurantThumbnail> {
  DecorationImage? _decorationImage() {
    return DecorationImage(
      image: AssetImage(widget.image),
      fit: BoxFit.cover,
      alignment: Alignment.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: widget.name.trim(),
            child: Container(
              height: 130,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(15),
                image: _decorationImage(),
              ),
            ),
          ),
          SizedBox(height: 15,),
          SimpleText(
            text: widget.name,
            size: 15,
            color: 0,
            thick: 9,
          ),
          SimpleText(
            text: "Ferme à 2:00",
            size: 13,
            color: 1,
           
          ),
        ],
      ),
    );
  }
}
