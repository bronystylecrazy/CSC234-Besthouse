import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

//model
import 'package:besthouse/models/offer.dart';
import 'package:besthouse/models/user_profile.dart';

//widget
import 'package:besthouse/widgets/customer_profile/avatar_profile.dart';
import 'package:besthouse/widgets/customer_profile/offer_card.dart';
import 'package:besthouse/widgets/customer_profile/text_info.dart';

class LandLordProfile extends StatelessWidget {
  LandLordProfile({Key? key}) : super(key: key);
  static const String routeName = "/landlord-profile";
  final String username = "Shirayuki_hime";
  final String name = "Shinomiya Kaguya";
  final String email = "kaguya@mail.com";
  final String phoneNo = "000-000-0000";
  final String lineId = "";
  final String facebook = "";
  final userPicture =
      "https://i0.wp.com/shindekudasai.com/wp-content/uploads/2022/03/kaguya-sama.jpg";
  final List<OfferCardModel> offerList = [
    OfferCardModel(
        id: const Uuid().v4().toString(),
        isAvailable: true,
        name: "Diary Prachautid"),
    OfferCardModel(
        id: const Uuid().v1().toString(),
        isAvailable: true,
        name: "Chapter One"),
  ];
  @override
  Widget build(BuildContext context) {
    List<UserProfileCard> infoList = [
      UserProfileCard("Username", username, false),
      UserProfileCard("Name", name, false),
      UserProfileCard("Email", email, false),
      UserProfileCard("Phone No.", phoneNo, false),
      UserProfileCard("Line Id", lineId, false),
      UserProfileCard("Facebook", facebook, false),
    ];
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xff173550),
                Color(0xff24577a),
              ],
            ),
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xff173550),
            Color(0xff24577a),
          ],
        )),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("$username Profile ",
                  style: const TextStyle(color: Colors.white, fontSize: 20)),
            ),
            AvatarProfile(userPicture: userPicture, isEditable: false),
            const SizedBox(
              height: 40,
            ),
            Expanded(
                child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              margin: EdgeInsets.zero,
              child: Container(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.home,
                                  size: 30,
                                  color:
                                      const Color(0xff24577a).withOpacity(0.5),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text("$username's offer",
                                    style:
                                        Theme.of(context).textTheme.headline2),
                              ],
                            ),
                          ],
                        ),
                        ...offerList
                            .map((e) => OfferCard(
                                  name: e.name,
                                  isAvailable: e.isAvailable,
                                  isEditable: false,
                                  key: Key(e.id),
                                ))
                            .toList(),
                        ...infoList.map((e) => TextInfo(
                            label: e.label,
                            value: e.value,
                            isEditable: e.isEditable))
                      ],
                    ),
                  ),
                  width: MediaQuery.of(context).size.width),
              color: Colors.white,
            ))
          ],
        ),
      ),
    );
  }
}
