import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Card(
          color: Colors.black,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text("Name of the person"),
                CircleAvatar(
                  foregroundImage: NetworkImage(
                      "https://randomuser.me/api/portraits/med/women/63.jpg"),
                  minRadius: 48,
                ),
              ]),
        ),
        const ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          title: Text("Some user data"),
          subtitle: Text("bruh"),
        ),
        const ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          title: Text("Some user data"),
          subtitle: Text("bruh"),
        ),
        const ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          title: Text("Some user data"),
          subtitle: Text("bruh"),
        ),
        const ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          title: Text("Some user data"),
          subtitle: Text("bruh"),
        ),
        const ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          title: Text("Some user data"),
          subtitle: Text("bruh"),
        ),
        const ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          title: Text("Some user data"),
          subtitle: Text("bruh"),
        ),
        const ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          title: Text("Some user data"),
          subtitle: Text("bruh"),
        ),
        const ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          title: Text("Some user data"),
          subtitle: Text("bruh"),
        ),
        const ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          title: Text("Some user data"),
          subtitle: Text("bruh"),
        ),
        const ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          title: Text("Some user data"),
          subtitle: Text("bruh"),
        ),
      ],
    );
  }
}
