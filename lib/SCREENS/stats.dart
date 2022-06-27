import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OpenContainer(
        closedElevation: 6,
        closedColor: Theme.of(context).primaryColor,
        closedBuilder: (context, action) => closedCard(context),
        openBuilder: (context, action) => openCard(),
      ),
    );
  }

  Scaffold openCard() {
    return Scaffold(
      appBar: AppBar(title: const Text("Graphs and Stats Here")),
      body: const Center(
        child: Text("hello"),
      ),
    );
  }

  Padding closedCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
  }
}
