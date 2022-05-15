import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:thristy/SCREENS/success_seller.dart';
import 'package:thristy/SERVICES/database.dart';
import 'package:thristy/utils/button_component.dart';
import 'package:thristy/utils/constants.dart';

class DetailedPage extends StatefulWidget {
  final DocumentReference documentReference;
  const DetailedPage({
    Key? key,
    required this.documentReference,
  }) : super(key: key);

  @override
  State<DetailedPage> createState() => _DetailedPageState();
}

class _DetailedPageState extends State<DetailedPage> {
  int bottles = 1;
  String selectedAddress = "No Address Selected";
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
          num finalPrice = bottles * snapshot.data['bottlePrice'] +
              snapshot.data['deliveryRate'];
          return Scaffold(
            appBar: AppBar(
              title: Text(snapshot.data['shopName']),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      BigButton(
                        onPressed: () {},
                        buttonChild: Text(selectedAddress),
                        isCTA: false,
                      ),
                      getQuantity(snapshot),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          expandedDarkCard(
                            children: [
                              Text(
                                "Timings",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              Text(
                                  "opening Time:\t${snapshot.data['openTime']}"),
                              Text(
                                  "closing Time :\t${snapshot.data['closeTime']}"),
                            ],
                          ),
                          expandedDarkCard(
                            children: [
                              Text(
                                "Price Per Bottle",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              Text(
                                  "base price:\t ₹${snapshot.data['bottlePrice']}"),
                              const Text("Delivery Rates"),
                              Text(
                                  "0-1km :\t₹${snapshot.data['deliveryRate']}"),
                            ],
                          )
                        ],
                      ),
                      BigButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SeeLocation(
                                position: LatLng(
                                    snapshot.data['position'].latitude,
                                    snapshot.data['position'].longitude),
                                shopName: snapshot.data['shopName'],
                              ),
                            ),
                          );
                        },
                        buttonChild: const Text("See Location"),
                        isCTA: false,
                      ),
                    ],
                  ),
                ),
                BigButton(
                  onPressed: () async {
                    try {
                      String userUid = FirebaseAuth.instance.currentUser!.uid;
                      DocumentReference orderNo =
                          await Provider.of<DatabaseServiesProvider>(context,
                                  listen: false)
                              .newOrder(
                        price: finalPrice,
                        sellerPage: widget.documentReference,
                        customerUid: userUid,
                        quantity: bottles,
                      );
                      await Provider.of<DatabaseServiesProvider>(context,
                              listen: false)
                          .addOrder(
                        finalPrice: finalPrice,
                        documentReference: orderNo,
                        quantity: bottles,
                        shopName: snapshot.data['shopName'],
                      );
                    } finally {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SuccesSeller(),
                        ),
                      );
                    }
                  },
                  buttonChild: ListTile(
                    title: const Text("Order"),
                    subtitle: Text("₹$finalPrice"),
                    trailing: const Icon(Icons.navigate_next),
                  ),
                  isCTA: true,
                ),
              ],
            ),
          );
        });
  }

  Expanded expandedDarkCard({required List<Widget> children}) {
    return Expanded(
      child: Card(
        color: kPurple,
        child: SizedBox(
          height: 140,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          ),
        ),
      ),
    );
  }

  Card getQuantity(AsyncSnapshot<dynamic> snapshot) {
    return Card(
      color: kNavyBlue,
      child: SizedBox(
        height: 140,
        child: Row(
          children: [
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: const [Text("No of 20ltrs Bottles ")],
            )),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    IconButton(
                      splashColor: kTert,
                      onPressed: () {
                        setState(() {
                          if (bottles > 1) {
                            bottles--;
                          }
                        });
                      },
                      icon: const FaIcon(FontAwesomeIcons.minus),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text("$bottles"),
                    ),
                    IconButton(
                      splashColor: kTert,
                      onPressed: () {
                        setState(() {
                          if (bottles < snapshot.data['availBottles']) {
                            bottles++;
                          }
                        });
                      },
                      icon: const FaIcon(FontAwesomeIcons.plus),
                    ),
                  ],
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}

class SeeLocation extends StatelessWidget {
  final String shopName;
  final LatLng position;
  const SeeLocation({
    Key? key,
    required this.shopName,
    required this.position,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location of $shopName"),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: position,
          zoom: 14,
        ),
        markers: {
          Marker(
            markerId: MarkerId(shopName),
            position: position,
          )
        },
      ),
    );
  }
}
