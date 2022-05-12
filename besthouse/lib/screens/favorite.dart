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
  bool isLoading = true;

  List<House> houses = [];

  void _favoriteHandler() async {
    setState(() {
      isLoading = true;
    });
    try {
      var result = await FavoriteApi.getFavoriteHouseList();

      if (result is InfoResponse) {
        List<dynamic> housesList = result.data;
        var temp = [];
        for (var e in housesList) {
          temp.add(House.fromJson(e));
        }
        setState(() {
          houses = [...temp];
          isLoading = false;
        });
      }
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
            isLoading
                ? const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : (houses.isNotEmpty
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
                    : const Text('No houses found'))
          ],
        ),
      ),
    );
  }

  void _showInfo(String id) {
    Navigator.of(context).pushNamed(HouseDetailed.routeName, arguments: {
      'id': id,
    }).then((value) => _favoriteHandler());
  }
}
