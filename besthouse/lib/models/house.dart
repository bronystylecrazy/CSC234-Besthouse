import './location.dart';
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
  final bool isAdvertised;

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
    this.isAdvertised = false,

  });

  get userId => null;
}
