import 'package:besthouse/services/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationApi {
  static Future<List<double?>> getLocation() async {
    final Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;
    String address;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return [0, 0];
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return [0, 0];
      }
    }

    _locationData = await location.getLocation();

    return [_locationData.longitude, _locationData.latitude];
  }
}

class GoogleApiProvider {
  final sessionToken;
  final String _apiKey = "AIzaSyCoIin5viAmmuDbNf7MZZUbEqfMsYUj79Q";

  GoogleApiProvider(this.sessionToken);

  Future<List<Suggestion>> fetchSuggestions(String input, String lang) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&language=$lang&key=$_apiKey&sessiontoken=$sessionToken';
    final response = await DioInstance.dio.get(request);

    if (response.statusCode == 200) {
      final result = response.data;

      if (result['status'] == 'OK') {
        // compose suggestions in a list
        return result['predictions']
            .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
            .toList();
      }

      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }

      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future<String> getAddress(double lat, double long) async {
    final request =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=$_apiKey';
    final response = await DioInstance.dio.get(request);

    if (response.statusCode == 200) {
      final result = response.data;

      if (result['status'] == 'OK') {
        print(result['results'][0]['formatted_address']);
        final address = result['results'][0]['formatted_address'];
        return address;
      }

      if (result['status'] == 'ZERO_RESULTS') {
        return "";
      }

      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch address');
    }
  }

  Future<Place> getPlaceDetailFromId(String placeId) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=geometry,formatted_address&key=$_apiKey&sessiontoken=$sessionToken';
    final response = await DioInstance.dio.get(request);

    if (response.statusCode == 200) {
      final result = response.data;
      print(result["result"]);
      if (result['status'] == 'OK') {
        final locate = result['result']['geometry']['location'] as Map<String, dynamic>;
        final address = result['result']['formatted_address'];
        final place = Place(
          CameraPosition(
            target: LatLng(locate["lat"], locate["lng"]),
            zoom: 18,
          ),
          address,
        );

        return place;
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}

class Place {
  final CameraPosition location;
  final String address;

  const Place(this.location, this.address);
}

class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}
