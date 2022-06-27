import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StorageServicesProvider extends ChangeNotifier {
  final Reference _storageRef = FirebaseStorage.instance.ref();

  Future<String> uploadImage(File bannerImg, String shopName) async {
    TaskSnapshot img = await _storageRef
        .child('sellerBanners')
        .child(shopName)
        .putFile(bannerImg);
    return img.ref.getDownloadURL();
  }
}
