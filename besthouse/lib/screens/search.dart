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
      type: 'CONDOMINIUM',
    ),
    House(
      id: "634gf3438",
      name: "Heliconia House",
      pictureUrl:
          "https://www.immhotel.com/uploads/1/1/2/9/112964589/itc-main-slide-pic-05_orig.jpg",
      price: 6000,
      location: Location(
        coordinates: [13.2108, 107.8451],
      ),
      address: 'KMUTT university Prachauthid Thungkru, Bangkok',
    ),
  ];

  void _showInfo(String id) {
    Navigator.of(context).pushNamed(HouseDetailed.routeName, arguments: {
      'id': id,
    });
  }

  @override
  Widget build(BuildContext context) {
    return houses.isNotEmpty
        ? ListView.builder(
            itemCount: houses.length,
            itemBuilder: (BuildContext context, int index) {
              return HouseDetailCard(
                house: houses[index],
                showInfoHandler: _showInfo,
              );
            },
          )
        : const Text('No houses found');
  }
}
