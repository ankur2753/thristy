import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:thristy/SERVICES/database.dart';
import 'package:thristy/SERVICES/storage.dart';
import 'package:thristy/screens/success_msg.dart';
import 'package:thristy/utils/button_component.dart';

class BecomeSeller extends StatelessWidget {
  final int bottlePrice;
  final int deliveryRate;
  final File image;
  final GeoPoint position;
  final String shopName;
  final String location;
  final String openTime;
  final String closeTime;
  final int maxBottles;
  const BecomeSeller({
    Key? key,
    required this.shopName,
    required this.maxBottles,
    required this.deliveryRate,
    required this.bottlePrice,
    required this.openTime,
    required this.closeTime,
    required this.location,
    required this.image,
    required this.position,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirm"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            "Are you sure ?",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            "You want to become a Seller",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            "you cannot reverse this process",
            style: Theme.of(context).textTheme.caption,
          ),
          const SizedBox(
            height: 40,
          ),
          BigButtonWithIcon(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const Scaffold(
                          body: Center(child: CircularProgressIndicator()),
                        )),
              );
              try {
                String photoUrl = await Provider.of<StorageServicesProvider>(
                        context,
                        listen: false)
                    .uploadImage(image, shopName);
                DocumentReference doc =
                    await Provider.of<DatabaseServiesProvider>(
                  context,
                  listen: false,
                ).setSellerDetails(
                  maxBottles: maxBottles,
                  bottlePrice: bottlePrice,
                  deliveryRate: deliveryRate,
                  opentime: openTime,
                  closetime: closeTime,
                  position: position,
                  shopName: shopName,
                );
                await Provider.of<DatabaseServiesProvider>(
                  context,
                  listen: false,
                ).addSeller(
                  documentReference: doc,
                  shopName: shopName,
                  photoUrl: photoUrl,
                  location: location,
                );
                await Provider.of<DatabaseServiesProvider>(
                  context,
                  listen: false,
                ).setUserType(isCustomer: false);
              } on Exception catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(e.toString()),
                  ),
                );
              }
              // TODO:add error screen
              Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                  fullscreenDialog: true,
                  builder: (BuildContext context) =>
                      const SuccesScreen(msg: "You're A Seller Now"),
                ),
              );
            },
            buttonIcon: const FaIcon(
              FontAwesomeIcons.check,
            ),
            buttonLable: const Text("Confirm"),
            isCTA: true,
          ),
          BigButtonWithIcon(
            onPressed: () {
              Navigator.pop(context);
            },
            buttonIcon: const FaIcon(
              FontAwesomeIcons.xmark,
              color: Colors.redAccent,
            ),
            buttonLable: const Text("Cancel"),
            isCTA: false,
          ),
        ],
      ),
    );
  }
}
