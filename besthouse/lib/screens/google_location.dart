import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../services/location_api.dart';
import '../services/provider.dart';
import '../widgets/google_location/address_search.dart';

class GoogleLocation extends StatefulWidget {
  const GoogleLocation({Key? key}) : super(key: key);
  static const routeName = "/google_location";

  @override
  _GoogleLocationState createState() => _GoogleLocationState();
}

class _GoogleLocationState extends State<GoogleLocation> {
  final _textController = TextEditingController();
  final Completer<GoogleMapController> _controller = Completer();

  void resetLocation() {
    _textController.text = "";
    Provider.of<CurrentLocation>(context, listen: false).resetLocation();
    Provider.of<DesireLocation>(context, listen: false).resetLocation();
    _controller.future.then((value) => value.animateCamera(CameraUpdate.newCameraPosition(
        Provider.of<CurrentLocation>(context, listen: false).currentLocation)));
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition location;
    bool isDesireLocation = context.watch<DesireLocation>().location.target.latitude != 90.0 &&
        context.watch<DesireLocation>().location.target.longitude != -160;
    if (isDesireLocation) {
      location = context.watch<DesireLocation>().location;
    } else {
      location = context.watch<CurrentLocation>().currentLocation;
    }

    return Scaffold(
      appBar: AppBar(
        title: _textController.text == ""
            ? const Text("Enter your desire location", style: TextStyle(fontSize: 15))
            : Text(_textController.text, style: const TextStyle(fontSize: 15)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final sessionToken = const Uuid().v4();
              final Suggestion result = await showSearch(
                context: context,
                delegate: AddressSearch(sessionToken),
              ) as Suggestion;
              final placeDetails =
                  await PlaceApiProvider(sessionToken).getPlaceDetailFromId(result.placeId);

              setState(() {
                _textController.text = result.description;
              });
              context.read<DesireLocation>().updateLocation(placeDetails.location);

              CameraUpdate update = CameraUpdate.newCameraPosition(placeDetails.location);
              _controller.future.then((value) => value.animateCamera(update));
            },
          ),
        ],
      ),
      body: GoogleMap(
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: resetLocation,
        child: const Icon(Icons.my_location),
      ),
    );
  }
}

class GoogleLocationArgument {
  final CameraPosition location;

  GoogleLocationArgument(this.location);
}
