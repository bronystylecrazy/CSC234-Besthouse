import 'dart:io';

import 'location.dart';

class Offerform {
  String name = "";
  String type = "HOUSE";
  Location location = Location(coordinates: [0, 0]);
  String address = "";
  int price = 0;
  List<String> tags = [];
  List<OfferRoom> rooms = [];
  String description = "";
  List<String> facilities = [];
  double electricFee = 0;
  double waterFee = 0;
  double totalSize = 0;
  String pictureUrl = "";
  File? picture;

  Offerform();

  Offerform.fromJson(Map<String, dynamic> json) {
    name = json['house']['name'];
    type = json['house']['type'];
    location = json['house']['location'];
    address = json['house']['address'];
    price = json['house']['price'];
    tags = json['house']['tags'];
    rooms = json['houseDetail']['rooms'];
    description = json['houseDetail']['description'];
    facilities = json['houseDetail']['facilities'];
    electricFee = json['houseDetail']['electricFee'];
    waterFee = json['houseDetail']['waterFee'];
    totalSize = json['houseDetail']['totalSize'];
    pictureUrl = json['house']['picture_url'];
    picture = null;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'picture_url': pictureUrl,
      'location': location.toJson(),
      'address': address,
      'description': description,
      'price': price,
      'rooms': rooms.map((e) => e.toJson()).toList(),
      'facilities': facilities,
      'electric_fee': electricFee,
      'water_fee': waterFee,
      'total_size': totalSize,
      'tags': tags,
    };
  }

  void update(String prop, dynamic value) {
    switch (prop) {
      case "name":
        name = value;
        break;
      case "type":
        type = value;
        break;
      case "picture":
        picture = value;
        break;
      case "location":
        location = value;
        break;
      case "address":
        address = value;
        break;
      case "description":
        description = value;
        break;
      case "price":
        price = value;
        break;
      case "rooms":
        rooms = value;
        break;
      case "facilities":
        facilities = value;
        break;
      case "electricFee":
        electricFee = value;
        break;
      case "waterFee":
        waterFee = value;
        break;
      case "totalSize":
        totalSize = value;
        break;
      case "tags":
        tags = value;
        break;
    }
  }
}

class OfferRoom {
  String type;
  int amount;
  List<String> pictures = <String>[];
  List<File>? files;

  OfferRoom({
    required this.type,
    required this.amount,
    this.files,
    this.pictures = const [],
  });

  Map<String, dynamic> toJson() => {
        'type': type,
        'amount': amount,
        'pictures': pictures,
      };
}
