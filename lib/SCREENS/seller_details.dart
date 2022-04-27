import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:thristy/SERVICES/database.dart';
import 'dart:io';
import 'package:thristy/utils/button_component.dart';
import 'package:thristy/utils/input_component.dart';
import 'package:image_picker/image_picker.dart';

class SellerDetails extends StatefulWidget {
  const SellerDetails({Key? key}) : super(key: key);

  @override
  State<SellerDetails> createState() => _SellerDetailsState();
}

class _SellerDetailsState extends State<SellerDetails> {
  TextEditingController name = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController workingHours = TextEditingController();
  File? image;
  @override
  void dispose() {
    name.dispose();
    location.dispose();
    super.dispose();
  }

  Future getImage(bool fromGallery) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? selected;
    if (fromGallery) {
      selected = await imagePicker.pickImage(source: ImageSource.gallery);
    } else {
      selected = await imagePicker.pickImage(source: ImageSource.camera);
    }
    setState(() {
      if (selected != null) {
        image = File(selected.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Seller Details"),
      ),
      body: Form(
        child: ListView(
          children: [
            InputSection(
              controller: name,
              descriptor: "Enter the Name of Shop",
              validator: (String? givenName) {
                String? errorMsg;
                Provider.of<DatabaseServiesProvider>(context, listen: false)
                    .getSellers()
                    .every(
                  (element) {
                    String ele = element.toString();
                    if (ele == givenName) {
                      errorMsg = "Shop name already taken";
                      return true;
                    }
                    return false;
                  },
                );
                return errorMsg;
              },
            ),
            InputSection(
              controller: location,
              descriptor: "Enter the location of Shop",
            ),
            InputSection(
              controller: location,
              descriptor: "Enter the location of Shop",
            ),
            BigButton(
              onPressed: () {
                return showDialog(
                  context: context,
                  builder: (context) => SimpleDialog(
                    title: const Text("Select a Banner Image"),
                    children: [
                      SimpleDialogOption(
                        child: const Text("Upload from gallery"),
                        onPressed: () async {
                          Navigator.of(context).pop();
                          if (await Permission.photos.isDenied) {
                            Permission.photos.request();
                          }
                          if (await Permission.photos.isPermanentlyDenied) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Files Permissions  denied, cannot request"),
                              ),
                            );
                          }
                          getImage(true);
                        },
                      ),
                      SimpleDialogOption(
                        child: const Text("Take a picture"),
                        onPressed: () async {
                          Navigator.of(context).pop();
                          if (await Permission.camera.isDenied) {
                            Permission.camera.request();
                          }
                          if (await Permission.camera.isPermanentlyDenied) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Camera Permissions denied, cannot request"),
                              ),
                            );
                          }
                          getImage(false);
                        },
                      ),
                    ],
                  ),
                );
              },
              buttonChild: const Text("Select a Banner Image"),
              isCTA: true,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}
