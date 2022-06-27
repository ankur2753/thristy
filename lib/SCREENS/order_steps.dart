import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thristy/services/database.dart';

class OrderSteps extends StatefulWidget {
  final DocumentReference documentReference;
  const OrderSteps({Key? key, required this.documentReference})
      : super(key: key);

  @override
  State<OrderSteps> createState() => _OrderStepsState();
}
/*
1________
|________
2________
|________
|________
3________
|________
|________
4________
*/

class _OrderStepsState extends State<OrderSteps> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<DatabaseServiesProvider>(context)
            .getSellerDetails(docRef: widget.documentReference),
        initialData: const {
          'shopName': 'Loading...',
          'closeTime': "0:00 PM",
          'openTime': "0:00 PM",
          'position': GeoPoint(13.098318826729699, 77.51988429576159),
          'bottlePrice': 0,
          'deliveryRate': 0,
        },
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: Text(snapshot.data['shopName']),
            ),
            body: Row(
              children: [
                Column(),
                Column(),
              ],
            ),
          );
        });
  }
}
