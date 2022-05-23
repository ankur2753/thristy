import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thristy/screens/address_book.dart';
import 'package:thristy/screens/login.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:thristy/screens/seller_details.dart';
import 'package:thristy/screens/your_orders.dart';
import 'package:thristy/services/auth.dart';
import 'package:thristy/screens/success_msg.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final User kek = FirebaseAuth.instance.currentUser!;
    return ListView(
      children: [
        Card(
          color: const Color(0xFF0E0E10),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  kek.displayName?.toUpperCase() ?? "Name of the person",
                ),
                CircleAvatar(
                  child: const FaIcon(FontAwesomeIcons.pencil),
                  foregroundImage: NetworkImage(
                    kek.photoURL ?? "https://robohash.org/${kek.uid}",
                    // TODO: mention resource usage
                  ),
                  minRadius: 50,
                ),
              ],
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.phone),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          title: const Text("Phone number"),
          subtitle: Text(kek.phoneNumber ?? "No Phone number Provided"),
        ),
        ListTile(
          leading: const Icon(Icons.email),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          title: const Text("Email Id"),
          subtitle: Text(kek.email ?? "Email@id Not found"),
        ),
        ListTile(
          title: const Text("Your Orders"),
          trailing: const Icon(Icons.navigate_next),
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (builder) => const YourOrdersScreen(),
              ),
            );
          },
        ),
        ListTile(
          title: const Text("Address Book"),
          trailing: const Icon(Icons.navigate_next),
          onTap: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    settings: const RouteSettings(name: "AddressBook"),
                    builder: (builder) => const AddressBook()));
          },
        ),
        const ListTile(
          title: Text("Favourites"),
          trailing: Icon(Icons.navigate_next),
        ),
        const ListTile(
          title: Text("Manage Notifications"),
          trailing: Icon(Icons.navigate_next),
        ),
        ListTile(
          title: const Text("Become a Seller"),
          trailing: const Icon(Icons.navigate_next),
          onTap: () {
            Navigator.push(context,
                CupertinoPageRoute(builder: (contex) => const SellerDetails()));
          },
        ),
        const ListTile(
          title: Text("Help"),
          trailing: Icon(Icons.navigate_next),
        ),
        const ListTile(
          title: Text("Send Feedback"),
          trailing: Icon(Icons.navigate_next),
        ),
        ListTile(
          title: const Text("Rate us on Store"),
          trailing: const Icon(Icons.navigate_next),
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => const SuccesScreen(
                      msg: "You've Given Rating ! \n thank you")),
            );
          },
        ),
        ListTile(
          title: const Text("Log Out"),
          trailing: const Icon(Icons.logout),
          onTap: () async {
            final AuthServiceProvider provider =
                Provider.of<AuthServiceProvider>(context, listen: false);
            provider.signOut();
            Navigator.pushAndRemoveUntil(
                context,
                CupertinoPageRoute(builder: (builder) => const LoginPage()),
                (route) => false);
          },
        ),
      ],
    );
  }
}
