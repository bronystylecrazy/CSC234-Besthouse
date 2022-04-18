import 'package:besthouse/screens/house_detailed.dart';
import 'package:besthouse/widgets/common/house_detail_card.dart';
import 'package:flutter/material.dart';

// models
import '../models/house.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);
  static const routeName = "/search";

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final List<House> houses = [
    House(
      id: "634gf3438",
      name: "Cosmo Home",
      pictureUrl:
          "https://assets.brandinside.asia/uploads/2021/03/shutterstock_756956185-scaled.jpg",
      price: 4000,
      location: Location(
        coordinates: [-6.2108, 106.8451],
      ),
      address: 'Soi 45 Prachauthid Thungkru, Bangkok',
    ),
  ];

  void _showInfo(String id) {
    Navigator.of(context).pushNamed(HouseDetailed.routeName, arguments: {
      'id': id,
    });
  }

  @override
  Widget build(BuildContext context) {
    return HouseDetailCard(
      house: houses[0],
      showInfoHandler: _showInfo,
    );
  }
}
