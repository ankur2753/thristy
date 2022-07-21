import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:thristy/screens/locate_on_map.dart';
import 'package:thristy/services/database.dart';
import 'package:thristy/utils/constants.dart';

class AddressBook extends StatefulWidget {
  const AddressBook({Key? key}) : super(key: key);
  String get routeName => 'AddressBook';
  @override
  State<AddressBook> createState() => _AddressBookState();
}

class _AddressBookState extends State<AddressBook> {
  String get routeName => 'AddressBook';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Address Book")),
      body: StreamBuilder(
          stream: Provider.of<DatabaseServiesProvider>(context).getAddress(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (builder) => const LocateOnMap(),
            ),
          );
        },
        child: const FaIcon(FontAwesomeIcons.plus),
      ),
    );
  }

  Center noAddressFound() {
    return Center(
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
  }
}
