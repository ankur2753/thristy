import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:thristy/SCREENS/become_seller.dart';
import 'package:thristy/SCREENS/locate_on_map.dart';
import 'package:thristy/SERVICES/database.dart';
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
  TextEditingController bottlePrice = TextEditingController();
  TextEditingController deliveryPrice = TextEditingController();
  TextEditingController maxBottles = TextEditingController();
  File? image;
  TimeOfDay openTime = TimeOfDay.now();
  TimeOfDay closeTime = TimeOfDay.now();
  GeoPoint position = const GeoPoint(13.067784388176461, 77.50450360519412);
  @override
  void dispose() {
    name.dispose();
    super.dispose();
  }

  void changePosition(double latitude, double longitude) {
    setState(() {
      position = GeoPoint(latitude, longitude);
    });
  }

  Future getImage(bool fromGallery) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? selected;
    if (fromGallery) {
      selected = await imagePicker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 400,
        imageQuality: 60,
      );
    } else {
      selected = await imagePicker.pickImage(
        source: ImageSource.camera,
        maxHeight: 400,
        imageQuality: 60,
      );
    }
    setState(() {
      if (selected != null) {
        image = File(selected.path);
      }
    });
  }

  Future<List> sellers() async {
    return Provider.of<DatabaseServiesProvider>(context).getSellers().toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Seller Details"),
      ),
      floatingActionButton: faB(context),
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          children: [
            getName(),
            InputSection(
              controller: location,
              descriptor: "Enter Your Location",
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                    label: Text("Enter the price of bottle")),
                controller: bottlePrice,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                    label: Text("Enter the price of delivery")),
                controller: deliveryPrice,
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                    label: Text("Enter the max no of bottles")),
                controller: maxBottles,
                keyboardType: TextInputType.number,
              ),
            ),
            getTime(context, true),
            getTime(context, false),
            BigButtonWithIcon(
              buttonIcon: image == null
                  ? const FaIcon(
                      FontAwesomeIcons.xmark,
                      color: Colors.red,
                    )
                  : const FaIcon(
                      FontAwesomeIcons.check,
                      color: Colors.lightGreen,
                    ),
              onPressed: () {
                return imageLocationDialog(context);
              },
              buttonLable: const Text("Select a Banner Image"),
              isCTA: true,
            ),
            BigButtonWithIcon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (BuildContext context) {
                      return Scaffold(
                        appBar: AppBar(
                          title: const Text("Locate the shop"),
                          actions: [
                            TextButton(
                              child: const Text("Save"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        ),
                        body: LocatePin(
                          changePosition: changePosition,
                        ),
                      );
                    },
                  ),
                );
              },
              buttonIcon: const FaIcon(FontAwesomeIcons.mapLocation),
              buttonLable: const Text("Locate the Shop"),
              isCTA: true,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text("Longitude: ${position.longitude}"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text("Latitude: ${position.latitude}"),
            ),
          ],
        ),
      ),
    );
  }

  Row getTime(BuildContext context, bool isOpeningTime) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(isOpeningTime ? "Opening Time" : "Closing Time"),
        const SizedBox(width: 20),
        ElevatedButton(
          onPressed: () async {
            TimeOfDay selectedTime = await showTimePicker(
                    context: context,
                    initialTime: isOpeningTime ? openTime : closeTime) ??
                openTime;
            setState(() {
              if (isOpeningTime) {
                openTime = selectedTime;
              } else {
                closeTime = selectedTime;
              }
            });
          },
          child: Text(
            isOpeningTime
                ? openTime.format(context)
                : closeTime.format(context),
          ),
        ),
      ],
    );
  }

  InputSection getName() {
    return InputSection(
      controller: name,
      descriptor: "Enter the Name of Shop",
      validator: (String? givenName) {
        String? errorMsg;
        sellers().then((value) => print);
        if (givenName == null || givenName.isEmpty) {
          return "empty";
        }
        // TODO: DO VALIDATION
        sellers().then(
          (listSellers) {
            print(listSellers);
            if (listSellers.contains(givenName)) {
              errorMsg = "seller Already exists";
            }
          },
        );
        return errorMsg;
      },
    );
  }

  FloatingActionButton faB(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        if (name.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "A Name is required\nPlease Enter a Name",
              ),
            ),
          );
          return;
        }
        if (image == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "A Banner Image is required\nPlease select a Picture",
              ),
            ),
          );
          return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (builder) => BecomeSeller(
              maxBottles: int.parse(maxBottles.text),
              deliveryRate: int.parse(deliveryPrice.text),
              bottlePrice: int.parse(bottlePrice.text),
              openTime: openTime.format(context),
              closeTime: closeTime.format(context),
              location: location.text,
              image: image!,
              position: position,
              shopName: name.text,
            ),
          ),
        );
      },
      child: const Icon(Icons.navigate_next),
    );
  }

  imageLocationDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text("Select a Banner Image"),
        children: [
          SimpleDialogOption(
            child: const Text("Upload from gallery"),
            onPressed: () async {
              Navigator.of(context).pop();
              getImage(true);
            },
          ),
          SimpleDialogOption(
            child: const Text("Take a picture"),
            onPressed: () async {
              Navigator.of(context).pop();
              getImage(false);
            },
          ),
        ],
      ),
    );
  }
}
