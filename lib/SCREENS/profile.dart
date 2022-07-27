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
import 'package:thristy/services/database.dart';
import 'package:thristy/utils/themes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final User kek = FirebaseAuth.instance.currentUser!;
    return ListView(
      children: [
        Padding(
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
                builder: (context) => const YourOrdersScreen(),
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
                  builder: (BuildContext contex) => const AddressBook()),
            );
          },
        ),
        SwitchListTile(
          title: const Text("Dark Theme"),
          value: Provider.of<AppThemeProvider>(context).isDarkTheme,
          onChanged: (value) {
            Provider.of<AppThemeProvider>(context, listen: false).setDark =
                value;
          },
        ),
        ListTile(
          title: const Text("Become a Seller"),
          trailing: const Icon(Icons.navigate_next),
          onTap: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (BuildContext contex) => const SellerDetails()));
          },
        ),
        ListTile(
          title: const Text("Rate on Play Store"),
          trailing: const Icon(Icons.navigate_next),
          onTap: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (BuildContext contex) =>
                        const SuccesScreen(msg: "Thamk You")));
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
