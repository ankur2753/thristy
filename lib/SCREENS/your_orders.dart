import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:thristy/SERVICES/database.dart';
import 'package:thristy/utils/button_component.dart';
import 'package:thristy/utils/constants.dart';

class YourOrdersScreen extends StatelessWidget {
  const YourOrdersScreen({Key? key}) : super(key: key);

  final List<Widget> noOrders = const [
    FaIcon(
      FontAwesomeIcons.cartShopping,
      color: kWhiteBlue,
      size: 169,
    ),
    SizedBox(height: 20),
    Text("You Don't Have an Order Yet,"),
    Text("Try Ordering First"),
  ];
  // TODO: implement firebase logic here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order History"),
      ),
      body: StreamBuilder(
          stream: Provider.of<DatabaseServiesProvider>(context).getOrders(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    child: Column(
                      children: [
                        const ListTile(
                          title: Text("1x 10ltr Bottle"),
                          subtitle: Text("New Water Supply Co."),
                        ),
                        BigButton(
                          onPressed: () {},
                          buttonChild: const Text("ReOrder"),
                          isCTA: true,
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
