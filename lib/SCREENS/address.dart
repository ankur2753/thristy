import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thristy/SCREENS/add_address.dart';

class AddressBook extends StatefulWidget {
  const AddressBook({Key? key}) : super(key: key);

  @override
  State<AddressBook> createState() => _AddressBookState();
}

class _AddressBookState extends State<AddressBook> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final User _user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Address Book")),
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection('user').snapshots(),
        builder: (context, snashot) => ListView.builder(
            itemCount: snashot.data?.docs.length,
            itemBuilder: (BuildContext context, int index) {
              if (snashot.hasData) {
                DocumentSnapshot ds = snashot.data!.docs[index];
                print(ds);
                return ListTile(
                  title: const Text("Complete Address"),
                  subtitle: Text(ds.id.toString()),
                );
              }
              if (snashot.connectionState == ConnectionState.none) {
                return const CircularProgressIndicator();
              }
              return const Center(child: Text(" No Address Found"));
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              CupertinoPageRoute(builder: (builder) => const AddAddress()));
        },
        child: const FaIcon(FontAwesomeIcons.plus),
      ),
    );
  }
}
