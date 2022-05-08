import 'package:besthouse/services/provider/house_lists.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
// services
import '../services/api/search.dart';
import '../services/constants.dart';
import '../services/provider/location.dart';
// screens
import 'house_detailed.dart';
import 'google_location.dart';
// widgets
import '../widgets/common/alert.dart';
import '../widgets/common/tag.dart';
import '../widgets/common/house_detail_card.dart';
import '../widgets/search/filter_sheet.dart';
// models
import '../models/response/info_response.dart';
import '../models/accommodation.dart';
import '../models/facilities.dart';
import '../models/house.dart';

class Search extends StatefulWidget {
  static const routeName = "/search";

  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  RangeValues currentRangeValues = const RangeValues(0, 20000);

  List<AccommodationObject> radioList = [
    AccommodationObject("All", Accommodation.all),
    AccommodationObject("House", Accommodation.house),
    AccommodationObject("Condominium", Accommodation.condominium),
    AccommodationObject("Hotel", Accommodation.hotel),
  ];
  Accommodation type = Accommodation.all;

  List<Facilities> checkboxList = [
    Facilities("Wifi", false),
    Facilities("Parking", false),
    Facilities("Aircondition", false),
    Facilities("Water heater", false),
    Facilities("Fitness", false),
    Facilities("Swimming pool", false),
    Facilities("Fan", false),
    Facilities("Furnishes", false),
  ];

  List<String> get selectedFacilities {
    var list = checkboxList.where((element) => element.checked);
    var result = list.map((e) => e.name);
    return result.toList();
  }

  void _filter() async {
    Provider.of<SearchList>(context, listen: false).changeLoadState(true);

    Map<String, dynamic> reqJson = {};

    reqJson["lat"] = Provider.of<DesireLocation>(context, listen: false).latitude;
    reqJson["long"] = Provider.of<DesireLocation>(context, listen: false).longitude;
    if (type != Accommodation.all) {
      reqJson["type"] = type.name.toUpperCase();
    }
    if (selectedFacilities.isNotEmpty) {
      reqJson["facilities"] = selectedFacilities;
    }
    reqJson["price_low"] = currentRangeValues.start;
    reqJson["price_high"] = currentRangeValues.end;

    _fetchHouses(reqJson);
  }

  Future<void> _fetchHouses(Map<String, dynamic> reqJson) async {
    Provider.of<SearchList>(context, listen: false).changeLoadState(true);
    print('fetch houses: $reqJson');

    try {
      var result = await SearchApi.search(reqJson);

      if (result is InfoResponse) {
        print(result.data);
        Provider.of<SearchList>(context, listen: false)
            .updateList([...result.data.map((house) => House.fromJson(house))]);
        Provider.of<SearchList>(context, listen: false).changeLoadState(false);
      }
    } on DioError catch (e) {
      Alert.errorAlert(e, context).then(
        (_) => setState(() {
          Provider.of<SearchList>(context, listen: false).changeLoadState(false);
        }),
      );
    }
  }

  @override
  void initState() {
    print('init');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition location;
    if (Provider.of<DesireLocation>(context).isExist) {
      location = context.watch<DesireLocation>().location;
    } else {
      location = context.watch<CurrentLocation>().currentLocation;
    }

    return location.target.latitude == 100
        ? const SpinKitRing(
            color: Color(0xFF24577A),
            size: 50.0,
          )
        : Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      GoogleLocation.routeName,
                    ).then((_) {
                      print('search');
                      _filter();
                    });
                  },
                  child: Image.network(
                    "https://maps.googleapis.com/maps/api/staticmap?center=${location.target.latitude},${location.target.longitude}&zoom=17&size=${MediaQuery.of(context).size.width.toInt()}x200&key=${Constants.apiKey}",
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 9.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 60,
                        height: 40,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: selectedFacilities.length + 1,
                          itemBuilder: (BuildContext context, int index) {
                            return Tag(
                              title: index == 0
                                  ? radioList.firstWhere((e) => e.type == type).name
                                  : selectedFacilities[index - 1],
                            );
                          },
                        ),
                      ),
                      Ink(
                        width: 40,
                        height: 40,
                        decoration: ShapeDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          shape: const CircleBorder(),
                        ),
                        child: IconButton(
                          splashRadius: 20,
                          iconSize: 20,
                          icon: Icon(Icons.filter_list,
                              color: Theme.of(context).colorScheme.secondary),
                          onPressed: () {
                            _buildModal(context);
                          },
                          tooltip: 'Filter',
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Divider(
                    indent: 12,
                    endIndent: 12,
                    color: Colors.grey,
                  ),
                ),
                Provider.of<SearchList>(context, listen: true).isLoading
                    ? const Expanded(child: SpinKitRing(color: Color(0xFF24577A), size: 50.0))
                    : Provider.of<SearchList>(context, listen: true).houses.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                              itemCount:
                                  Provider.of<SearchList>(context, listen: true).houses.length,
                              itemBuilder: (BuildContext context, int index) {
                                return HouseDetailCard(
                                  house:
                                      Provider.of<SearchList>(context, listen: true).houses[index],
                                  showInfoHandler: _showInfo,
                                );
                              },
                            ),
                          )
                        : const Text(
                            'No house found',
                            style: TextStyle(color: Colors.grey),
                          ),
              ],
            ),
          );
  }

  void _showInfo(String id) {
    Navigator.of(context).pushNamed(HouseDetailed.routeName, arguments: {
      'id': id,
    });
  }

  void _buildModal(BuildContext ctx) {
    showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        context: ctx,
        builder: (_) {
          return FilterSheet(
            currentRangeValues: currentRangeValues,
            radioList: radioList,
            type: type,
            checkboxList: checkboxList,
            filterHandler: (RangeValues range, Accommodation t, List<Facilities> facilities) {
              setState(() {
                currentRangeValues = range;
                type = t;
                checkboxList = facilities;
              });
              _filter();
            },
          );
        });
  }
}
