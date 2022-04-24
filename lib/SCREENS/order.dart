import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thristy/SERVICES/database.dart';
import 'package:thristy/utils/constants.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Provider.of<DatabaseServiesProvider>(context).getSellers(),
        builder: (BuildContext ctx, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          Map sellersList = snapshot.data!.data() as Map<String, dynamic>;
          return ListView.builder(
            itemCount: sellersList.length,
            itemBuilder: (BuildContext ctx, int index) {
              MapEntry seller = sellersList.entries.elementAt(index);
              return SellerCard(
                src: "${seller.value['photoUrl']}",
                location: "kirlosakr",
                rating: seller.value['rating'],
                nameOfSeller: seller.key.toString(),
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
  final double rating;
  const SellerCard({
    Key? key,
    required this.src,
    required this.nameOfSeller,
    required this.location,
    required this.rating,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Image.network(
              src,
              fit: BoxFit.cover,
              loadingBuilder:
                  (BuildContext ctx, Widget child, ImageChunkEvent? progress) {
                if (progress == null) {
                  return child;
                }
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                      child: LinearProgressIndicator(
                    color: kWhiteBlue,
                  )),
                );
              },
            ),
          ),
          ListTile(
            title: Text(nameOfSeller),
            subtitle: Text(location),
            trailing: Text(rating.toString() + "/5"),
          ),
        ],
      ),
    );
  }
}
