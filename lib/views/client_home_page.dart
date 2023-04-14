import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/utils/icons_utils.dart';
import 'package:geteat/views/pages/cart_page.dart';
import 'package:geteat/views/pages/command_page.dart';
import 'package:geteat/views/pages/profile_page.dart';
import 'package:geteat/views/pages/restaurant_list_page.dart';

class ClientHomepage extends StatefulWidget {
  const ClientHomepage({Key? key}) : super(key: key);

  @override
  State<ClientHomepage> createState() => _ClientHomepageState();
}

class _ClientHomepageState extends State<ClientHomepage> {
  int _selectedPage = 0;
  List<Widget> _pages = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pages = [
      RestaurantlistPage(),
      cartPage(),
      CommandPage(),
      ProfilePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          padding: EdgeInsets.fromLTRB(13, 3, 10, 13),
          color: Theme.of(context).primaryColorLight,
          height: 85,
          child: Column(
            children: [
              BottomNavigationBar(
                backgroundColor: Theme.of(context).primaryColorLight,
                elevation: 0,
                //fixedColor: Theme.of(context).backgroundColor,
                selectedItemColor: Theme.of(context).backgroundColor,
                unselectedItemColor: GeIcons.inactiveGrey,
                currentIndex: _selectedPage,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                type: BottomNavigationBarType.fixed,
                selectedFontSize: 11,
                unselectedFontSize: 11,
                
                items: [
                  BottomNavigationBarItem(
                    icon: _selectedPage == 0 ? GeIcons.homeBlack : GeIcons.homeGrey,
                    label: "Commander",
                    backgroundColor: Theme.of(context).primaryColorLight,
                  ),
                  BottomNavigationBarItem(
                    icon: _selectedPage == 1 ? GeIcons.cartBlack : GeIcons.cartGrey,
                    label: "Panier",
                    backgroundColor: Theme.of(context).primaryColorLight,
                  ),
                  BottomNavigationBarItem(
                    icon: _selectedPage == 2 ? GeIcons.commandsBlack : GeIcons.commandsGrey,//GeIcons.personBlack,
                    label: "Commandes",
                    backgroundColor: Theme.of(context).primaryColorLight,
                  ),
                  BottomNavigationBarItem(
                    icon: _selectedPage == 3 ? GeIcons.personBlack : GeIcons.personGrey,
                    label: "Profil",
                    backgroundColor: Theme.of(context).primaryColorLight,
                  ),
                ],
                onTap: (int index) {
                  setState(() {
                    _selectedPage = index;
                  });
                },
              ),
            ],
          ),
        ),
        body: AnimatedSwitcher(
          duration: Duration(milliseconds: 200),
          child: _pages[_selectedPage],
        ),
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("home page dispose");
  }
}
