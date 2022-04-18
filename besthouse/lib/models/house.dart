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
  });
}

class Location {
  final List<double> coordinates;
  final String type = 'Point';

  Location({
    required this.coordinates,
  });
}
