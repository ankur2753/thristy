import 'package:flutter/material.dart';
import 'package:thristy/utils/constants.dart';
import 'package:flutter/cupertino.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shadowColor: kLightBlue,
        color: Colors.black,
        elevation: 18,
        margin: const EdgeInsets.symmetric(vertical: 15),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Useage This Month"),
              Text(
                "2000 LTRS",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 18),
              const Text("Useage Last Month"),
              Text(
                "3000 LTRS",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
