import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:thristy/SERVICES/database.dart';
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
  TextEditingController name = TextEditingController();
  TextEditingController landmark = TextEditingController();
  TextEditingController floor = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new Address"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InputSection(controller: name, descriptor: "Title"),
            InputSection(controller: complete, descriptor: "Complete Address"),
            InputSection(
                controller: floor, descriptor: " Floor / house no (Optional)"),
            InputSection(
              controller: landmark,
              descriptor: "Nearby Landmark (Optional)",
              action: TextInputAction.done,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            if (name.text.isEmpty || complete.text.isEmpty) {
              throw Exception("Name and Complete Address are required");
            }
            DatabaseServiesProvider prov =
                Provider.of<DatabaseServiesProvider>(context, listen: false);
            prov.addAddress(
              title: name.text,
              completeAddress: complete.text,
              floor: floor.text,
              landmark: landmark.text,
            );
            complete.clear();
            name.clear();
            floor.clear();
            complete.clear();
            landmark.clear();
          } on FirebaseException catch (e) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.message.toString())));
          } on Exception catch (e) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.toString())));
          }
        },
        child: const FaIcon(FontAwesomeIcons.check),
      ),
    );
  }
}
