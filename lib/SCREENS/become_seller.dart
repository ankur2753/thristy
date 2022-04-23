import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thristy/SCREENS/seller_details.dart';
import 'package:thristy/utils/button_component.dart';

class BecomeSeller extends StatelessWidget {
  const BecomeSeller({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            "Are you sure ?",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            "You want to become a Seller",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            "you cannot reverse this process",
            style: Theme.of(context).textTheme.caption,
          ),
          const SizedBox(
            height: 40,
          ),
          BigButtonWithIcon(
            onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (BuildContext ctx) => const SellerDetails()));
            },
            buttonIcon: const FaIcon(
              FontAwesomeIcons.check,
            ),
            buttonLable: const Text("Confirm"),
            isCTA: true,
          ),
          BigButtonWithIcon(
            onPressed: () {
              Navigator.pop(context);
            },
            buttonIcon: const FaIcon(
              FontAwesomeIcons.xmark,
              color: Colors.redAccent,
            ),
            buttonLable: const Text("Cancel"),
            isCTA: false,
          ),
        ],
      ),
    );
  }
}
