import 'dart:async';
import 'package:animations/animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:thristy/SCREENS/add_address.dart';

class LocateOnMap extends StatefulWidget {
  const LocateOnMap({Key? key}) : super(key: key);

  @override
  State<LocateOnMap> createState() => _LocateOnMapState();
}

class _LocateOnMapState extends State<LocateOnMap> {
  final Completer<GoogleMapController> _completer = Completer();
  final CameraPosition _initPosition = const CameraPosition(
      target: LatLng(13.067784388176461, 77.50450360519412), zoom: 15.5);
  @override
  Widget build(BuildContext context) {
    CameraPosition _cameraPosition = _initPosition;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Locate on Map"),
      ),
      body: Stack(children: [
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _initPosition,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          onMapCreated: (GoogleMapController controller) {
            _completer.complete(controller);
          },
        ),
        Center(
          child: FaIcon(
            FontAwesomeIcons.locationDot,
            size: 40,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ]),
      floatingActionButton: OpenContainer(
        closedColor: Colors.transparent,
        closedShape: const CircleBorder(),
        closedBuilder: (BuildContext c, VoidCallback action) =>
            const FloatingActionButton(
          child: Icon(Icons.navigate_next),
          onPressed: null,
        ),
        openBuilder: (BuildContext c, VoidCallback action) =>
            AddAddress(givenPos: _cameraPosition.target),
        tappable: true,
      ),
    );
  }
}
