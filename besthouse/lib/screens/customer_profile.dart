import 'package:besthouse/models/response/info_response.dart';
import 'package:besthouse/screens/offer_form.dart';
import 'package:besthouse/services/api/user.dart';
import 'package:besthouse/services/share_preference.dart';
import 'package:besthouse/widgets/common/alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:uuid/uuid.dart';

//model
import 'package:besthouse/models/offer_card.dart';
import 'package:besthouse/models/user_profile.dart';

//widget
import 'package:besthouse/widgets/customer_profile/avatar_profile.dart';
import 'package:besthouse/widgets/customer_profile/offer_card.dart';
import 'package:besthouse/widgets/customer_profile/text_info.dart';

class CustomerProfile extends StatefulWidget {
  const CustomerProfile({Key? key}) : super(key: key);
  static const routeName = "/customer_profile";

  @override
  State<CustomerProfile> createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  String username = "";
  String firstname = "";
  String lastname = "";
  String email = "";
  String phoneNo = "";
  String lineId = "";
  String facebook = "";
  String userPicture =
      "https://i0.wp.com/shindekudasai.com/wp-content/uploads/2022/03/kaguya-sama.jpg";
  final List<OfferCardModel> offerList = [
    OfferCardModel(id: const Uuid().v1().toString(), isAvailable: true, name: "Diary Prachautid"),
    OfferCardModel(id: const Uuid().v1().toString(), isAvailable: false, name: "Chapter One"),
  ];
  bool isLoading = false;

  void getProfileHandler() async {
    try {
      var result = await UserApi.getUser();
      if (result is InfoResponse) {
        setState(() {
          username = result.data['user']['username'];
          firstname = result.data['profile']['firstname'];
          lastname = result.data['profile']['lastname'];
          email = result.data['user']['email'];
          phoneNo = result.data['user']['tel'];
          facebook = result.data['profile']['facebook'] ?? "";
          lineId = result.data['profile']['line_id'] ?? "";
        });
      }
    } on DioError catch (e) {
      Alert.errorAlert(e, context);
    }
  }

  void updateProfileHandler(String type, String value) async {
    setState(() {
      switch (type) {
        case "Username":
          username = value;
          break;
        case "Firstname":
          firstname = value;
          break;
        case "Lastname":
          lastname = value;
          break;
        case "Phone No.":
          phoneNo = value;
          break;
        case "Line Id":
          lineId = value;
          break;
        case "Facebook":
          facebook = value;
          break;
        default:
      }
    });
    try {
      await UserApi.updateUser(username, firstname, lastname, phoneNo, lineId, facebook);
    } on DioError catch (e) {
      Alert.errorAlert(e, context);
    }
  }

  @override
  void initState() {
    getProfileHandler();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<UserProfileCard> infoList = [
      UserProfileCard("Username", username, true),
      UserProfileCard("Firstname", firstname, true),
      UserProfileCard("Lastname", lastname, true),
      UserProfileCard("Email", email, false),
      UserProfileCard("Phone No.", phoneNo, true),
      UserProfileCard("Line Id", lineId, true),
      UserProfileCard("Facebook", facebook, true),
    ];
    return Container(
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
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Your Profile", style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
          AvatarProfile(userPicture: userPicture, isEditable: true),
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
                                color: const Color(0xff24577a).withOpacity(0.5),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text("Created offer", style: Theme.of(context).textTheme.headline2),
                            ],
                          ),
                          IconButton(
                            splashRadius: 20,
                            icon: Icon(
                              Icons.add,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, OfferForm.routeName);
                            },
                          ),
                        ],
                      ),
                      ...offerList
                          .map((e) => OfferCard(
                                name: e.name,
                                isAvailable: e.isAvailable,
                                isEditable: true,
                                key: Key(e.id),
                              ))
                          .toList(),
                      ...infoList.map((e) => TextInfo(
                            label: e.label,
                            value: e.value,
                            isEditable: e.isEditable,
                            updateProfileHandler: updateProfileHandler,
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isLoading = true;
                            });
                            Future.delayed(const Duration(seconds: 1), (() {
                              isLoading = false;
                              SharePreference.prefs.remove("token");
                              Navigator.pop(context);
                            }));
                          },
                          style: ElevatedButton.styleFrom(primary: const Color(0xffB30000)),
                          child: isLoading
                              ? const SpinKitRing(
                                  lineWidth: 2,
                                  color: Colors.white,
                                  size: 20.0,
                                )
                              : Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
                                  Icon(Icons.logout),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Sign out",
                                    textAlign: TextAlign.center,
                                  )
                                ]))
                    ],
                  ),
                ),
                width: MediaQuery.of(context).size.width),
            color: Colors.white,
          ))
        ],
      ),
    );
  }
}
