import 'package:besthouse/models/facilities.dart';
import 'package:besthouse/models/house_detail.dart';

class House {
  final String id;
  final String name;
  final String pictureUrl;
  final int price;
  final String address;
  final Location location;
  final List<String> tags;
  final String type;
  final bool status;
  HouseDetail? detail = HouseDetail(
    houseId: "0",
    description: "A simple house for us!",
    userId: "0",
    rooms: [],
    facilities: [],
  );

  House({
    required this.id,
    required this.name,
    required this.pictureUrl,
    required this.price,
    required this.address,
    required this.location,
    this.detail,
    this.tags = const [],
    this.type = "HOUSE",
    this.status = true,
  });

  get userId => null;
}

class Location {
  final List<double> coordinates;
  final String type = 'Point';

  Location({
    required this.coordinates,
  });
}
