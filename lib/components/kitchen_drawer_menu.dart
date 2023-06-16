import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/kitchen_menu_element.dart';
import 'package:geteat/components/simple_text.dart';
import 'package:geteat/controllers/user_connection.dart';
import 'package:geteat/lang/lang.dart';
import 'package:geteat/utils/global_utils.dart';

class KitchenDrawerMenu extends StatefulWidget {
  const KitchenDrawerMenu({Key? key}) : super(key: key);

  @override
  State<KitchenDrawerMenu> createState() => _KitchenDrawerMenuState();
}

class _KitchenDrawerMenuState extends State<KitchenDrawerMenu> {
  UserConnection _userConnection = UserConnection();
  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        child: Column(
          
          children: [
            Container(
              
              color: Theme.of(context).primaryColorLight,
              child: Column(
                children: [
                  SizedBox(height: 40,),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(30)),                         
                          ),
                          child: Center(child: SimpleText(text:"GE", thick: 5, size: 20,)),
                        ),
                      ),
                      SimpleText(text: "GET EAT", color: 2,size: 16, thick: 8,),
                    ],
                  ),
                ],
              ),
              
            ), 
            KitchenMenuElement(text: Lang.l("Edition"), onClick: () {
              Globals.kitchenSelectedRestaurantEdition.value = "";
              Navigator.pushNamed(context, "/edit");
            },),
            KitchenMenuElement(text: Lang.l("Déconnexion"), onClick: () {
              _userConnection.logout();
            },),

          ],
        ),
      );
    
  }
}