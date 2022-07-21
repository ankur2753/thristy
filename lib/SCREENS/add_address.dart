import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:thristy/screens/success_msg.dart';
import 'package:thristy/services/database.dart';
import 'package:thristy/utils/input_component.dart';

class AddAddress extends StatefulWidget {
  final GeoPoint givenPos;
  const AddAddress({Key? key, required this.givenPos}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  TextEditingController complete = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController landmark = TextEditingController();
  TextEditingController floor = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    complete.dispose();
    name.dispose();
    landmark.dispose();
    floor.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GeoPoint givenPosition = widget.givenPos;
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
              position: givenPosition,
            );
            complete.clear();
            name.clear();
            floor.clear();
            complete.clear();
            landmark.clear();
            Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                  builder: (context) =>
                      const SuccesScreen(msg: "Address Added Successfully")),
            );
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
