import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/foundation.dart';

import 'location_api.dart';

class CurrentLocation with ChangeNotifier, DiagnosticableTreeMixin {
  CameraPosition currentLocation = const CameraPosition(target: LatLng(100, 200), zoom: 16);

  void updateLocation(CameraPosition newLocation) {
    currentLocation = newLocation;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('latitude', currentLocation.target.latitude));
    properties.add(DoubleProperty('longitude', currentLocation.target.longitude));
  }

  void resetLocation() {
    LocationApi.getLocation().then((value) {
      var latlong = value;
      updateLocation(
          CameraPosition(target: LatLng(latlong[1] as double, latlong[0] as double), zoom: 16));
    });
  }
}

class DesireLocation with ChangeNotifier, DiagnosticableTreeMixin {
  CameraPosition location = const CameraPosition(target: LatLng(100, 200), zoom: 16);

  void updateLocation(CameraPosition newLocation) {
    location = newLocation;
  }

  void resetLocation() {
    updateLocation(const CameraPosition(target: LatLng(100, 200), zoom: 16));
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('latitude', location.target.latitude));
    properties.add(DoubleProperty('longitude', location.target.longitude));
  }
}
