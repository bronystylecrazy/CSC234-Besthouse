import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/foundation.dart';

class CurrentLocation with ChangeNotifier, DiagnosticableTreeMixin {
  CameraPosition currentLocation = const CameraPosition(target: LatLng(100, 200));

  void updateLocation(CameraPosition newLocation) {
    currentLocation = newLocation;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('latitude', currentLocation.target.latitude));
    properties.add(DoubleProperty('longitude', currentLocation.target.longitude));
  }
}

class DesireLocation with ChangeNotifier, DiagnosticableTreeMixin {
  CameraPosition location = const CameraPosition(target: LatLng(100, 200));

  void updateLocation(CameraPosition newLocation) {
    location = newLocation;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('latitude', location.target.latitude));
    properties.add(DoubleProperty('longitude', location.target.longitude));
  }
}
