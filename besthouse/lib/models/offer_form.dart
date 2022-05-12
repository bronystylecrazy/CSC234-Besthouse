import 'dart:io';

import 'location.dart';

class Offerform {
  String name = "";
  String type = "House";
  Location location = Location(coordinates: [0.0, 0.0]);
  String address = "";
  int price = 0;
  List<String> tags = [];
  List<OfferRoom> rooms = [];
  String description = "";
  List<String> facilities = [];
  double electricFee = 0.0;
  double waterFee = 0.0;
  double totalSize = 0.0;
  String pictureUrl = "";
  File? picture;
  String? houseId;

  Offerform();

  Offerform.set({
    required this.name,
    required this.type,
    required this.location,
    required this.address,
    required this.price,
    required this.tags,
    required this.rooms,
    required this.description,
    required this.facilities,
    required this.electricFee,
    required this.waterFee,
    required this.totalSize,
    required this.pictureUrl,
    this.picture,
    this.houseId,
  });

  factory Offerform.fromJson(Map<String, dynamic> data) {
    return Offerform.set(
        name: data['house']['name'],
        type: data['house']['type'].toString().substring(0, 1) +
            data['house']['type'].toString().substring(1).toLowerCase(),
        location: Location(coordinates: [
          data['house']['location']['coordinates'][0] as double,
          data['house']['location']['coordinates'][1] as double,
        ]),
        address: data['house']['address'],
        price: data['house']['price'],
        tags: [...data['house']['tags']],
        rooms: [...data['houseDetail']['rooms'].map((room) => OfferRoom.fromJson(room))],
        description: data['houseDetail']['description'],
        facilities: [...data['houseDetail']['facilities']],
        electricFee: double.parse(data['houseDetail']['electric_fee'].toString()),
        waterFee: double.parse(data['houseDetail']['water_fee'].toString()),
        totalSize: double.parse(data['houseDetail']['total_size'].toString()),
        pictureUrl: data['house']['picture_url'],
        houseId: data['house']['_id'],
        picture: null);
  }

  Map<String, dynamic> toJson() {
    var req = {
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

    if (houseId != null) {
      req['house_id'] = houseId!;
    }

    return req;
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
  List<String> pictures;
  List<File>? files;
  String? roomId;

  OfferRoom({
    required this.type,
    required this.amount,
    this.pictures = const [],
    this.files,
    this.roomId,
  });

  OfferRoom.fromJson(Map<String, dynamic> data)
      : this(
          type: data['type'].toString().substring(0, 1) +
              data['type'].toString().substring(1).toLowerCase(),
          amount: data['amount'],
          pictures: [...data['pictures']],
          roomId: data['_id'],
        );

  Map<String, dynamic> toJson() => {
        'type': type,
        'amount': amount,
        'pictures': pictures,
      };
}
