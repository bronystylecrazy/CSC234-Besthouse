import 'dart:io';

import 'package:besthouse/services/dio.dart';
import 'package:besthouse/services/provider/offer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

//screen
import '../screens/offer_form.dart';

//service
import '../services/image_picker.dart';
import '../services/api/user.dart';
import '../services/api/offer_form.dart';
import '../services/share_preference.dart';

//model
import '../models/offer_card.dart';
import '../models/user_profile.dart';
import '../models/response/info_response.dart';

//widget
import '../widgets/common/alert.dart';
import '../widgets/customer_profile/avatar_profile.dart';
import '../widgets/customer_profile/offer_card.dart';
import '../widgets/customer_profile/text_info.dart';

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
  String userPicture = "";
  List<OfferCardModel> offerList = [];
  bool isLoading = true;
  bool isLogout = false;

  TextEditingController curController = TextEditingController();

  TextEditingController newController = TextEditingController();

  Future<void> getProfileHandler() async {
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
          userPicture = result.data['profile']['picture_url'] ?? "";
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
      await UserApi.updateUser(
          username, firstname, lastname, phoneNo, lineId, facebook);
    } on DioError catch (e) {
      Alert.errorAlert(e, context);
    }
  }

  void uploadPicture() async {
    final File? file = await ImagePickerService().getImageFromGallery();
    if (file != null) {
      Response<dynamic> exteriorPicture =
          await UserApi.uploadProfilePicture(file);
      setState(() {
        userPicture = exteriorPicture.data[0]['url'];
      });
    }
  }

  Future<void> getOfferHandler() async {
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

  void toggleOfferHandler(String id) async {
    try {
      var result = await OfferFormApi.toggleOffer(id);
      if (result is InfoResponse) {
        var temp = offerList.map((element) {
          if (element.id == id) {
            element.isAvailable = !element.isAvailable;
          }
          return element;
        }).toList();
        setState(() {
          offerList = temp;
        });
      }
    } on DioError catch (e) {
      Alert.errorAlert(e, context);
    }
  }

  void deleteOfferHandler(String id) async {
    try {
      var result = await OfferFormApi.deleteOffer(id);
      if (result is InfoResponse) {
        setState(() {
          offerList.removeWhere((element) => element.id == id);
        });
      }
    } on DioError catch (e) {
      Alert.errorAlert(e, context);
    }
  }

  @override
  void initState() {
    Future.wait([getProfileHandler(), getOfferHandler()]).then((value) {
      setState(() {
        isLoading = false;
      });
    });
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
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
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
                  child: Text("Your Profile",
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
                AvatarProfile(
                    userPicture: userPicture,
                    isEditable: true,
                    updateImageHandler: uploadPicture),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    Text("Created offer",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2),
                                  ],
                                ),
                                IconButton(
                                  splashRadius: 20,
                                  icon: Icon(
                                    Icons.add,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  onPressed: () {
                                    context
                                        .read<OfferFormProvider>()
                                        .updateHouseId("");
                                    Navigator.pushNamed(
                                      context,
                                      OfferForm.routeName,
                                    ).then((value) => getOfferHandler());
                                  },
                                ),
                              ],
                            ),
                            _buildOffers(),
                            _buidProfile(infoList),
                            TextButton(
                                child: const Text("Change Password"),
                                onPressed: () {
                                  showModalBottomSheet(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(15.0))),
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) => Padding(
                                      padding:
                                          MediaQuery.of(context).viewInsets,
                                      child: Container(
                                        padding: const EdgeInsets.all(20),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 250,
                                        child: Column(
                                          children: [
                                            TextField(
                                              obscureText: true,
                                              decoration: const InputDecoration(
                                                  label:
                                                      Text("Current Password")),
                                              autofocus: true,
                                              controller: curController,
                                            ),
                                            const SizedBox(height: 20),
                                            TextField(
                                              obscureText: true,
                                              decoration: const InputDecoration(
                                                  label: Text("New Password")),
                                              autofocus: true,
                                              controller: newController,
                                            ),
                                            const SizedBox(height: 20),
                                            ElevatedButton(
                                                onPressed: () {
                                                  changePasswordHandler(
                                                      context);
                                                },
                                                child: const Text("Confirm"))
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    isLogout = true;
                                  });
                                  Future.delayed(const Duration(seconds: 1),
                                      (() {
                                    setState(() {
                                      isLogout = false;
                                    });
                                    SharePreference.prefs.remove("token");
                                    Navigator.pop(context);
                                  }));
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: const Color(0xffB30000)),
                                child: isLogout
                                    ? const SpinKitRing(
                                        lineWidth: 2,
                                        color: Colors.white,
                                        size: 20.0,
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
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

  Future<void> changePasswordHandler(BuildContext context) async {
    try {
      DioInstance.dio.options.headers["authorization"] =
          "Bearer " + SharePreference.prefs.getString("token").toString();
      var response = await DioInstance.dio.patch("/user/password", data: {
        "currentPass": curController.text,
        "newPass": newController.text
      });
      var result = InfoResponse.fromJson(response.data);
      Alert.successAlert(result, "Password Changed", () {
        Navigator.pop(context);
      }, context)
          .then((value) {
        Navigator.pop(context);
      });
    } on DioError catch (e) {
      Alert.errorAlert(e, context);
    }
  }

  Widget _buidProfile(List<UserProfileCard> infoList) {
    return Column(
        children: infoList
            .map((e) => TextInfo(
                  label: e.label,
                  value: e.value,
                  isEditable: e.isEditable,
                  updateProfileHandler: updateProfileHandler,
                ))
            .toList());
  }

  Widget _buildOffers() {
    return Column(
        children: offerList
            .map((e) => OfferCard(
                  id: e.id,
                  name: e.name,
                  isAvailable: e.isAvailable,
                  isEditable: true,
                  deleteHandler: deleteOfferHandler,
                  toggleOfferHandler: toggleOfferHandler,
                  key: Key(e.id),
                  updateOffer: getOfferHandler,
                ))
            .toList());
  }
}
