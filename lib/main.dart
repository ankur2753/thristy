import 'package:flutter/material.dart';
import 'SCREENS/login.dart';
import './utils/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const SafeArea(child: LoginPage()),
      theme: myTheme,
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  //TODO: check for login status and then redirect accordingly
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text("I Am", style: Theme.of(context).textTheme.headline6),
        FittedBox(
          child: Text(
            "THIRSTY",
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
      ],
    );
  }
}
