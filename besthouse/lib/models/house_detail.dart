import 'package:besthouse/models/room.dart';

class HouseDetail {
  final String houseId;
  final String userId;
  final List<Room> rooms;
  final List<String> facilities;
  final String description;
  final double electricFee;
  final int likes;
  final double totalSize;

  HouseDetail({
    required this.houseId,
    required this.userId,
    required this.rooms,
    required this.facilities,
    this.description = "",
    this.electricFee = 0.0,
    this.likes = 0,
    this.totalSize = 0.0,
  });
}
