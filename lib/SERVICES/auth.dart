import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServiceProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<bool> signInWithPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      notifyListeners();
      return Future.value(true);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googlAccount = await _googleSignIn.signIn();
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
        await _googleSignIn.disconnect();
      }
      await _auth.signOut();
      notifyListeners();
      return Future.value(true);
    } catch (e) {
      return Future.error(e);
    }
  }

  // TODO:SET USER TYPE FUNCTION
  Future setUserType(bool isCustomer) async {
    await FirebaseFirestore.instance
        .collection('usersMetadata')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'isCustomer': isCustomer});
  }
}
