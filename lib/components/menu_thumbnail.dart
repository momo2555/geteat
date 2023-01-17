import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/simple_text.dart';

class MenuThumbnail extends StatefulWidget {
  const MenuThumbnail({Key? key}) : super(key: key);

  @override
  State<MenuThumbnail> createState() => _MenuThumbnailState();
}

class _MenuThumbnailState extends State<MenuThumbnail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SimpleText(
                  text: "Poké Saumon",
                  size: 17,
                  color: 2,
                  thick: 9,
                ),
                SimpleText(
                  text: "5.25€",
                  color: 2,
                  thick: 9,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: SimpleText(
                    text:
                        "Tranguj, oriz, mango, susam, fasule, speca, avocado, karrotë",
                    color: 2,
                    center: false,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(image: AssetImage("assets/images/menu_1.jpg"))
            ),
          )
        ]),
    );
    
  }
}
