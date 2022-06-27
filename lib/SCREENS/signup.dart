import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thristy/screens/home.dart';
import 'package:thristy/services/auth.dart';
import 'package:thristy/services/database.dart';
import 'package:thristy/utils/constants.dart';
import 'package:thristy/utils/input_component.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController name = TextEditingController();
  bool _isAgreed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            InputSection(
              controller: name,
              descriptor: "Name",
            ),
            InputSection(
              controller: email,
              descriptor: "Email ID",
            ),
            InputSection(
              controller: password,
              descriptor: "Password",
              isPasword: true,
            ),
            CheckboxListTile(
                activeColor: kPrussianBlue,
                title: const Text("I agree With big Terms and policies "),
                value: _isAgreed,
                onChanged: (bool? newVal) {
                  setState(() {
                    _isAgreed = newVal ?? false;
                  });
                })
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (!_isAgreed) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Agree to proceed"),
              ),
            );
          }
          try {
            UserCredential userCreds =
                await Provider.of<AuthServiceProvider>(context, listen: false)
                    .addUser(email.text, password.text);
            userCreds.user!.updateDisplayName(name.text);
            await Provider.of<DatabaseServiesProvider>(context, listen: false)
                .setUserType(isCustomer: true);
            await Provider.of<AuthServiceProvider>(context, listen: false)
                .emailVerified(false);
            Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                    builder: (BuildContext context) => const Home()));
          } on FirebaseAuthException catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  e.code.toString().split("-").join(" ").toUpperCase(),
                ),
              ),
            );
          }
        },
        child: const Icon(Icons.navigate_next),
        elevation: 20,
        disabledElevation: 2,
      ),
    );
  }
}
