import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:thristy/services/database.dart';
import 'package:thristy/screens/success_msg.dart';
import 'package:thristy/utils/button_component.dart';
import 'package:thristy/utils/constants.dart';

class DetailedPage extends StatefulWidget {
  final DocumentReference documentReference;
  final String imageSrc;
  const DetailedPage(
      {Key? key, required this.documentReference, required this.imageSrc})
      : super(key: key);

  @override
  State<DetailedPage> createState() => _DetailedPageState();
}

class _DetailedPageState extends State<DetailedPage> {
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
          return Scaffold(
            appBar: AppBar(
              title: Text(snapshot.data['shopName']),
            ),
            body: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        elevation: 9,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image.network(
                          widget.imageSrc,
                          fit: BoxFit.fitWidth,
                          loadingBuilder: (BuildContext ctx, Widget child,
                              ImageChunkEvent? progress) {
                            if (progress == null) {
                              return child;
                            }
                            return const Padding(
                              padding: EdgeInsets.all(18.0),
                              child: Center(
                                  child: LinearProgressIndicator(
                                color: kWhiteBlue,
                              )),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                BigButton(
                  onPressed: () => {},
                  buttonChild: const ListTile(
                    title: Text("Order"),
                    trailing: Icon(Icons.navigate_next),
                  ),
                  isCTA: true,
                ),
              ],
            ),
          );
        });
  }
}
