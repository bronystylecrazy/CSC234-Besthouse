import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../services/location_api.dart';

class Map extends StatefulWidget {
  final CameraPosition initPosition;
  const Map({Key? key, required this.initPosition}) : super(key: key);

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    // LocationApi.getLocation().then((value) {
    //   print(value[0]);
    //   setState(() {
    //     _initposition = CameraPosition(
    //       target: LatLng(value[1], value[0]),
    //       zoom: 16,
    //     );
    //   });
    // });
    // promiseLocation.then((value) {
    //   widget.locationApi = value;
    // });

    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: widget.initPosition,
        buildingsEnabled: true,
        trafficEnabled: true,
        markers: {
          Marker(
            markerId: MarkerId('1'),
            position:
                LatLng(widget.initPosition.target.latitude, widget.initPosition.target.longitude),
            infoWindow: InfoWindow(
              title: 'Hello',
              snippet: 'Hello',
            ),
          ),
        },
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        onTap: (value) {
          print(value);
          Navigator.pushNamed(context, '/google_location');
          setState(() {});
        },
      ),
    );
  }
}
