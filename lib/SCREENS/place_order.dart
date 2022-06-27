import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:thristy/screens/detailed_page.dart';
import 'package:thristy/services/database.dart';
import 'package:thristy/utils/button_component.dart';
import 'package:thristy/utils/constants.dart';

class PlaceOrderScreen extends StatefulWidget {
  final DocumentReference documentReference;
  const PlaceOrderScreen({Key? key, required this.documentReference})
      : super(key: key);

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  int currScreen = 0;
  int bottles = 1;
  Center noAddressFound() => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            FaIcon(
              FontAwesomeIcons.houseChimney,
              color: kWhiteBlue,
              size: 169,
            ),
            SizedBox(height: 20),
            Text("You Don't Have any Saved Address Yet,"),
            Text("Try Adding one"),
          ],
        ),
      );
  Column showDetails(AsyncSnapshot snapshot) => Column(
        children: [
          BigButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SeeLocation(
                    position: LatLng(snapshot.data['position'].latitude,
                        snapshot.data['position'].longitude),
                    shopName: snapshot.data['shopName'],
                  ),
                ),
              );
            },
            buttonChild: const Text("See Location on Map"),
            isCTA: false,
          ),
          Expanded(
            child: Card(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(color: kTert),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [Text("Timings")],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Opening Time"),
                              Text("${snapshot.data['openTime']}"),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Closing Time"),
                              Text("${snapshot.data['closeTime']}"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Card(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(color: kTert),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [Text("Pricing")],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Base Price"),
                              Text("₹${snapshot.data['bottlePrice']}"),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Delivery Per KM"),
                              Text("₹${snapshot.data['deliveryRate']}"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          BigButton(
              onPressed: () {
                setState(() {
                  currScreen = 1;
                });
              },
              buttonChild: const Text("Select Address & Quantity"),
              isCTA: true),
        ],
      );

  Column cart(AsyncSnapshot snapshot) => Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Card(
                  color: kTert,
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
                                        if (bottles <
                                            snapshot.data['availBottles']) {
                                          bottles++;
                                        }
                                      });
                                    },
                                    icon: const FaIcon(FontAwesomeIcons.plus),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Text("Order At"),
                getAddress()
              ],
            ),
          ),
          BigButton(
            onPressed: () {
              setState(() {
                currScreen = 1;
              });
            },
            buttonChild: const Text("Select A Payment Option"),
            isCTA: true,
          )
        ],
      );

  Expanded getAddress() {
    return Expanded(
      child: StreamBuilder(
          stream: Provider.of<DatabaseServiesProvider>(context).getAddress(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data?.data() == null) {
              return noAddressFound();
            }
            Map address = snapshot.data!.data() as Map<String, dynamic>;
            if (address.isEmpty) {
              return noAddressFound();
            }

            return ListView.builder(
              itemCount: address.length,
              itemBuilder: (BuildContext context, int index) {
                MapEntry currentAddress = address.entries.elementAt(index);
                return ListTile(
                  isThreeLine: true,
                  title: Text("${currentAddress.key}"),
                  subtitle: Text(
                      "${currentAddress.value['floor']}${currentAddress.value['floor'].toString().isNotEmpty ? ' , ' : ''}${currentAddress.value['Complete Address']}"),
                  trailing: IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.trash,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      Provider.of<DatabaseServiesProvider>(context,
                              listen: false)
                          .deleteAddress(currentAddress.key);
                    },
                  ),
                );
              },
            );
          }),
    );
  }

  Column payment(AsyncSnapshot snapshot) => Column();
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
          final List<Widget> sections = [
            showDetails(snapshot),
            cart(snapshot),
            payment(snapshot),
          ];
          return Scaffold(
            appBar: AppBar(
              title: Text(snapshot.data['shopName']),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: currScreen > 0
                              ? const FaIcon(
                                  FontAwesomeIcons.check,
                                  size: 15,
                                )
                              : const Text("1"),
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currScreen > 0 ? kTert : kPrussianBlue,
                        ),
                      ),
                      const Icon(FontAwesomeIcons.arrowRight),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: currScreen > 1
                              ? const FaIcon(
                                  FontAwesomeIcons.check,
                                  size: 15,
                                )
                              : const Text("2"),
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currScreen > 1 ? kTert : kPrussianBlue,
                        ),
                      ),
                      const Icon(FontAwesomeIcons.arrowRight),
                      Container(
                        child: const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text("3"),
                        ),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: kPrussianBlue,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: PageTransitionSwitcher(
                    transitionBuilder: (
                      Widget child,
                      Animation<double> primaryAnimation,
                      Animation<double> secondaryAnimation,
                    ) {
                      return SharedAxisTransition(
                        transitionType: SharedAxisTransitionType.horizontal,
                        fillColor: const Color(0xFF09090B),
                        animation: primaryAnimation,
                        secondaryAnimation: secondaryAnimation,
                        child: child,
                      );
                    },
                    child: sections.elementAt(currScreen),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
