import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

//service
import '../services/location_api.dart';
import '../services/provider.dart';

//widget
import '../widgets/google_location/address_search.dart';

class GoogleLocation extends StatefulWidget {
  const GoogleLocation({Key? key}) : super(key: key);
  static const routeName = "/google_location";

  @override
  _GoogleLocationState createState() => _GoogleLocationState();
}

class _GoogleLocationState extends State<GoogleLocation> {
  final sessionToken = const Uuid().v4();
  final _textController = TextEditingController();
  final Completer<GoogleMapController> _controller = Completer();

  void _resetLocation() {
    setState(() {
      _textController.text = "";

      Provider.of<CurrentLocation>(context, listen: false).resetLocation();
      Provider.of<DesireLocation>(context, listen: false).resetLocation();

      _controller.future.then((value) => value.animateCamera(CameraUpdate.newCameraPosition(
          Provider.of<CurrentLocation>(context, listen: false).currentLocation)));
    });
  }

  void _onMapTap(LatLng location) async {
    final address = await GoogleApiProvider(sessionToken).getAddress(
      location.latitude,
      location.longitude,
    );

    setState(() {
      Provider.of<DesireLocation>(context, listen: false).updateLocation(CameraPosition(
        target: location,
        zoom: 18,
      ));
      Provider.of<DesireLocation>(context, listen: false).updateAddress(address);

      _controller.future.then(
        (value) => value.animateCamera(
          CameraUpdate.newCameraPosition(
              Provider.of<DesireLocation>(context, listen: false).location),
        ),
      );
      _textController.text = Provider.of<DesireLocation>(context, listen: false).address;
    });
  }

  void _search() async {
    final Suggestion result = await showSearch(
      context: context,
      delegate: AddressSearch(sessionToken),
    ) as Suggestion;

    final placeDetails = await GoogleApiProvider(sessionToken).getPlaceDetailFromId(result.placeId);

    setState(() {
      _textController.text = result.description;
    });
    context.read<DesireLocation>().updateLocation(placeDetails.location);
    context.read<DesireLocation>().updateAddress(placeDetails.address);

    CameraUpdate update = CameraUpdate.newCameraPosition(placeDetails.location);
    _controller.future.then((value) => value.animateCamera(update));
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition location;
    if (Provider.of<DesireLocation>(context).isExist) {
      location = context.watch<DesireLocation>().location;
    } else {
      location = context.watch<CurrentLocation>().currentLocation;
    }

    return Scaffold(
      appBar: AppBar(
        title: _textController.text == ""
            ? const Text(
                "Enter your desire location",
                style: TextStyle(fontSize: 15),
              )
            : Tooltip(
                message: _textController.text,
                child: Text(
                  _textController.text,
                  style: const TextStyle(fontSize: 15),
                ),
              ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _search,
          ),
        ],
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: location,
        buildingsEnabled: true,
        trafficEnabled: true,
        zoomControlsEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        markers: {
          Marker(
            markerId: const MarkerId('1'),
            position: LatLng(
              context.watch<DesireLocation>().latitude,
              context.watch<DesireLocation>().longitude,
            ),
            infoWindow: const InfoWindow(
              title: 'You',
              snippet: 'Hello',
            ),
          )
        },
        onTap: _onMapTap,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _resetLocation,
        child: Icon(
          Icons.my_location,
          color: Theme.of(context).iconTheme.color,
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
          
