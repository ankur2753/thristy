import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class DatabaseServiesProvider extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final User _user = FirebaseAuth.instance.currentUser!;

  Future editPhone(String phone) async {
    _db.collection('userMetadata').doc(_user.uid).update({'phone no': phone});
  }

  Stream<DocumentSnapshot> getOrders() {
    return _db.collection('orders').doc(_user.uid).snapshots();
  }

  Future<bool> newOrder() async {
    try {
      await _db.collection('orders').doc(_user.uid).set(
        {Timestamp.now().toString(): {}},
        SetOptions(merge: true),
      );
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }

  Future<bool> addAddress({
    required String title,
    required String completeAddress,
    String? landmark,
    String? floor,
  }) async {
    try {
      await _db.collection('addressBook').doc(_user.uid).set(
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
    return _db.collection('addressBook').doc(_user.uid).snapshots();
  }

  Future<bool> deleteAddress(String title) async {
    try {
      _db.collection('addressBook').doc(_user.uid).update({
        title: FieldValue.delete(),
      });
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }
}
