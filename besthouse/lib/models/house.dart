class House {
  final String name;
  final String pictureUrl;
  final int price;
  final List<String> tags;
  final String type;
  final bool status;

  House({
    required this.name,
    required this.pictureUrl,
    required this.price,
    this.tags = const [],
    this.type = "HOUSE",
    this.status = true,
  });
}
