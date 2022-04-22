import 'package:besthouse/services/dio.dart';
import 'package:dio/dio.dart';
import 'package:location/location.dart';
import 'dart:convert';
import 'dart:io';

class LocationApi {
  static Future<List<double?>> getLocation() async {
    final Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

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

class Place {
  String streetNumber;
  String street;
  String city;
  String zipCode;

  Place({
    this.streetNumber = "",
    this.street = "",
    this.city = "",
    this.zipCode = "",
  });

  @override
  String toString() {
    return 'Place(streetNumber: $streetNumber, street: $street, city: $city, zipCode: $zipCode)';
  }
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

class PlaceApiProvider {
  final sessionToken;
  final String apiKey = "AIzaSyBugQOo_mjZGdkM7ud_VGCNh-oriwAglv4";

  PlaceApiProvider(this.sessionToken);

  Future<List<Suggestion>> fetchSuggestions(String input, String lang) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&language=$lang&key=$apiKey&sessiontoken=$sessionToken';
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

  Future<Place> getPlaceDetailFromId(String placeId) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=address_component&key=$apiKey&sessiontoken=$sessionToken';
    final response = await DioInstance.dio.get(request);

    if (response.statusCode == 200) {
      final result = response.data;
      if (result['status'] == 'OK') {
        final components = result['result']['address_components'] as List<dynamic>;
        // build result
        final place = Place();
        components.forEach((c) {
          final List type = c['types'];
          if (type.contains('street_number')) {
            place.streetNumber = c['long_name'];
          }
          if (type.contains('route')) {
            place.street = c['long_name'];
          }
          if (type.contains('locality')) {
            place.city = c['long_name'];
          }
          if (type.contains('postal_code')) {
            place.zipCode = c['long_name'];
          }
        });
        return place;
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
