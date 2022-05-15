import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OpenContainer(
        closedColor: Colors.black,
        closedBuilder: (BuildContext context, func) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Usage This Month"),
                Text(
                  "2000 LTRS",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 18),
                const Text("Usage Last Month"),
                Text(
                  "3000 LTRS",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          );
        },
        openBuilder: (context, func) {
          return Scaffold(
            appBar: AppBar(title: const Text("Graphs and Stats Here")),
          );
        },
      ),
    );
  }
}
