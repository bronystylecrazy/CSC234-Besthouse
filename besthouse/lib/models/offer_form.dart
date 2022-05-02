import 'dart:io';

import 'package:dio/dio.dart';

import 'location.dart';

class Offer {
  String name = "";
  String type = "HOUSE";
  File pictureUrl = File('');
  MultipartFile? file;
  Location location = Location(coordinates: [0, 0]);
  String address = "";
  String description = "";
  int price = 0;
  List<OfferRoom> rooms = [];
  List<String> facilities = [];
  double electricFee = 0;
  double waterFee = 0;
  double totalSize = 0;
  List<String> tags = [];

  Offer() {
    name = "";
    type = "HOUSE";
    pictureUrl = File('');
    location = Location(coordinates: [0, 0]);
    address = "";
    description = "";
    price = 0;
    rooms = [];
    facilities = [];
    electricFee = 0;
    waterFee = 0;
    totalSize = 0;
    tags = [];
  }

  Offer.set(Offer offer) {
    name = offer.name;
    type = offer.type;
    pictureUrl = offer.pictureUrl;
    location = offer.location;
    address = offer.address;
    description = offer.description;
    price = offer.price;
    rooms = offer.rooms;
    facilities = offer.facilities;
    electricFee = offer.electricFee;
    waterFee = offer.waterFee;
    totalSize = offer.totalSize;
    tags = offer.tags;
  }

  set setName(String value) => name = value;
  set setType(String value) => type = value;
  set setPictureUrl(File value) => pictureUrl = value;
  set setLocation(Location value) => location = value;
  set setAddress(String value) => address = value;
  set setDescription(String value) => description = value;
  set setPrice(int value) => price = value;
  set setRooms(List<OfferRoom> value) => rooms = value;
  set setFacilities(List<String> value) => facilities = value;
  set setElectricFee(double value) => electricFee = value;
  set setWaterFee(double value) => waterFee = value;
  set setTotalSize(double value) => totalSize = value;
  set setTags(List<String> value) => tags = value;

  void update(String prop, dynamic value) {
    switch (prop) {
      case "name":
        name = value;
        break;
      case "type":
        type = value;
        break;
      case "pictureUrl":
        pictureUrl = value;
        break;
      case "file":
        file = value;
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

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "file": file,
        "location": location.toJson(),
        "address": address,
        "description": description,
        "price": price,
        "rooms": rooms.map((e) => e.toJson()).toList(),
        "facilities": facilities,
        "electricFee": electricFee,
        "waterFee": waterFee,
        "totalSize": totalSize,
        "tags": tags,
      };
}

class OfferRoom {
  String type;
  int amount;
  List<File> pictures;
  List<MultipartFile>? files;

  OfferRoom({
    required this.type,
    required this.amount,
    required this.pictures,
  });

  set setType(String value) => type = value;
  set setAmount(int value) => amount = value;
  set setPictures(List<File> value) => pictures = value;

  Map<String, dynamic> toJson() => {
        "type": type,
        "amount": amount,
        "files": files,
      };
}
