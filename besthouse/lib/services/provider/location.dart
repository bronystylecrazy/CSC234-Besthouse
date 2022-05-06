import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/foundation.dart';

import '../location_api.dart';

class CurrentLocation with ChangeNotifier, DiagnosticableTreeMixin {
  CameraPosition currentLocation = const CameraPosition(target: LatLng(100, 200), zoom: 18);
  String address = "";

  get latitude => currentLocation.target.latitude;
  get longitude => currentLocation.target.longitude;

  void updateLocation(CameraPosition newLocation) {
    currentLocation = newLocation;
    notifyListeners();
  }

  void updateAddress(String newAddress) {
    address = newAddress;
    notifyListeners();
  }

  void resetLocation() {
    LocationApi.getLocation().then((value) {
      var latlong = value;
      updateLocation(
          CameraPosition(target: LatLng(latlong[1] as double, latlong[0] as double), zoom: 18));
      updateAddress("");
      notifyListeners();
    });
  }
}

class DesireLocation with ChangeNotifier, DiagnosticableTreeMixin {
  CameraPosition location = const CameraPosition(target: LatLng(100, 200), zoom: 18);
  String address = "";

  get latitude => location.target.latitude;
  get longitude => location.target.longitude;
  get isExist => location.target.latitude != 90.0 && location.target.longitude != -160;

  void updateLocation(CameraPosition newLocation) {
    location = newLocation;
    notifyListeners();
  }

  void updateAddress(String newAddress) {
    address = newAddress;
    notifyListeners();
  }

  void resetLocation() {
    updateLocation(const CameraPosition(target: LatLng(100, 200), zoom: 18));
    updateAddress("");
    notifyListeners();
  }
}
