import './location.dart';

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

  House({
    required this.id,
    required this.name,
    required this.pictureUrl,
    required this.price,
    required this.address,
    required this.location,
    this.tags = const [],
    this.type = "HOUSE",
    this.status = true,
    this.isAdvertised = false,
  });
}
