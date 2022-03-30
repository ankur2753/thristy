import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext ctx, int index) {
          return const SellerCard();
        });
  }
}

class SellerCard extends StatelessWidget {
  const SellerCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network("https://picsum.photos/400/200"),
          const ListTile(
            title: Text("Name of the seller"),
            subtitle: Text("Location of the seller"),
            trailing: Text("4.3/5"),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [Icon(Icons.favorite), Icon(Icons.share)],
          )
        ],
      ),
    );
  }
}
