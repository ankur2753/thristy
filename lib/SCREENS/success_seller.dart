import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thristy/utils/button_component.dart';

class SuccesSeller extends StatelessWidget {
  const SuccesSeller({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Successfull"),
        backgroundColor: Colors.green,
        // TODO: change color back to normal after this screen
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.green),
      ),
      body: Column(mainAxisSize: MainAxisSize.max, children: [
        Expanded(
          child: Column(
            children: [
              const FaIcon(
                FontAwesomeIcons.circleCheck,
                size: 80,
              ),
              Text(
                "Congratulation",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Text("You're a Seller Now !")
            ],
          ),
        ),
        BigButton(
          buttonChild: const Text("Done"),
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
          isCTA: true,
        ),
      ]),
    );
  }
}
