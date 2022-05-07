import 'package:besthouse/models/response/info_response.dart';
import 'package:besthouse/screens/offer_form.dart';
import 'package:besthouse/services/api/offer_form.dart';
import 'package:besthouse/services/api/user.dart';
import 'package:besthouse/widgets/common/alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

//model
import 'package:besthouse/models/offer_card.dart';
import 'package:besthouse/models/user_profile.dart';

//widget
import 'package:besthouse/widgets/customer_profile/avatar_profile.dart';
import 'package:besthouse/widgets/customer_profile/offer_card.dart';
import 'package:besthouse/widgets/customer_profile/text_info.dart';

class LandLordProfile extends StatefulWidget {
  LandLordProfile({Key? key, this.args}) : super(key: key);

  final Map<String, dynamic>? args;

  static const String routeName = "/landlord-profile";

  @override
  State<LandLordProfile> createState() => _LandLordProfileState();
}

class _LandLordProfileState extends State<LandLordProfile> {
  late String username = "";
  late String name = "";
  late String email = "";
  late String phoneNo = "";
  late String lineId = "";
  late String facebook = "";
  late String userPicture = "";
  bool isLoading = true;

  List<OfferCardModel> offerList = [
    OfferCardModel(
        id: const Uuid().v4().toString(),
        isAvailable: true,
        name: "Diary Prachautid"),
    OfferCardModel(
        id: const Uuid().v1().toString(),
        isAvailable: true,
        name: "Chapter One"),
  ];

  Future<void> getProfile() async {
    var result = await UserApi.getUserById(widget.args!["id"]);
    if (result is InfoResponse) {
      setState(() {
        username = result.data['user']['username'];
        name = result.data['profile']['firstname'] +
            " " +
            result.data['profile']['lastname'];
        email = result.data['user']['email'];
        phoneNo = result.data['user']['tel'];
        lineId = result.data['profile']['line_id'];
        facebook = result.data['profile']['facebook'];
        userPicture = result.data['profile']['picture_url'];
      });
    }
  }

  Future<void> getOfferList() async {
    try {
      var result = await OfferFormApi.getOfferList();

      if (result is InfoResponse) {
        List<dynamic> offers = result.data;
        var temp = offers
            .map((e) => OfferCardModel(
                id: e['_id'], isAvailable: e['status'], name: e['name']))
            .toList();
        setState(() {
          setState(() {
            offerList = temp;
          });
        });
      }
    } on DioError catch (e) {
      Alert.errorAlert(e, context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    Future.wait([getProfile(), getOfferList()]).then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

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
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("$username Profile ",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                  AvatarProfile(
                    userPicture: userPicture,
                    isEditable: false,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Expanded(
                      child: Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30)),
                    ),
                    margin: EdgeInsets.zero,
                    child: Container(
                        padding: const EdgeInsets.all(20),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.home,
                                        size: 30,
                                        color: const Color(0xff24577a)
                                            .withOpacity(0.5),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text("$username's offer",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2),
                                    ],
                                  ),
                                ],
                              ),
                              ...offerList
                                  .map((e) => OfferCard(
                                        id: e.id,
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
