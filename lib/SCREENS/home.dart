import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thristy/screens/order.dart';
import 'package:thristy/screens/profile.dart';
import 'package:thristy/screens/stats.dart';
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
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.black),
    );
    return Scaffold(
      body: PageTransitionSwitcher(
        transitionBuilder: (
          Widget child,
          Animation<double> primaryAnimation,
          Animation<double> secondaryAnimation,
        ) {
          return FadeThroughTransition(
            fillColor: const Color(0xFF0E0E10),
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
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
