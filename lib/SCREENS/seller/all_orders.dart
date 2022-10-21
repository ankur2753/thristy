import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thristy/services/database.dart';

class AllOrdersList extends StatelessWidget {
  const AllOrdersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Provider.of<DatabaseServiesProvider>(context).getOrders(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
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
          return ListView.builder(
            itemCount: orderMap.length,
            itemBuilder: (BuildContext context, int index) {
              MapEntry order = orderMap.entries.elementAt(index);
              return ListTile(
                title: Text("${order.value['address']}"),
                subtitle: Text("${order.value['quantity']} x 20ltr Bottle"),
                trailing: Text("${order.value['isCompleted']} "),
              );
            },
          );
        });
  }
}
