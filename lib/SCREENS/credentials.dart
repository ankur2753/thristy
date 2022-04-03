import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thristy/SERVICES/auth.dart';
import 'package:thristy/utils/button_component.dart';
import 'package:thristy/utils/constants.dart';
import 'package:thristy/SCREENS/home.dart';

class CredentialsScreen extends StatefulWidget {
  const CredentialsScreen({Key? key}) : super(key: key);

  @override
  State<CredentialsScreen> createState() => _CredentialsScreenState();
}

class _CredentialsScreenState extends State<CredentialsScreen> {
  final GlobalKey<FormState> _key = GlobalKey();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
              key: _key,
              child: Column(children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: TextFormField(
                    validator: validateEmail,
                    controller: email,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      label: Text("Email"),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: TextFormField(
                    validator: validatePassword,
                    controller: password,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      label: Text("Password"),
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("can't sign in ?",
                        style: TextStyle(color: kWhiteBlue)),
                    TextButton(
                        onPressed: () {}, child: const Text("Forgot Password"))
                  ],
                ),
                BigButton(
                  onPressed: () async {
                    try {
                      if (_key.currentState!.validate()) {
                        final AuthServiceProvider provider =
                            Provider.of<AuthServiceProvider>(context,
                                listen: false);
                        await provider.signInWithPassword(
                            email.text, password.text);
                        Navigator.pushAndRemoveUntil(
                            context,
                            CupertinoPageRoute(
                                builder: (builder) => const Home()),
                            (Route<dynamic> route) => false);
                      }
                    } on FirebaseAuthException catch (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            error.message.toString(),
                          ),
                        ),
                      );
                    }
                  },
                  buttonChild: const Text("Login"),
                  isCTA: true,
                ),
              ])),
        ),
      ),
    );
  }
}

String? validateEmail(String? email) {
  if (email == null || email.isEmpty) {
    return "Email address is required";
  }
  String pattern = r'\w+@\w+.\w+';
  RegExp regEx = RegExp(pattern);
  if (!regEx.hasMatch(email)) {
    return "Invalid Email Address";
  }
  return null;
}

String? validatePassword(String? password) {
  if (password == null || password.isEmpty) {
    return "Password is required";
  }
  if (password.length < 8) {
    return "Must longer than 8 characters";
  }

  return null;
}
