import 'dart:async';
import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  GeoPoint position = const GeoPoint(13.067784388176461, 77.50450360519412);
  void changePosition(double latitude, double longitude) {
    position = GeoPoint(latitude, longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Locate on Map"),
      ),
      body: LocatePin(
        changePosition: changePosition,
      ),
      floatingActionButton: OpenContainer(
        closedColor: Colors.transparent,
        closedShape: const CircleBorder(),
        closedBuilder: (BuildContext c, VoidCallback action) =>
            const FloatingActionButton(
          child: Icon(Icons.navigate_next),
          onPressed: null,
        ),
        openBuilder: (BuildContext c, VoidCallback action) =>
            AddAddress(givenPos: position),
        tappable: true,
      ),
    );
  }
}

class LocatePin extends StatefulWidget {
  final Function changePosition;
  const LocatePin({Key? key, required this.changePosition}) : super(key: key);

  @override
  State<LocatePin> createState() => _LocatePinState();
}

class _LocatePinState extends State<LocatePin> {
  final Completer<GoogleMapController> _completer = Completer();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: const CameraPosition(
            target: LatLng(13.067784388176461, 77.50450360519412),
            zoom: 16,
          ),
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          onMapCreated: (GoogleMapController controller) {
            _completer.complete(controller);
          },
          onCameraMove: (CameraPosition newPosition) {
            widget.changePosition(
                newPosition.target.latitude, newPosition.target.longitude);
          },
        ),
        Center(
          child: FaIcon(
            FontAwesomeIcons.locationDot,
            size: 40,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ],
    );
  }
}
