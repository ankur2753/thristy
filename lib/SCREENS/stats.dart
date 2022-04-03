import 'package:flutter/material.dart';
import 'package:thristy/utils/constants.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shadowColor: kNavyBlue,
        elevation: 1,
        color: const Color(0xFF0a0a0a),
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
