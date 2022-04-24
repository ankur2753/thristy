import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StorageServicesProvider extends ChangeNotifier {
  final Reference storageRef = FirebaseStorage.instance.ref();

  Future<String> getImageUrl(String fullPath) {
    return storageRef.child('sellerBanners').getDownloadURL();
  }

  Future<String> uploadImage(File bannerImg, String shopName) async {
    String path = "";
    storageRef
        .child('sellerBanners')
        .putFile(bannerImg.renameSync(shopName))
        .then((p0) {
      path = p0.ref.fullPath;
    });
    return path;
  }
}
