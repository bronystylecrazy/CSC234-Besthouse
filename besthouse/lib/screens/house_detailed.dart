import 'package:besthouse/screens/land_lord_profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';

//model
import 'package:besthouse/models/house.dart';
import 'package:besthouse/models/house_detail.dart';
import 'package:besthouse/models/user_profile.dart';
import 'package:besthouse/models/room.dart';

//widget
import '../models/location.dart';
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
  @override
  Widget build(BuildContext context) {
    final routeArgs = (ModalRoute.of(context)?.settings.arguments ?? <String, String>{"id": "0"})
        as Map<String, String>;
    final houseId = routeArgs['id'];

    final house = House(
      id: houseId ?? "0",
      name: "Flutter Condo",
      location: Location(coordinates: <double>[1.0, 1.0]),
      pictureUrl: "https://i.imgur.com/DvpvklR.png",
      price: 1000000,
      address: "123 Fake Street",
      tags: ["Hello", "World", "Flutter", "Condo", "House", "Flutter", "Condo", "House"],
      detail: HouseDetail(
        houseId: "0",
        userId: "0",
        rooms: [
          Room(type: "bath", amount: 2, pictures: [
            "https://images.theconversation.com/files/377569/original/file-20210107-17-q20ja9.jpg?ixlib=rb-1.1.0&rect=108%2C502%2C5038%2C2519&q=45&auto=format&w=1356&h=668&fit=crop",
            "https://images.theconversation.com/files/377569/original/file-20210107-17-q20ja9.jpg?ixlib=rb-1.1.0&rect=108%2C502%2C5038%2C2519&q=45&auto=format&w=1356&h=668&fit=crop",
            "https://images.theconversation.com/files/377569/original/file-20210107-17-q20ja9.jpg?ixlib=rb-1.1.0&rect=108%2C502%2C5038%2C2519&q=45&auto=format&w=1356&h=668&fit=crop",
          ]),
          Room(type: "living", amount: 3, pictures: [
            "https://i.imgur.com/DvpvklR.png",
            "https://i.imgur.com/DvpvklR.png",
            "https://i.imgur.com/DvpvklR.png",
          ]),
          Room(type: "kitchen", amount: 1, pictures: [
            "https://i.imgur.com/DvpvklR.png",
            "https://i.imgur.com/DvpvklR.png",
            "https://i.imgur.com/DvpvklR.png",
          ]),
        ],
        facilities: ["wifi", "parking", "air", "fitness", "water", "furnished", "pool"],
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        electricFee: 0,
        likes: 1200,
        totalSize: 33,
      ),
    );

    final landlord = UserProfile(
      firstname: "Flutter Condo",
      lastname: "Landlord",
    );

    final List<House> housesRec = [
      House(
        id: "634gf3438",
        name: "Spy Home",
        pictureUrl:
            "https://images.theconversation.com/files/377569/original/file-20210107-17-q20ja9.jpg?ixlib=rb-1.1.0&rect=108%2C502%2C5038%2C2519&q=45&auto=format&w=1356&h=668&fit=crop",
        price: 4000,
        location: Location(
          coordinates: [-6.2108, 106.8451],
        ),
        address: 'Soi 45 Prachauthid Thungkru, Bangkok',
        type: 'CONDOMINIUM',
      ),
      House(
        id: "634gf3438",
        name: "Willy House",
        pictureUrl:
            "https://images.theconversation.com/files/377569/original/file-20210107-17-q20ja9.jpg?ixlib=rb-1.1.0&rect=108%2C502%2C5038%2C2519&q=45&auto=format&w=1356&h=668&fit=crop",
        price: 6000,
        location: Location(
          coordinates: [13.2108, 107.8451],
        ),
        address: 'KMUTT university Prachauthid Thungkru, Bangkok',
      ),
      House(
        id: "634gf3438",
        name: "Jannie House",
        pictureUrl:
            "https://images.theconversation.com/files/377569/original/file-20210107-17-q20ja9.jpg?ixlib=rb-1.1.0&rect=108%2C502%2C5038%2C2519&q=45&auto=format&w=1356&h=668&fit=crop",
        price: 6000,
        location: Location(
          coordinates: [13.2108, 107.8451],
        ),
        address: 'KMUTT university Prachauthid Thungkru, Bangkok',
      ),
    ];

    final houseDetail = house.detail;
    int living = 0;
    int kitchen = 0;
    int bath = 0;
    int bed = 0;
    int total = 0;
    for (var i = 0; i < houseDetail!.rooms.length; i++) {
      if (houseDetail.rooms[i].type == "living") {
        living = houseDetail.rooms[i].amount;
      } else if (houseDetail.rooms[i].type == "kitchen") {
        kitchen = houseDetail.rooms[i].amount;
      } else if (houseDetail.rooms[i].type == "bath") {
        bath = houseDetail.rooms[i].amount;
      } else if (houseDetail.rooms[i].type == "bed") {
        bed = houseDetail.rooms[i].amount;
      }
    }
    total = living + kitchen + bath + bed;

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
                        circleColor:
                            const CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
                        bubblesColor: const BubblesColor(
                          dotPrimaryColor: Color(0xff33b5e5),
                          dotSecondaryColor: Color(0xff0099cc),
                        ),
                        likeBuilder: (bool isLiked) {
                          return Icon(
                            Icons.thumb_up,
                            color: isLiked ? const Color(0xFF24577A) : Colors.grey,
                            size: buttonSize,
                          );
                        },
                        likeCount: 665,
                        countBuilder: onCount,
                      ),
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
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                    child: Text(
                      houseDetail?.description ?? "No description",
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
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                    child: Column(
                      children: [
                        _buildDetail(context, "Total Space", houseDetail.totalSize.toString()),
                        _buildDetail(context, "Rooms", total.toString()),
                        Row(
                          children: [
                            _buildDetail(context, "Living romm", living.toString()),
                            const SizedBox(
                              width: 10,
                            ),
                            _buildDetail(context, "Bedroom", bed.toString()),
                          ],
                        ),
                        Row(
                          children: [
                            _buildDetail(context, "Bathroom", bath.toString()),
                            const SizedBox(
                              width: 10,
                            ),
                            _buildDetail(context, "Kitchen", kitchen.toString()),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, bottom: 8),
                    child: Text("Additional pictures :",
                        textAlign: TextAlign.left, style: Theme.of(context).textTheme.headline4),
                  ),
                  SizedBox(
                    height: 200,
                    child: RoomImage(houseDetail: house.detail),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                    child: Column(
                      children: [
                        _buildDetail(
                          context,
                          "Furniture",
                          houseDetail.facilities.any((e) => e.compareTo("funished") == 0)
                              ? "provided"
                              : "No",
                        ),
                        _buildDetail(
                          context,
                          "Fiber internet",
                          houseDetail.facilities.any((e) => e.compareTo("wifi") == 0)
                              ? "provided"
                              : "No",
                        ),
                        _buildDetail(
                          context,
                          "Water heater",
                          houseDetail.facilities.any((e) => e.compareTo("water") == 0)
                              ? "provided"
                              : "No",
                        ),
                        _buildDetail(
                          context,
                          "Air condition",
                          houseDetail.facilities.any((e) => e.compareTo("air") == 0)
                              ? "provided"
                              : "No",
                        ),
                        _buildDetail(
                          context,
                          "Fan",
                          houseDetail.facilities.any((e) => e.compareTo("Fan") == 0)
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
                          _showUser(houseDetail.userId.toString());
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
