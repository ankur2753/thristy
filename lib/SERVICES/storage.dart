import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StorageServicesProvider extends ChangeNotifier {
  final Reference storageRef = FirebaseStorage.instance.ref();

  Future<String> uploadImage(File bannerImg, String shopName) async {
    String path = "";
    storageRef
        .child('sellerBanners')
        .putFile(bannerImg.renameSync(shopName))
        .then((p0) async {
      path = await p0.ref.getDownloadURL();
    });
    return path;
  }
}
