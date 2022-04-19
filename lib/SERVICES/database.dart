import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class DatabaseServiesProvider extends ChangeNotifier {
  final CollectionReference _db = FirebaseFirestore.instance.collection('user');
  final User _user = FirebaseAuth.instance.currentUser!;

  // user -> customers  -> userID -> addressBook
  // user  -> sellers   -> UserID -> addressBook

  Future<bool> addAddress({
    required String title,
    required String completeAddress,
    String? landmark,
    String? floor,
  }) async {
    try {
      CollectionReference userCollection =
          _db.doc('customers').collection(_user.uid);
      await userCollection.doc('addressBook').set(
        {
          title: {
            'Complete Address': completeAddress,
            'landmark': landmark,
            'floor': floor,
          },
        },
        SetOptions(merge: true),
      );

      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }

  Stream<DocumentSnapshot> getAddress() {
    CollectionReference userCollection =
        _db.doc('customers').collection(_user.uid);
    DocumentReference doc = userCollection.doc('addressBook');
    Stream<DocumentSnapshot> snapshots = doc.snapshots();

    return snapshots;
  }

  Future<bool> deleteAddress(String title) async {
    try {
      CollectionReference userCollection =
          _db.doc('customers').collection(_user.uid);

      userCollection.doc('addressBook').update({
        title: FieldValue.delete(),
      });
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }
}
