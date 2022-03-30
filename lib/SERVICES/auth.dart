import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future googleIN() async {
    try {
      GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      UserCredential users =
          await _firebaseAuth.signInWithPopup(googleAuthProvider);
      print(users);
    } catch (e) {
      print(e.toString());
    }
  }

  Future anonmusSignIN() async {
    try {
      UserCredential user = await _firebaseAuth.signInAnonymously();
      print(user);
    } catch (e) {
      print(e.toString());
    }
  }
}
