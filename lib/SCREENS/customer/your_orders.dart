import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:thristy/services/database.dart';
import 'package:thristy/utils/button_component.dart';
import 'package:thristy/utils/constants.dart';

class YourOrdersScreen extends StatelessWidget {
  const YourOrdersScreen({Key? key}) : super(key: key);

  final List<Widget> noOrders = const [
    FaIcon(
      FontAwesomeIcons.cartShopping,
      color: kWhiteBlue,
      size: 169,
    ),
    SizedBox(height: 20),
    Text("You Don't Have an Order Yet,"),
    Text("Try Ordering First"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order History"),
      ),
      body: StreamBuilder(
          stream: Provider.of<DatabaseServiesProvider>(context).getOrders(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.hasData || !snapshot.data!.exists) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    FaIcon(
                      FontAwesomeIcons.solidFaceFrownOpen,
                      color: kWhiteBlue,
                      size: 169,
                    ),
                    SizedBox(height: 20),
                    Text("You Don't Have any Orders Yet,"),
                    Text("Try Adding Heading to Sellers Page to order"),
                  ],
                ),
              );
            }

            Map orderMap = snapshot.data!.data() as Map<String, dynamic>;
            if (orderMap.isEmpty) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  FaIcon(
                    FontAwesomeIcons.solidFaceFrown,
                    size: 200,
                  ),
                  Text("OOPs"),
                  Text("Could'nt find any Order"),
                ],
              );
            }
            return ListView.builder(
              itemCount: orderMap.length,
              itemBuilder: (BuildContext context, int index) {
                MapEntry order = orderMap.entries.elementAt(index);
                String date = order.key;
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    child: Column(
                      children: [
                        ListTile(
                          title:
                              Text("${order.value['quantity']} x 20ltr Bottle"),
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
                        BigButton(
                          onPressed: () {},
                          buttonChild: const Text("See Details"),
                          isCTA: false,
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
