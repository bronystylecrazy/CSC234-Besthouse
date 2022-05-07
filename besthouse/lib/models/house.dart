import 'package:besthouse/models/room.dart';

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

  factory House.fromJson(Map<String, dynamic> data) {
    return House(
      id: data['_id'],
      name: data['name'],
      pictureUrl: data['picture_url'],
      price: data['price'],
      address: data['address'],
      location: Location(coordinates: [
        data['location']['coordinates'][0] as double,
        data['location']['coordinates'][1] as double,
      ]),
      tags: [...data['tags']],
      type: data['type'].toString().substring(0, 1) +
          data['type'].toString().substring(1).toLowerCase(),
      isAdvertised: data['is_advertised'],
    );
  }

  factory House.fromJson2(Map<String, dynamic> data) {
    return House(
      id: data['house']['_id'],
      name: data['house']['name'],
      pictureUrl: data['house']['picture_url'],
      price: data['house']['price'],
      address: data['house']['address'],
      location: Location(coordinates: [
        data['house']['location']['coordinates'][0] as double,
        data['house']['location']['coordinates'][1] as double,
      ]),
      tags: [...data['house']['tags']],
      type: data['house']['type'].toString().substring(0, 1) +
          data['house']['type'].toString().substring(1).toLowerCase(),
      isAdvertised: data['house']['is_advertised'],
      detail: HouseDetail(
        houseId: data['house']['_id'],
        userId: data['houseDetail']['user_id'],
        rooms: [
          ...data['houseDetail']['rooms'].map((e) => Room(
              type: e["type"],
              amount: e['amount'],
              pictures: [...e['pictures']]))
        ],
        facilities: [...data['houseDetail']['facilities']],
        description: data['houseDetail']['description'],
        electricFee:
            double.parse(data['houseDetail']['electric_fee'].toString()),
        likes: data['houseDetail']['likes'],
        totalSize: double.parse(data['houseDetail']['total_size'].toString()),
        waterFee: double.parse(data['houseDetail']['water_fee'].toString()),
      ),
    );
  }

  get userId => null;
}
