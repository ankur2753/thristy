import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:thristy/screens/see_location.dart';
import 'package:thristy/services/database.dart';
import 'package:thristy/utils/button_component.dart';

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
    return FutureBuilder<Object>(
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
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  floating: true,
                  expandedHeight: MediaQuery.of(context).size.height * 0.45,
                  stretch: true,
                  flexibleSpace: FlexibleSpaceBar(
                    // stretchModes: const [StretchMode.blurBackground],
                    title: Text(
                      snapshot.data['shopName'],
                      style: GoogleFonts.dancingScript(
                          letterSpacing: 1.5, fontSize: 50),
                    ),
                    background: DecoratedBox(
                      position: DecorationPosition.foreground,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF000000), Colors.transparent],
                          begin: Alignment.bottomCenter,
                          end: Alignment.center,
                        ),
                      ),
                      child: Image.network(
                        widget.imageSrc,
                        fit: BoxFit.cover,
                      ),
                    ),
                    centerTitle: true,
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Column(
                      children: [
                        ListTile(
                          title: const Text("Seller's Location"),
                          subtitle: const Text("See on Map"),
                          trailing: const Icon(Icons.navigate_next),
                          onTap: () => Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => SeeLocation(
                                position: LatLng(
                                    snapshot.data['position'].latitude,
                                    snapshot.data['position'].longitude),
                                shopName: snapshot.data['shopName'],
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          title: const Text("Delivering at"),
                          subtitle: Text("home"),
                          trailing: const Icon(Icons.navigate_next),
                          onTap: () => Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => SeeLocation(
                                position: LatLng(
                                    snapshot.data['position'].latitude,
                                    snapshot.data['position'].longitude),
                                shopName: snapshot.data['shopName'],
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          title: const Text("Bottle"),
                          subtitle: Text(
                              " ₹ " + snapshot.data['bottlePrice'].toString()),
                        ),
                        ListTile(
                          title: const Text("Opening Time"),
                          subtitle: Text(snapshot.data['openTime'].toString()),
                        ),
                        ListTile(
                          title: const Text("Closing Time"),
                          subtitle: Text(snapshot.data['closeTime'].toString()),
                        )
                      ],
                    ),
                    childCount: 1,
                  ),
                )
              ],
            ),
            bottomNavigationBar: BigButton(
              onPressed: () => {},
              buttonChild: const ListTile(
                title: Text("Order"),
                trailing: Icon(Icons.navigate_next),
              ),
              isCTA: true,
            ),
          );
        });
  }
}
