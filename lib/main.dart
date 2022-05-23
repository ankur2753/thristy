import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:thristy/services/auth.dart';
import 'package:thristy/services/database.dart';
import 'package:thristy/services/storage.dart';
import 'firebase_options.dart';
import 'screens/login.dart';
import './utils/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthServiceProvider()),
        ChangeNotifierProvider(create: (context) => DatabaseServiesProvider()),
        ChangeNotifierProvider(create: (context) => StorageServicesProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: const SafeArea(child: LoginPage()),
        theme: myTheme,
      ),
    );
  }
}
