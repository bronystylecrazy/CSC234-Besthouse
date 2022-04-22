import 'dart:convert';
import 'dart:math';

import 'package:besthouse/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/guide_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Guide extends StatefulWidget {
  const Guide({Key? key}) : super(key: key);
  static const routeName = "/guide";

  @override
  State<Guide> createState() => _GuideState();
}

class _GuideState extends State<Guide> {
  late List<GuideModel>? guides = null;

  Future<void> readJson(bool isCustomer) async {
    final String response = isCustomer
        ? await rootBundle.loadString('assets/customer_guide.json')
        : await rootBundle.loadString('assets/seller_guide.json');
    final List<dynamic> data = await json.decode(response);
    List<GuideModel> temp =
        data.map((element) => GuideModel.fromJson(element)).toList();
    await Future.delayed(const Duration(seconds: 1), () {});
    setState(() {
      guides = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final String? guideType = routeArgs['type'];

    readJson(guideType == "customer");
    const spinkit = SpinKitRing(
      color: Color(0xFF24577A),
      size: 50.0,
    );
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
          leadingWidth: 100,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: Text(
                "Back",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          elevation: 0,
          backgroundColor: Color(0xffF5F5F5)),
      body: Center(
        child: ListView(
          children: [
            Center(
              child: Text(
                guideType == "customer" ? "Customer Guide" : "Seller Guide",
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            guides == null
                ? Container(
                    height: MediaQuery.of(context).size.height - 200,
                    child: spinkit,
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: guides!.map((e) => _buildGuideCard(e)).toList(),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Widget _buildGuideCard(GuideModel value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            value.name,
            style:
                GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 12),
            child: Text(
              value.description,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          )
        ],
      ),
    );
  }
}
