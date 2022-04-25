import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';

//model
import 'package:besthouse/models/house.dart';
import 'package:besthouse/models/house_detail.dart';
import 'package:besthouse/models/facilities.dart';
import 'package:besthouse/models/room.dart';

//widget
import '../widgets/common/tag.dart';

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
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;
  double buttonSize = 20;
  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final routeArgs = (ModalRoute.of(context)?.settings.arguments ??
        <String, String>{"id": "0"}) as Map<String, String>;
    final houseId = routeArgs['id'];

    final houseDetail = HouseDetail(
      houseId: "0",
      userId: "0",
      rooms: [
        Room(
            type: "Bathroom",
            numbers: 2,
            pictures: ["https://i.imgur.com/DvpvklR.png"]),
        Room(
            type: "Living room",
            numbers: 0,
            pictures: ["https://i.imgur.com/DvpvklR.png"]),
        Room(
            type: "kitchen",
            numbers: 1,
            pictures: ["https://i.imgur.com/DvpvklR.png"]),
      ],
      facilities: [Facilities("aaa", true), Facilities("name", false)],
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      electricFee: 0,
      likes: 1200,
      totalSize: 33,
    );

    final house = House(
      id: houseId ?? "0",
      name: "Flutter Condo",
      location: Location(coordinates: <double>[1.0, 1.0]),
      pictureUrl: "https://i.imgur.com/DvpvklR.png",
      price: 1000000,
      address: "123 Fake Street",
      tags: [
        "Hello",
        "World",
        "Flutter",
        "Condo",
        "House",
        "Flutter",
        "Condo",
        "House"
      ],
      detail: houseDetail,
    );

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
                        likeBuilder: (bool isLiked) {
                          return Icon(
                            Icons.thumb_up,
                            color:
                                isLiked ? const Color(0xFF24577A) : Colors.grey,
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
                    width: MediaQuery.of(context).size.width - 60,
                    height: 20,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: house.tags.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Tag(title: house.tags[index]),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Description",
                    style: Theme.of(context).textTheme.headline5?.apply(
                          fontSizeFactor: 0.9,
                          fontSizeDelta: 0.0,
                        ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    house.detail?.description ?? "No describetion",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Details",
                    style: Theme.of(context).textTheme.headline5?.apply(
                          fontSizeFactor: 0.9,
                          fontSizeDelta: 0.0,
                        ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Total Space: ",
                        style: Theme.of(context).textTheme.headline5?.apply(
                              fontSizeFactor: 0.8,
                              fontSizeDelta: 0.0,
                            ),
                      ),
                      Text(
                        house.detail?.totalSize.toString() ?? "0",
                      )
                    ],
                  ),

                  Row(
                    children: [
                      Text(
                        "Electric Fee: ",
                        style: Theme.of(context).textTheme.headline5?.apply(
                              fontSizeFactor: 0.8,
                              fontSizeDelta: 0.0,
                            ),
                      ),
                      Text(
                        house.detail?.electricFee.toString() ?? "0",
                      )
                    ],
                  ),

                  // SliverList(
                  //     Container(
                  //       width: 160.0,
                  //       color: Colors.red,
                  //     ),
                  //     Container(
                  //       width: 160.0,
                  //       color: Colors.blue,
                  //     ),
                  //     Container(
                  //       width: 160.0,
                  //       color: Colors.green,
                  //     ),
                  //     Container(
                  //       width: 160.0,
                  //       color: Colors.yellow,
                  //     ),
                  //     Container(
                  //       width: 160.0,
                  //       color: Colors.orange,
                  //     ),
                  //   ],
                  // ),
                  // ListView.builder(
                  //   //scrollDirection: Axis.horizontal,
                  //   itemCount: house.tags.length,
                  //   itemBuilder: (context, index) {
                  //     return Container(
                  //       width: 40,
                  //       child: OutlinedButton(
                  //         onPressed: () {},
                  //         child: Text(house.tags[index]),
                  //         // style: ButtonStyle(
                  //         //   minimumSize: MaterialStateProperty.all<Size>(
                  //         //     const Size(40, 40),
                  //         //   ),
                  //         // ),
                  //       ),
                  //     );
                  //   },
                  // ),
                  // ListView(
                  //   controller: scrollController,
                  //   shrinkWrap: true,
                  //   physics: const NeverScrollableScrollPhysics(),
                  //   scrollDirection: Axis.horizontal,
                  //   children: [
                  //     Column(
                  //       children: house.tags.map((tag) {
                  //         return OutlinedButton(
                  //           onPressed: () {},
                  //           child: Text(tag),
                  //         );
                  //       }).toList(),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
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
}
