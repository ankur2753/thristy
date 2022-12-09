import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thristy/screens/seller/stats.dart';
import 'package:thristy/screens/seller/seller_orders.dart';
import 'package:thristy/screens/customer/shop.dart';
import 'package:thristy/screens/profile.dart';
import 'package:thristy/screens/customer/stats.dart';
import 'package:animations/animations.dart';
import 'package:thristy/services/database.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedPage = 0;

  final List customer = const <Widget>[
    StatsScreen(),
    ShopsListScreen(),
    ProfileScreen()
  ];
  final List seller = const <Widget>[
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
        //     initialData: true,
        //     future:
        //         Provider.of<DatabaseServiesProvider>(context).isUserCustomer(),
        //     builder: (context, snapshot) {
        //       if (!snapshot.hasData) {
        //         return const Center(
        //             child: CircularProgressIndicator.adaptive());
        //       }
        //       return snapshot.data!
        //           ? customer.elementAt(_selectedPage)
        //           : seller.elementAt(_selectedPage);
        //     }),
        child: Provider.of<DatabaseServiesProvider>(context, listen: true)
                .isCustomer
            ? customer.elementAt(_selectedPage)
            : seller.elementAt(_selectedPage),
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
