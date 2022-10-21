import 'package:flutter/material.dart';
import 'package:thristy/screens/seller/all_orders.dart';

class SellerOrdersScreen extends StatelessWidget {
  const SellerOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Orders"),
            bottom: const TabBar(tabs: <Widget>[
              Tab(
                child: Text("All"),
              ),
              Tab(
                child: Text("Pending"),
              ),
              Tab(
                child: Text("Completed"),
              ),
            ]),
          ),
          body: const TabBarView(children: [
            AllOrdersList(),
            Center(
              child: Text("All Pending Here"),
            ),
            Center(
              child: Text("All Completed Here"),
            ),
          ])),
    );
  }
}
