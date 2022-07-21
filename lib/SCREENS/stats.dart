import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thristy/services/database.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 11,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Usage This Month"),
              FutureBuilder(
                  future:
                      Provider.of<DatabaseServiesProvider>(context).getUsage(),
                  builder: (context, snapshot) {
                    print(snapshot.hasData);
                    return Text(
                      "sad",
                      style: Theme.of(context).textTheme.displayMedium,
                    );
                  }),
              const SizedBox(height: 18),
              const Text("Usage Last Month"),
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
