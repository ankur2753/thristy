import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SeeLocation extends StatelessWidget {
  final String shopName;
  final LatLng position;
  const SeeLocation({
    Key? key,
    required this.shopName,
    required this.position,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location of $shopName"),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: position,
          zoom: 14,
        ),
        markers: {
          Marker(
            markerId: MarkerId(shopName),
            position: position,
          )
        },
      ),
    );
  }
}
