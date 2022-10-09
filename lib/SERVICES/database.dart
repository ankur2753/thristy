import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DatabaseServiesProvider extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final User _user = FirebaseAuth.instance.currentUser!;

  //***************************************************** //
  // TODO : REMOVE ON DEPLOYMENT
  static bool _isCust = true;

  set userType(bool value) {
    _isCust = value;
    notifyListeners();
  }

  bool get isCustomer => _isCust;

  // *****************************************************************//

  // TODO: store user data locally for less calls to the server

  // userMetaData SECTION
  Future<bool> isUserCustomer() async {
    DocumentSnapshot doc =
        await _db.collection('usersMetadata').doc(_user.uid).get();
    Map<String, bool> res = doc.data() as Map<String, bool>;
    return res['isCustomer'] ?? true;
  }

  Future setUserType({required bool isCustomer}) async {
    _db
        .collection('usersMetadata')
        .doc(_user.uid)
        .set({'isCustomer': isCustomer}, SetOptions(merge: true));
  }

  Future addUsage({required int bottles}) async {
    DocumentSnapshot snapshot =
        await _db.collection('userMetaData').doc(_user.uid).get();
    Map obj = snapshot.data() as Map;
    DateTime now = Timestamp.now().toDate();
    String month = now.month.toString() + now.year.toString();
    print(month);
    _db.collection('usersMetadata').doc(_user.uid).set(
      {month: int.parse(obj['usage']) + bottles * 20},
      SetOptions(merge: true),
    );
  }

  Future getUsage() async {
    DateTime now = Timestamp.now().toDate();
    String month = now.month.toString() + now.year.toString();
    print(month);

    DocumentSnapshot snapshot =
        await _db.collection('usersMetaData').doc(_user.uid).get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    print(snapshot);
    return data;
  }

  Future editPhone(String phone) async {
    _db.collection('userMetaData').doc(_user.uid).update({'phone no': phone});
  }

  //==========================================================================//
  // ORDERS SECTION
  // Future addOrder({
  //   required DocumentReference documentReference,
  //   required String shopName,
  //   required int quantity,
  //   required num finalPrice,
  // }) async {
  //   return _db.collection('orderBook').doc(_user.uid).set(
  //     {
  //       DateTime.now().toLocal().toString(): {
  //         'docRef': documentReference,
  //         'shopName': shopName,
  //         'quantity': quantity,
  //         'price': finalPrice,
  //       },
  //     },
  //     SetOptions(merge: true),
  //   );
  // }
  Future addOrder({
    required DocumentReference shopReference,
    required String shopName,
    required int quantity,
    required num finalPrice,
  }) async {
    DocumentReference ref = await _db.collection('allOrder').add({
      DateTime.now().toLocal().toString(): {
        'docRef': shopReference,
        'customer': _user.uid,
        'customerName': _user.displayName,
        'shopName': shopName,
        'quantity': quantity,
        'price': finalPrice,
      },
    });
    return _db.collection('orderBook').doc(_user.uid).set(
      {
        DateTime.now().toLocal().toString(): {
          'docRef': ref,
          'shopName': shopName,
          'quantity': quantity,
          'price': finalPrice,
        },
      },
      SetOptions(merge: true),
    );
  }

  Stream<DocumentSnapshot> getOrders() {
    return _db.collection('orderBook').doc(_user.uid).snapshots();
  }

  Future<Object> getOrderDetails({required DocumentReference orderDoc}) async {
    DocumentSnapshot snapshot = await orderDoc.get();
    return snapshot.data() ?? {};
  }

  Future<DocumentReference> newOrder({
    required DocumentReference sellerPage,
    required String customerUid,
    required int quantity,
    required num price,
  }) async {
    DocumentReference orderDoc = _db.collection('orderBooks').doc();
    await orderDoc.set(
      {
        'time': Timestamp.now(),
        'seller': sellerPage,
        'customer': customerUid,
        'quantity': quantity,
        // TODO:add enum orderStatus :accepted,delivered,etc
        'delivered': false,
        'price': price
      },
    );
    return orderDoc;
  }

  Future markDelivered(DocumentReference documentReference) async {
    await documentReference.update({'delivered': true});
  }

  //==========================================================================//
  // ADDRESS SECTION

  Future<bool> addAddress({
    required String title,
    required String completeAddress,
    String? landmark,
    String? floor,
    required GeoPoint position,
  }) async {
    try {
      await _db.collection('addressBook').doc(_user.uid).set(
        {
          title: {
            'Complete Address': completeAddress,
            'landmark': landmark,
            'floor': floor,
            'position': position,
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
  // SELLERS SECTION

  Stream<DocumentSnapshot> getSellers() {
    return _db.collection('sellers').doc('sellersList').snapshots();
  }

  Future addSeller({
    required String shopName,
    required String photoUrl,
    required String location,
    required DocumentReference documentReference,
  }) async {
    return _db.collection('sellers').doc('sellersList').set(
      {
        shopName: {
          'photoUrl': photoUrl,
          'location': location,
          'docRef': documentReference,
        }
      },
      SetOptions(merge: true),
    );
  }

  Future<DocumentReference> setSellerDetails({
    required String opentime,
    required String closetime,
    required String shopName,
    required GeoPoint position,
    required int maxBottles,
    required int bottlePrice,
    required int deliveryRate,
  }) async {
    DocumentReference doc = _db.collection('sellers').doc();
    await doc.set({
      'shopName': shopName,
      'openTime': opentime,
      'closeTime': closetime,
      'position': position,
      'bottlePrice': bottlePrice,
      'deliveryRate': deliveryRate,
      'maxBottles': maxBottles,
      'availBottles': maxBottles,
    });
    return doc;
  }

  Future<Object> getSellerDetails({required DocumentReference docRef}) async {
    DocumentSnapshot res = await docRef.get();
    return res.data() ?? {};
  }
}
