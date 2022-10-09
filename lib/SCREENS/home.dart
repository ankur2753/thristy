import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thristy/screens/seller_home.dart';
import 'package:thristy/screens/seller_orders.dart';
import 'package:thristy/screens/shop.dart';
import 'package:thristy/screens/profile.dart';
import 'package:thristy/screens/stats.dart';
import 'package:animations/animations.dart';
import 'package:thristy/services/database.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedPage = 0;

  final List _containers = const <Widget>[
    StatsScreen(),
    ShopsListScreen(),
    ProfileScreen()
  ];
  final List _containers2 = const <Widget>[
    SellerHome(),
    SellerOrdersScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageTransitionSwitcher(
        transitionBuilder: (
          Widget child,
          Animation<double> primaryAnimation,
          Animation<double> secondaryAnimation,
        ) {
          return FadeThroughTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        // child: FutureBuilder<bool>(
        //   future:
        //       Provider.of<DatabaseServiesProvider>(context).isUserCustomer(),
        //   builder: (context, snapshot) => snapshot.hasData && snapshot.data!
        //       ? _containers.elementAt(_selectedPage)
        //       : _containers2.elementAt(_selectedPage),
        // ),
        child: Provider.of<DatabaseServiesProvider>(context, listen: true)
                .isCustomer
            ? _containers.elementAt(_selectedPage)
            : _containers2.elementAt(_selectedPage),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        currentIndex: _selectedPage,
        onTap: (index) {
          setState(() {
            _selectedPage = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag), label: "Shop"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
