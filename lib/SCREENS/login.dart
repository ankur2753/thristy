import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:thristy/screens/home.dart';
import 'package:thristy/screens/signup.dart';
import 'package:thristy/services/auth.dart';
import 'package:thristy/services/database.dart';
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
              // TODO:ADD BACKGROUND IMAGE
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  BigButtonWithIcon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (builder) => const CredentialsScreen()),
                        );
                      },
                      buttonLable: const Text("Login with ID Password"),
                      buttonIcon: const FaIcon(FontAwesomeIcons.userLock),
                      isCTA: true),
                  BigButtonWithIcon(
                    onPressed: () async {
                      final AuthServiceProvider auth =
                          Provider.of<AuthServiceProvider>(context,
                              listen: false);
                      UserCredential user = await auth.signInWithGoogle();
                      if (user.additionalUserInfo!.isNewUser) {
                        Provider.of<DatabaseServiesProvider>(context,
                                listen: false)
                            .setUserType(isCustomer: true);
                        Provider.of<DatabaseServiesProvider>(context,
                                listen: false)
                            .addUsage(bottles: 0);
                      }
                    },
                    buttonLable: const Text("Login With Google"),
                    buttonIcon: const FaIcon(FontAwesomeIcons.google),
                    isCTA: false,
                  ),
                  const Text("or"),
                  const Divider(
                    height: 20,
                    thickness: 1,
                  ),
                  const Text(
                    "if you're new here Consider",
                  ),
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
