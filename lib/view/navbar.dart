import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:flutter/material.dart';
import 'package:tv_shows/view/home.dart';
import 'package:tv_shows/view/watchlist.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int selectedNavbar = 0;
  final List<Widget> _pages = [Home(), WatchList()];

  void _changeSelectedNavBar(int select) {
    setState(() {
      selectedNavbar = select;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[selectedNavbar],
      bottomNavigationBar: CurvedNavigationBar(
          color: const Color(0xff303030),
          height: 50,
          buttonBackgroundColor: Colors.white,
          backgroundColor: const Color(0xff0d0d0d),
          onTap: (index) {
            _changeSelectedNavBar(index);
          },
          items: <Widget>[
            SizedBox(
                height: 40,
                child: Column(
                  children: const [
                    Icon(Icons.home_outlined, size: 25),
                    Text(
                      'Home',
                      style: TextStyle(color: Colors.black, fontSize: 8),
                    ),
                  ],
                )),
            SizedBox(
                height: 40,
                child: Column(
                  children: const [
                    Icon(Icons.list_alt_outlined, size: 25),
                    Text(
                      'Watchlist',
                      style: TextStyle(color: Colors.black, fontSize: 8),
                    ),
                  ],
                )),
          ]),
    );
  }
}
