import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:thristy/services/database.dart';
import 'package:thristy/utils/constants.dart';

import '../utils/button_component.dart';

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
        body: StreamBuilder(
            stream: Provider.of<DatabaseServiesProvider>(context).getOrders(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (!snapshot.hasData || !snapshot.data!.exists) {
                return const Center(
                  child: Text("All Orders Here"),
                );
              }

              Map orderMap = snapshot.data!.data() as Map<String, dynamic>;
              if (orderMap.isEmpty) {
                return const Center(
                  child: Text("All Orders Here"),
                );
              }
              return TabBarView(children: [
                ListView.builder(
                  itemCount: orderMap.length,
                  itemBuilder: (BuildContext context, int index) {
                    MapEntry order = orderMap.entries.elementAt(index);
                    String date = order.key;
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                                "${order.value['quantity']} x 20ltr Bottle"),
                            subtitle: Text("${order.value['shopName']}"),
                            trailing: Text("₹${order.value['price']}"),
                          ),
                          Text(
                            date.substring(8, 10) +
                                date.substring(4, 8) +
                                date.substring(0, 4) +
                                " at " +
                                order.key.toString().substring(11, 19),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ]);
            }),
      ),
    );
  }
}
