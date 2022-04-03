import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thristy/SCREENS/home.dart';
import 'package:thristy/SCREENS/signup.dart';
import 'package:thristy/SERVICES/auth.dart';
import 'package:thristy/utils/constants.dart';
import 'package:thristy/SCREENS/credentials.dart';
import 'package:thristy/utils/button_component.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const Home();
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text("Login"),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  BigButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (builder) => const CredentialsScreen()),
                        );
                      },
                      buttonChild: const Text("Login with ID Password"),
                      isCTA: true),
                  BigButtonWithIcon(
                    onPressed: () async {
                      final AuthServiceProvider provider =
                          Provider.of<AuthServiceProvider>(context,
                              listen: false);
                      await provider.signInWithGoogle();
                    },
                    buttonLable: const Text("Login With Google"),
                    buttonIcon: const Icon(Icons.g_mobiledata_rounded),
                    isCTA: false,
                  ),
                  BigButtonWithIcon(
                    onPressed: () {},
                    buttonLable: const Text("Login with Phone"),
                    buttonIcon: const Icon(Icons.phone),
                    isCTA: false,
                  ),
                  const Text("or"),
                  const Divider(
                    height: 20,
                    thickness: 1,
                    color: kWhiteBlue,
                  ),
                  const Text("if you're new here Consider",
                      style: TextStyle(color: kWhiteBlue)),
                  BigButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (builder) => const SignUpScreen()),
                      );
                    },
                    buttonChild: const Text("Sign Up"),
                    isCTA: false,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
