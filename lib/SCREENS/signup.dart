import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thristy/utils/button_component.dart';
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
  final TextEditingController rePass = TextEditingController();
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
            BigButtonWithIcon(
                onPressed: () {},
                buttonIcon: const FaIcon(FontAwesomeIcons.google),
                buttonLable: const Text("Sign Up with Google"),
                isCTA: false),
            const Divider(thickness: 4),
            InputSection(
              controller: email,
              descriptor: "Email",
            ),
            InputSection(
              controller: password,
              descriptor: "Password",
            ),
            InputSection(
              controller: rePass,
              descriptor: "Confirm Password",
            ),
            CheckboxListTile(
                title: const Text("I agree With big Terms and policies "),
                value: _isAgreed,
                onChanged: (bool? newVal) {
                  setState(() {
                    _isAgreed = newVal ?? false;
                  });
                })
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: _isAgreed
            ? () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("button Pressed")),
                );
              }
            : null,
        child: const Icon(Icons.navigate_next),
        backgroundColor: _isAgreed ? kLightBlue : kWhiteBlue,
      ),
    );
  }
}
