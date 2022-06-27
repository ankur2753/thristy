import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:thristy/screens/detailed_page.dart';
import 'package:thristy/screens/place_order.dart';
import 'package:thristy/services/database.dart';
import 'package:thristy/utils/constants.dart';

class ShopsListScreen extends StatelessWidget {
  const ShopsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Provider.of<DatabaseServiesProvider>(context).getSellers(),
        builder: (BuildContext ctx, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          Map sellersList = snapshot.data!.data() as Map<String, dynamic>;
          if (sellersList.isEmpty) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                FaIcon(
                  FontAwesomeIcons.storeSlash,
                  size: 200,
                ),
                Text("OOps"),
                Text("Could'nt find any shop"),
              ],
            );
          }
          return ListView.builder(
            itemCount: sellersList.length,
            itemBuilder: (BuildContext ctx, int index) {
              MapEntry seller = sellersList.entries.elementAt(index);
              return OpenContainer(
                transitionType: ContainerTransitionType.fadeThrough,
                closedColor: Theme.of(context).scaffoldBackgroundColor,
                closedBuilder: (BuildContext context, fn) {
                  return SellerCard(
                    src: "${seller.value['photoUrl']}",
                    location: "${seller.value['location']}",
                    nameOfSeller: seller.key.toString(),
                  );
                },
                // openBuilder: (BuildContext context, fn) => DetailedPage(
                //   documentReference: seller.value['docRef'],
                // ),
                openBuilder: (BuildContext context, fn) => PlaceOrderScreen(
                  documentReference: seller.value['docRef'],
                ),
              );
            },
          );
        });
  }
}

class SellerCard extends StatelessWidget {
  final String src;
  final String nameOfSeller;
  final String location;
  const SellerCard({
    Key? key,
    required this.src,
    required this.nameOfSeller,
    required this.location,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 250,
            width: 200,
            child: Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              elevation: 9,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.network(
                src,
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
          ),
          Column(
            children: [
              Text(
                nameOfSeller,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(location),
            ],
          )
        ],
      ),
    );
  }
}
