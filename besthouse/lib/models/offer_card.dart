class OfferCardModel {
  final String name;
  bool isAvailable;
  final String id;
  OfferCardModel(
      {required this.id, required this.isAvailable, required this.name});

  void toggleIsAvailable() {
    isAvailable != isAvailable;
  }
}
