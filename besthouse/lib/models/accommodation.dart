import 'package:besthouse/widgets/search/filter_sheet.dart';

class AccommodationObject {
  final String name;
  final Accommodation type;

  AccommodationObject(this.name, this.type);
}

enum Accommodation { house, condo, hotel, shophouse }
