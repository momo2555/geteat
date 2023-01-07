import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
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
          color: Theme.of(context).primaryColorLight,
          height: 80,
          child: Column(
            children: [
              BottomNavigationBar(
                backgroundColor: Theme.of(context).primaryColorLight,
                elevation: 0,
                //fixedColor: Theme.of(context).backgroundColor,
                selectedItemColor: Theme.of(context).primaryColor,
                unselectedItemColor: Theme.of(context).backgroundColor,
                currentIndex: _selectedPage,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_rounded),
                    label: "Commander",
                    backgroundColor: Theme.of(context).primaryColorLight,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart_rounded),
                    label: "Panier",
                    backgroundColor: Theme.of(context).primaryColorLight,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search_sharp),
                    label: "Commandes",
                    backgroundColor: Theme.of(context).primaryColorLight,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
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
}
