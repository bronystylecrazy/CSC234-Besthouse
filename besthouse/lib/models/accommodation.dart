class AccommodationObject {
  final String name;
  final Accommodation type;

  AccommodationObject(this.name, this.type);
}

enum Accommodation { all, house, condominium, hotel }
