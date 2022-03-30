import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thristy/SERVICES/auth.dart';
import 'package:thristy/utils/constants.dart';
import 'package:thristy/SCREENS/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Form(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: TextFormField(
                    controller: username,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      label: Text(" Username"),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: TextFormField(
                    controller: password,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      label: Text(" Password"),
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                ),
                const Text("can't sign in ?",
                    style: TextStyle(color: kWhiteBlue)),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Forgot Password"),
                ),
                const Text("or"),
                const Divider(
                  height: 20,
                  thickness: 1,
                  color: kWhiteBlue,
                ),
                const Text("if you're new here Consider",
                    style: TextStyle(color: kWhiteBlue)),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Signning up"),
                ),
              ],
            ),
          ),
          /*
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text("Or if you're new here Consider Signning up",
                  style: Theme.of(context).textTheme.subtitle2),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox.fromSize(
                  size: const Size.fromHeight(65),
                  child: ElevatedButton(
                    child: Text(
                      "Login",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Home()));
                    },
                  ),
                ),
              ),
            ],
          ),
          */
        ],
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: kLightBlue,
        child: const Icon(Icons.navigate_next),
        onPressed: () {
          AuthService _auth = AuthService();
          _auth.anonmusSignIN();
          Navigator.pushReplacement(
              context, CupertinoPageRoute(builder: (context) => const Home()));
        },
      ),
    );
  }
}
