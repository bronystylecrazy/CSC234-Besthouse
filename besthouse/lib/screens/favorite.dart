import 'package:besthouse/services/api/favorite.dart';
import 'package:besthouse/widgets/common/button.dart';
import 'package:flutter/material.dart';
import 'package:besthouse/widgets/common/alert.dart';
import 'package:besthouse/models/response/info_response.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

//model
import '../models/house.dart';
import '../models/location.dart';
// screens
import '../screens/house_detailed.dart';
//widget
import '../widgets/common/house_detail_card.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);
  static const routeName = "/favorite";

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  bool isLoading = false;

  List<House> houses = [
    // House(
    //   id: "634gf3438",
    //   name: "Cosmo Home",
    //   pictureUrl:
    //       "https://images.theconversation.com/files/377569/original/file-20210107-17-q20ja9.jpg?ixlib=rb-1.1.0&rect=108%2C502%2C5038%2C2519&q=45&auto=format&w=1356&h=668&fit=crop",
    //   price: 4000,
    //   location: Location(
    //     coordinates: [-6.2108, 106.8451],
    //   ),
    //   address: 'Soi 45 Prachauthid Thungkru, Bangkok',
    //   type: 'CONDOMINIUM',
    // ),
    // House(
    //   id: "634gf3438",
    //   name: "Heliconia House",
    //   pictureUrl:
    //       "https://images.theconversation.com/files/377569/original/file-20210107-17-q20ja9.jpg?ixlib=rb-1.1.0&rect=108%2C502%2C5038%2C2519&q=45&auto=format&w=1356&h=668&fit=crop",
    //   price: 6000,
    //   location: Location(
    //     coordinates: [13.2108, 107.8451],
    //   ),
    //   address: 'KMUTT university Prachauthid Thungkru, Bangkok',
    // ),
    // House(
    //   id: "634gf3438",
    //   name: "Cosmo Home",
    //   pictureUrl:
    //       "https://images.theconversation.com/files/377569/original/file-20210107-17-q20ja9.jpg?ixlib=rb-1.1.0&rect=108%2C502%2C5038%2C2519&q=45&auto=format&w=1356&h=668&fit=crop",
    //   price: 4000,
    //   location: Location(
    //     coordinates: [-6.2108, 106.8451],
    //   ),
    //   address: 'Soi 45 Prachauthid Thungkru, Bangkok',
    //   type: 'CONDOMINIUM',
    // ),
    // House(
    //   id: "634gf3438",
    //   name: "Heliconia House",
    //   pictureUrl:
    //       "https://images.theconversation.com/files/377569/original/file-20210107-17-q20ja9.jpg?ixlib=rb-1.1.0&rect=108%2C502%2C5038%2C2519&q=45&auto=format&w=1356&h=668&fit=crop",
    //   price: 6000,
    //   location: Location(
    //     coordinates: [13.2108, 107.8451],
    //   ),
    //   address: 'KMUTT university Prachauthid Thungkru, Bangkok',
    // ),
  ];

  void _favoriteHandler() async {
    try {
      var result = await FavoriteApi.getFavoriteHouseList();

      if (result is InfoResponse) {
        List<dynamic> housesList = result.data;
        for (var e in housesList) {
          setState(() {
            houses.add(House.fromJson(e));
          });
          }
        }
        // var temp = housesList
        //     .map(
        //       (e) => House(
        //         id: e['_id'],
        //         name: e['name'],
        //         pictureUrl: e['picture_url'],
        //         price: e['price'],
        //         address: e['address'],
        //         location: Location(coordinates: [
        //           e['location']['coordinates'][1],
        //           e['location']['coordinates'][0]
        //         ]),
        //       ),
        //     )
        //     .toList();
        // setState(() {
        //   Future.delayed(const Duration(seconds: 0), () {
        //     setState(() {
        //       houses = temp;
        //     });
        //   });
        // });
      
    } on DioError catch (e) {
      setState(() {
        isLoading = false;
      });
      Alert.errorAlert(e, context);
    }
  }

  @override
  void initState() {
    if (mounted) {
      _favoriteHandler();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Favorite",
                  style: Theme.of(context).textTheme.headline1,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  Icons.thumb_up,
                  color: Color.fromRGBO(84, 156, 169, 100),
                  size: 30,
                ),
              ],
            ),
            houses.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: houses.length,
                      itemBuilder: (BuildContext context, int index) {
                        return HouseDetailCard(
                          house: houses[index],
                          showInfoHandler: _showInfo,
                        );
                      },
                    ),
                  )
                : const Text('No houses found'),
          ],
        ),
      ),
    );
  }

  void _showInfo(String id) {
    Navigator.of(context).pushNamed(HouseDetailed.routeName, arguments: {
      'id': id,
    });
  }
}
