import 'package:flutter/material.dart';
import 'package:thristy/utils/input_component.dart';

class SellerDetails extends StatefulWidget {
  const SellerDetails({Key? key}) : super(key: key);

  @override
  State<SellerDetails> createState() => _SellerDetailsState();
}

class _SellerDetailsState extends State<SellerDetails> {
  TextEditingController name = TextEditingController();
  TextEditingController location = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    location.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        child: Column(
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
          ],
        ),
      ),
    );
  }
}
