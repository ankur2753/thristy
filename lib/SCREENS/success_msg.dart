import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thristy/utils/button_component.dart';

class SuccesScreen extends StatelessWidget {
  final String msg;
  const SuccesScreen({
    required this.msg,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Successfull"),
        backgroundColor: Colors.green,
        // TODO: change color back to normal after this screen
      ),
      body: Column(mainAxisSize: MainAxisSize.max, children: [
        Expanded(
          child: Center(
            child: Column(
              children: [
                const FaIcon(
                  FontAwesomeIcons.faceSmile,
                  size: 80,
                ),
                Text(
                  "Successful",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(msg)
              ],
            ),
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
