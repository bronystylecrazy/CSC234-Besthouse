import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../services/provider.dart';

class Map extends StatefulWidget {
  final CameraPosition currentLocation;
  const Map({Key? key, required this.currentLocation}) : super(key: key);

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    var location = context.watch<CurrentLocation>().currentLocation;
    print(context.watch<CurrentLocation>().currentLocation);
    print(context.watch<DesireLocation>().location);
    if (context.watch<DesireLocation>().location.target.latitude != 90.0 &&
        context.watch<DesireLocation>().location.target.longitude != -160) {
      location = context.watch<DesireLocation>().location;
    }

    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: location,
      buildingsEnabled: true,
      trafficEnabled: true,
      markers: {
        Marker(
          markerId: const MarkerId('1'),
          position: LatLng(context.watch<CurrentLocation>().currentLocation.target.latitude,
              context.watch<CurrentLocation>().currentLocation.target.longitude),
          infoWindow: const InfoWindow(
            title: 'You',
            snippet: 'Hello',
          ),
        ),
      },
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      onTap: (value) {},
    );
  }
}
