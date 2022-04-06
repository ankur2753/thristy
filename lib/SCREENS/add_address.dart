import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thristy/utils/input_component.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  User currUser = FirebaseAuth.instance.currentUser!;
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');
  TextEditingController complete = TextEditingController();
  TextEditingController landmark = TextEditingController();
  TextEditingController house = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new Address"),
      ),
      body: Column(
        children: [
          InputSection(controller: complete, descriptor: "Complete Address"),
          InputSection(
              controller: house, descriptor: " floor / house no (Optional)"),
          InputSection(
              controller: landmark, descriptor: "Nearby Landmark (Optional)"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await userCollection.doc(currUser.uid).collection('address').add({
              'Complete Address': complete.text,
              'house': house.text,
              'landmark': landmark.text
            });
            house.clear();
            complete.clear();
            landmark.clear();
          } on FirebaseException catch (e) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.message.toString())));
          }
        },
        child: const FaIcon(FontAwesomeIcons.check),
      ),
    );
  }
}
