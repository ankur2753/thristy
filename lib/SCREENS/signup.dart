import 'package:flutter/material.dart';
import 'package:thristy/utils/input_component.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "Sign Up ",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Looks like you don't Have an Account."),
                  Text("Let's get you a brand new one,"),
                  Text(
                      "You can easily create one by filling in the following details"),
                ],
              ),
            ),
            InputSection(
              controller: name,
              descriptor: "Name",
              prefixIcon: const Icon(Icons.person),
            ),
            InputSection(
              controller: phone,
              descriptor: "Phone No",
              prefixIcon: const Icon(Icons.phone),
            ),
            InputSection(
              controller: email,
              descriptor: "Email",
              prefixIcon: const Icon(Icons.alternate_email),
            ),
          ]),
      floatingActionButton: FloatingActionButton(
          onPressed: () {}, child: const Icon(Icons.navigate_next)),
    );
  }
}
