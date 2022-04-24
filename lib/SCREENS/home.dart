import 'package:flutter/material.dart';
import 'package:thristy/SCREENS/order.dart';
import 'package:thristy/SCREENS/profile.dart';
import 'package:thristy/SCREENS/stats.dart';
import 'package:thristy/utils/constants.dart';
import 'package:animations/animations.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedPage = 0;

  final List _containers = const <Widget>[
    StatsScreen(),
    OrderScreen(),
    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageTransitionSwitcher(
        reverse: true,
        transitionBuilder: (
          Widget child,
          Animation<double> primaryAnimation,
          Animation<double> secondaryAnimation,
        ) {
          return SharedAxisTransition(
            fillColor: const Color(0xFF0E0E10),
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.vertical,
            child: child,
          );
        },
        child: _containers.elementAt(_selectedPage),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF0E0E10),
        showUnselectedLabels: false,
        currentIndex: _selectedPage,
        selectedItemColor: kLightBlue,
        onTap: (index) {
          setState(() {
            _selectedPage = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag), label: "Order"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
