import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatefulWidget {
  final List<double?> locationApi;
  const Map({Key? key, required this.locationApi}) : super(key: key);

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );

  @override
  Widget build(BuildContext context) {
    // var promiseLocation = LocationApi.getLocation();
    // promiseLocation.then((value) {
    //   widget.locationApi = value;
    // });

    CameraPosition _initposition = CameraPosition(
      target: LatLng(widget.locationApi[1] ?? 0, widget.locationApi[0] ?? 0),
      zoom: 14,
    );

    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _initposition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        onTap: (value) {
          print(value);
        },
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
