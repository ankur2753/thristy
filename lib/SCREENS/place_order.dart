import 'package:flutter/material.dart';

class PlaceOrderScreen extends StatefulWidget {
  const PlaceOrderScreen({Key? key}) : super(key: key);

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  int currContainer = 0;

  final List<Widget> sections = [
    Container(
      color: Colors.green,
    ),
    Container(
      color: Colors.white,
    ),
    Container(
      color: Colors.yellow,
    ),
    Container(
      color: Colors.deepPurple,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Expanded(
            child: Card(
              color: Color(0xFF6C7888),
              child: SizedBox(
                height: 120,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("bruh"),
                    Text("bruh"),
                    Text("bruh"),
                    Text("bruh"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
