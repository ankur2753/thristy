import 'package:flutter/material.dart';
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
      appBar: AppBar(),
      body: Form(
        child: ListView(
          children: [
            InputSection(
              controller: name,
              descriptor: "Enter the Name of Shop",
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
                        onPressed: () {
                          Navigator.of(context).pop();
                          getImage(true);
                        },
                      ),
                      SimpleDialogOption(
                        child: const Text("Take a picture"),
                        onPressed: () {
                          Navigator.of(context).pop();
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
    );
  }
}
