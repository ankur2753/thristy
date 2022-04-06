import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thristy/SCREENS/address.dart';
import 'package:thristy/SCREENS/login.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:thristy/SERVICES/auth.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

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
        const ListTile(
          title: Text("Your Orders"),
          trailing: Icon(Icons.navigate_next),
        ),
        ListTile(
          title: const Text("Address Book"),
          trailing: const Icon(Icons.navigate_next),
          onTap: () {
            Navigator.push(context,
                CupertinoPageRoute(builder: (builder) => AddressBook()));
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
        const ListTile(
          title: Text("Help"),
          trailing: Icon(Icons.navigate_next),
        ),
        const ListTile(
          title: Text("Send Feedbank"),
          trailing: Icon(Icons.navigate_next),
        ),
        const ListTile(
          title: Text("Rate us on Store"),
          trailing: Icon(Icons.navigate_next),
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
