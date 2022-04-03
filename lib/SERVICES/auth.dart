import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServiceProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<bool> signInWithPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return Future.value(true);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googlAccount = await googleSignIn.signIn();
      final googleAuth = await googlAccount!.authentication;
      final OAuthCredential creds = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(creds);
      notifyListeners();
      return Future.value(true);
    } on FirebaseAuthException catch (error) {
      return Future.error(error);
    }
  }

  Future<bool> signOut() async {
    try {
      User user = FirebaseAuth.instance.currentUser!;
      if (user.providerData.first.providerId == 'google.com') {
        await googleSignIn.disconnect();
      }
      await _auth.signOut();
      return Future.value(true);
    } catch (e) {
      return Future.error(e);
    }
  }
}
