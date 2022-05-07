import 'package:besthouse/screens/land_lord_profile.dart';
import 'package:besthouse/widgets/common/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:besthouse/services/api/favorite.dart';
import 'package:besthouse/widgets/common/alert.dart';
import 'package:besthouse/models/response/info_response.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import '../services/api/offer_form.dart';

//model
import 'package:besthouse/models/house.dart';
import 'package:besthouse/models/house_detail.dart';
import 'package:besthouse/models/user_profile.dart';
import 'package:besthouse/models/room.dart';

//widget
import '../models/location.dart';
import '../services/api/search.dart';
import '../services/api/user.dart';
import '../services/provider/offer.dart';
import '../widgets/common/tag.dart';
import '../widgets/house_detail/room_image.dart';
import '../widgets/home/house_card.dart';

// class HouseDetailed0 extends StatelessWidget {
//   const HouseDetailed0({Key? key}) : super(key: key);
// }

class HouseDetailed extends StatefulWidget {
  const HouseDetailed({Key? key}) : super(key: key);
  static const routeName = "/house";
  @override
  State<HouseDetailed> createState() => _HouseDetailedState();
}

class _HouseDetailedState extends State<HouseDetailed> {
  final bool _pinned = true;
  final bool _snap = false;
  final bool _floating = false;
  double buttonSize = 20;
  final scrollController = ScrollController();

  House house = House(
      id: "0",
      name: "Sorry About This Page",
      pictureUrl: "https://i.imgur.com/DvpvklR.png",
      price: 999999999,
      address: "Moon",
      location: Location(coordinates: <double>[1.0, 1.0]),
      detail: HouseDetail(
          houseId: "0",
          userId: "0",
          description: "Sorry About This Page. Please refresh page.",
          rooms: [Room(type: "living", amount: 999, pictures: [])],
          facilities: []));

  UserProfile landlord = UserProfile(
    firstname: "Flutter Condo",
    lastname: "Landlord",
  );

  List<House> housesRec = [
    // House(
    //   id: "634gf3438",
    //   name: "Spy Home",
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
    //   name: "Willy House",
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
    //   name: "Jannie House",
    //   pictureUrl:
    //       "https://images.theconversation.com/files/377569/original/file-20210107-17-q20ja9.jpg?ixlib=rb-1.1.0&rect=108%2C502%2C5038%2C2519&q=45&auto=format&w=1356&h=668&fit=crop",
    //   price: 6000,
    //   location: Location(
    //     coordinates: [13.2108, 107.8451],
    //   ),
    //   address: 'KMUTT university Prachauthid Thungkru, Bangkok',
    // ),
  ];

  bool isLoading = false;

  List favorites = [];
  bool success = false;
  bool isLiked = false;

  void getDetailHandler(String houseId) async {
    try {
      var result = await OfferFormApi.getOfferInfo(houseId);

      if (result is InfoResponse) {
        var offers = result.data;
        print(offers);
        _favoriteHandler();
        print(favorites);
        isLiked = favorites.contains(houseId);
        for (var e in offers) {
          setState(() {
            house = House.fromJson(e);
          });
        }

        // List<String> pictures = [];
        // List<Room> rooms = [];
        // for (int i = 0; i < offers['houseDetail']['rooms']?.length; i++) {
        //   for (int j = 0;
        //       j < offers['houseDetail']['rooms'][i]['pictures']?.length;
        //       j++) {
        //     pictures.add(
        //         offers['houseDetail']['rooms'][i]['pictures'][j].toString());
        //   }
        //   rooms.add(Room(
        //       type: offers['houseDetail']['rooms'][i]['type'],
        //       amount: offers['houseDetail']['rooms'][i]['amount'],
        //       pictures: pictures));
        // }
        // var temp = House(
        //   id: offers['house']['_id'],
        //   name: offers['house']['name'],
        //   pictureUrl: offers['house']['picture_url'],
        //   price: offers['house']['price'],
        //   address: offers['house']['address'],
        //   location: Location(coordinates: [
        //     offers['house']['location']['coordinates'][0],
        //     offers['house']['location']['coordinates'][1]
        //   ]),
        //   type: offers['house']['type'],
        //   tags: offers['tags'] ?? [],
        //   detail: HouseDetail(
        //     houseId: offers['houseDetail']['house_id'],
        //     userId: offers['houseDetail']['user_id'],
        //     rooms: rooms,
        //     facilities: offers['houseDetail']['facilities']
        //         .toString()
        //         .split(',')
        //         .toList(),
        //     description: offers['houseDetail']['description'],
        //     electricFee: offers['houseDetail']['electric_fee'] ?? 0,
        //     waterFee: offers['houseDetail']['water_fee'] ?? 0,
        //     likes: offers['houseDetail']['likes'],
        //     totalSize: offers['houseDetail']['total_size'] + 0.0 ?? 0,
        //   ),
        // );
        // setState(() {
        //   Future.delayed(const Duration(seconds: 1), () {
        //     setState(() {
        //       _favoriteHandler();
        //       print(favorites);
        //       isLiked = favorites.contains(houseId);
        //       print(isLiked);
        //       isLoading = false;
        //       house = temp;
        //     });
        //   });
        // });
        // // house = temp;
        // Alert.successAlert(
        //   result,
        //   'Success',
        //   () => Navigator.of(context).pop(),
        //   context,
        // );
      }
    } on DioError catch (e) {
      Alert.errorAlert(e, context);
    }
  }

  Future<bool> onLikeButtonTapped(bool isLiked, String houseId) async {
    try {
      var result = await FavoriteApi.addFavoriteHouse(houseId.toString());

      if (result is InfoResponse) {
        success = true;
        // print(success);
        return success ? !isLiked : isLiked;
      }
    } on DioError catch (e) {
      Alert.errorAlert(e, context);
    }
    return !isLiked;
  }

  void _favoriteHandler() async {
    try {
      var result = await FavoriteApi.getFavoriteHouseList();

      if (result is InfoResponse) {
        List<dynamic> housesList = result.data;
        var temp = housesList
            .map(
              (e) => e['_id'],
            )
            .toList();
        setState(() {
          Future.delayed(const Duration(seconds: 0), () {
            setState(() {
              favorites = temp;
              //isLiked = favorites.contains(house.id);
            });
          });
        });
      }
    } on DioError catch (e) {
      setState(() {
        isLoading = false;
      });
      Alert.errorAlert(e, context);
    }
  }

  void getNearby() async {
    try {
      var result = await SearchApi.getHousesList(
          house.location.coordinates[0], house.location.coordinates[1]);
      if (result is InfoResponse) {
        List<dynamic> houses = result.data;
        print(houses);
        for (var e in houses) {
          setState(() {
            housesRec.add(House.fromJson(e));
          });
        }
        // var temp = houses
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
        //       housesRec = temp;
        //     });
        //   });
        // });
        // Alert.successAlert(
        //   result,
        //   'Success',
        //   () => Navigator.of(context).pop(),
        //   context,
        // );
      }
    } on DioError catch (e) {
      Alert.errorAlert(e, context);
    }
  }

  @override
  void initState() {
    _favoriteHandler();
    getDetailHandler(
        Provider.of<OfferFormProvider>(context, listen: false).houseId);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs = (ModalRoute.of(context)?.settings.arguments ??
        <String, String>{"id": "0"}) as Map<String, String>;
    final houseId = routeArgs['id'];

    isLiked = favorites.contains(house.id);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(),
      ),
      body: CustomScrollView(
        controller: scrollController,
        slivers: <Widget>[
          SliverAppBar(
            pinned: _pinned,
            snap: _snap,
            floating: _floating,
            toolbarHeight: 0,
            flexibleSpace: const FlexibleSpaceBar(
              background: FlutterLogo(),
            ),
            expandedHeight: 200,
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              house.name,
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            Text(
                              house.address,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                      ),
                      LikeButton(
                        size: buttonSize,
                        circleColor: const CircleColor(
                            start: Color(0xff00ddff), end: Color(0xff0099cc)),
                        bubblesColor: const BubblesColor(
                          dotPrimaryColor: Color(0xff33b5e5),
                          dotSecondaryColor: Color(0xff0099cc),
                        ),
                        likeBuilder: (isLiked) {
                          print(isLiked);
                          return Icon(
                            Icons.thumb_up,
                            color:
                                isLiked ? const Color(0xFF24577A) : Colors.grey,
                            size: buttonSize,
                          );
                        },
                        likeCount: house.detail!.likes,
                        countBuilder: onCount,
                        onTap: (isLiked) {
                          return onLikeButtonTapped(
                              isLiked, houseId.toString());
                        },
                      ),
                      // Button(text: 'text', clickHandler: getDetailHandler),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    calculatePrice(house.price),
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 20,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: house.tags.length,
                      itemBuilder: (context, index) {
                        return Tag(title: house.tags[index]);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Description",
                    style: Theme.of(context).textTheme.headline2?.apply(
                          fontSizeFactor: 0.9,
                          fontSizeDelta: 0.9,
                        ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16),
                    child: Text(
                      house.detail!.description,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Details",
                    style: Theme.of(context).textTheme.headline2?.apply(
                          fontSizeFactor: 0.9,
                          fontSizeDelta: 0.9,
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8),
                    child: Column(
                      children: [
                        _buildDetail(context, "Total Space",
                            house.detail!.totalSize.toString()),
                        _buildDetail(
                          context,
                          "Rooms",
                          house.detail?.rooms.length == 1
                              ? house.detail!.rooms[0].amount.toString()
                              : house.detail?.rooms.length == 2
                                  ? (house.detail!.rooms[0].amount +
                                          house.detail!.rooms[1].amount)
                                      .toString()
                                  : house.detail?.rooms.length == 3
                                      ? (house.detail!.rooms[0].amount +
                                              house.detail!.rooms[1].amount +
                                              house.detail!.rooms[2].amount)
                                          .toString()
                                      : house.detail?.rooms.length == 4
                                          ? (house.detail!.rooms[0].amount +
                                                  house
                                                      .detail!.rooms[1].amount +
                                                  house
                                                      .detail!.rooms[2].amount +
                                                  house.detail!.rooms[3].amount)
                                              .toString()
                                          : "0",
                        ),
                        Row(
                          children: [
                            _buildDetail(
                              context,
                              "Living romm",
                              house.detail!.rooms.isNotEmpty &&
                                      house.detail!.rooms[0].type.toString() ==
                                          "LIVING ROOM"
                                  ? house.detail!.rooms[0].amount.toString()
                                  : house.detail!.rooms.length >= 2 &&
                                          house.detail!.rooms[1].type
                                                  .toString() ==
                                              "LIVING ROOM"
                                      ? house.detail!.rooms[1].amount.toString()
                                      : house.detail!.rooms.length >= 3 &&
                                              house.detail!.rooms[2].type
                                                      .toString() ==
                                                  "LIVING ROOM"
                                          ? house.detail!.rooms[2].amount
                                              .toString()
                                          : house.detail!.rooms.length == 4 &&
                                                  house.detail!.rooms[3].type
                                                          .toString() ==
                                                      "LIVING ROOM"
                                              ? house.detail!.rooms[3].amount
                                                  .toString()
                                              : "0",
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            _buildDetail(
                              context,
                              "Bedroom",
                              house.detail!.rooms.isNotEmpty &&
                                      house.detail!.rooms[0].type.toString() ==
                                          "BEDROOM"
                                  ? house.detail!.rooms[0].amount.toString()
                                  : house.detail!.rooms.length >= 2 &&
                                          house.detail!.rooms[1].type
                                                  .toString() ==
                                              "BEDROOM"
                                      ? house.detail!.rooms[1].amount.toString()
                                      : house.detail!.rooms.length >= 3 &&
                                              house.detail!.rooms[2].type
                                                      .toString() ==
                                                  "BEDROOM"
                                          ? house.detail!.rooms[2].amount
                                              .toString()
                                          : house.detail!.rooms.length == 4 &&
                                                  house.detail!.rooms[3].type
                                                          .toString() ==
                                                      "BEDROOM"
                                              ? house.detail!.rooms[3].amount
                                                  .toString()
                                              : "0",
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            _buildDetail(
                              context,
                              "Bathroom",
                              house.detail!.rooms.isNotEmpty &&
                                      house.detail!.rooms[0].type.toString() ==
                                          "BATHROOM"
                                  ? house.detail!.rooms[0].amount.toString()
                                  : house.detail!.rooms.length >= 2 &&
                                          house.detail!.rooms[1].type
                                                  .toString() ==
                                              "BATHROOM"
                                      ? house.detail!.rooms[1].amount.toString()
                                      : house.detail!.rooms.length >= 3 &&
                                              house.detail!.rooms[2].type
                                                      .toString() ==
                                                  "BATHROOM"
                                          ? house.detail!.rooms[2].amount
                                              .toString()
                                          : house.detail!.rooms.length == 4 &&
                                                  house.detail!.rooms[3].type
                                                          .toString() ==
                                                      "BATHROOM"
                                              ? house.detail!.rooms[3].amount
                                                  .toString()
                                              : "0",
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            _buildDetail(
                              context,
                              "Kitchen",
                              house.detail!.rooms.isNotEmpty &&
                                      house.detail!.rooms[0].type.toString() ==
                                          "KITCHEN"
                                  ? house.detail!.rooms[0].amount.toString()
                                  : house.detail!.rooms.length >= 2 &&
                                          house.detail!.rooms[1].type
                                                  .toString() ==
                                              "KITCHEN"
                                      ? house.detail!.rooms[1].amount.toString()
                                      : house.detail!.rooms.length >= 3 &&
                                              house.detail!.rooms[2].type
                                                      .toString() ==
                                                  "KITCHEN"
                                          ? house.detail!.rooms[2].amount
                                              .toString()
                                          : house.detail!.rooms.length == 4 &&
                                                  house.detail!.rooms[3].type
                                                          .toString() ==
                                                      "KITCHEN" &&
                                                  house.detail!.rooms.length ==
                                                      4
                                              ? house.detail!.rooms[3].amount
                                                  .toString()
                                              : "0",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, bottom: 8),
                    child: Text("Additional pictures :",
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.headline4),
                  ),
                  SizedBox(
                    height: 200,
                    child: RoomImage(houseDetail: house.detail),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8),
                    child: Column(
                      children: [
                        _buildDetail(
                          context,
                          "Furniture",
                          house.detail!.facilities
                                  .any((e) => e.compareTo("funished") == 0)
                              ? "provided"
                              : "No",
                        ),
                        _buildDetail(
                          context,
                          "Fiber internet",
                          house.detail!.facilities
                                  .any((e) => e.compareTo("wifi") == 0)
                              ? "provided"
                              : "No",
                        ),
                        _buildDetail(
                          context,
                          "Water heater",
                          house.detail!.facilities
                                  .any((e) => e.compareTo("water") == 0)
                              ? "provided"
                              : "No",
                        ),
                        _buildDetail(
                          context,
                          "Air condition",
                          house.detail!.facilities
                                  .any((e) => e.compareTo("air") == 0)
                              ? "provided"
                              : "No",
                        ),
                        _buildDetail(
                          context,
                          "Fan",
                          house.detail!.facilities
                                  .any((e) => e.compareTo("Fan") == 0)
                              ? "provided"
                              : "No",
                        ),
                        _buildDetail(
                          context,
                          "Electric Fee",
                          house.detail?.electricFee.toString() ?? "0",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (() {
                          _showUser(house.detail!.userId.toString());
                        }),
                        child: Row(
                          children: [
                            Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                    "https://i.imgur.com/DvpvklR.png",
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              landlord.firstname + "  " + landlord.lastname,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.phone,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Nearby Place",
                    style: Theme.of(context).textTheme.headline5?.apply(
                          fontSizeFactor: 0.9,
                          fontSizeDelta: 0.9,
                        ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  housesRec.isNotEmpty
                      ? SizedBox(
                          height: 150,
                          width: double.infinity,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: housesRec.length,
                            itemBuilder: (BuildContext context, int index) {
                              return HouseCard(
                                house: housesRec[index],
                                showInfoHandler: _showInfo,
                              );
                            },
                          ),
                        )
                      : const Text('No houses found'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetail(BuildContext context, String detail, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text("$detail : ", style: Theme.of(context).textTheme.headline4),
          Text(
            value,
            style: Theme.of(context).textTheme.subtitle1,
          )
        ],
      ),
    );
  }

  Widget? onCount(int? count, bool isLiked, String text) {
    var color = isLiked ? Colors.deepPurpleAccent : Colors.grey;
    Widget result;
    if (count == 0) {
      result = Text(
        "love",
        style: TextStyle(color: color),
      );
    } else {
      result = Text(
        text,
        style: TextStyle(color: color),
      );
    }
    return result;
  }

  String calculatePrice(int price) {
    return "${price.toString()} Baht/Month";
  }

  void _showInfo(String id) {
    Navigator.of(context).pushNamed(HouseDetailed.routeName, arguments: {
      'id': id,
    });
  }

  void _showUser(String id) {
    Navigator.of(context).pushNamed(LandLordProfile.routeName, arguments: {
      'id': id,
    });
  }
}
