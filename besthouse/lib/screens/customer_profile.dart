import 'package:besthouse/screens/offer_form.dart';
import 'package:besthouse/widgets/customer_profile/offer_card.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:google_fonts/google_fonts.dart';

class CustomerProfile extends StatefulWidget {
  const CustomerProfile({Key? key}) : super(key: key);
  static const routeName = "/customer_profile";

  @override
  State<CustomerProfile> createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  final userPicture =
      "https://cdn.pixabay.com/photo/2015/08/25/10/40/ben-knapen-906550_960_720.jpg";
  @override
  Widget build(BuildContext context) {
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
            child: Text("Your Profile",
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
          _buildAvatarProfile(context),
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
                              Text("Created offer",
                                  style: Theme.of(context).textTheme.headline3),
                            ],
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.add,
                                size: 30,
                                color: Theme.of(context).primaryColor,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, OfferForm.routeName);
                              })
                        ],
                      ),
                      OfferCard(name: "Diary Prachautid", isAvailable: true),
                      OfferCard(name: "Diary Prachautid", isAvailable: false),
                      OfferCard(name: "Diary Prachautid", isAvailable: true),
                      OfferCard(name: "Diary Prachautid", isAvailable: false),
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

  Widget _buildAvatarProfile(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(120),
      child: SizedBox(
        height: 120,
        width: 120,
        child: Stack(children: [
          Image.network(
            userPicture,
            fit: BoxFit.contain,
          ),
          Positioned.fill(
              child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: const Color(0xff24577a).withOpacity(0.5),
                    onTap: () {},
                  ))),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 120 * 0.25,
                width: double.infinity,
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Text(
                    "Edit",
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ))
        ]),
      ),
    );
  }
}
