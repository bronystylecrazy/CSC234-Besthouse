import 'package:besthouse/services/api/search.dart';
import 'package:besthouse/services/location_api.dart';
import 'package:besthouse/services/provider/house_lists.dart';
import 'package:besthouse/services/provider/location.dart';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//model
import '../models/house.dart';

//widget
import '../services/provider/offer.dart';
import '../widgets/home/house_card.dart';
import '../widgets/common/button.dart';

//screen
import '../screens/google_location.dart';
import '../screens/house_detailed.dart';

//dio
import 'package:besthouse/models/response/info_response.dart';
import 'package:besthouse/widgets/common/alert.dart';
import 'package:dio/dio.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.onTapHandler}) : super(key: key);
  static const routeName = "/home";
  final Function onTapHandler;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Where ?',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, GoogleLocation.routeName)
                        .then((value) => {widget.onTapHandler()});
                  },
                  child: TextFormField(
                    enabled: false,
                    controller: _searchController,
                    obscureText: false,
                    decoration: const InputDecoration(
                      hintText: "Search your desire location!",
                      fillColor: Color(0xFFE9E9E9),
                      filled: true,
                      suffixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              "assets/house_image.png",
              scale: 1.2,
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                'Featured House',
                style: Theme.of(context).textTheme.headline2,
                textAlign: TextAlign.left,
              ),
            ),
            Provider.of<FeatureHousesList>(context, listen: true).isLoading
                ? const Padding(
                    padding: EdgeInsets.all(30.0),
                    child: CircularProgressIndicator(),
                  )
                : (Provider.of<FeatureHousesList>(context, listen: true)
                        .houses
                        .isNotEmpty
                    ? SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: Provider.of<FeatureHousesList>(context,
                                  listen: true)
                              .houses
                              .length,
                          itemBuilder: (BuildContext context, int index) {
                            return HouseCard(
                              house: Provider.of<FeatureHousesList>(context,
                                      listen: true)
                                  .houses[index],
                              showInfoHandler: _showInfo,
                            );
                          },
                        ),
                      )
                    : Container(
                        margin: const EdgeInsets.all(10.0),
                        padding: const EdgeInsets.symmetric(
                            vertical: 30, horizontal: 80),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF173651)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                        ),
                        child: const Text('No houses found'))),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                'Discover around you',
                style: Theme.of(context).textTheme.headline2,
                textAlign: TextAlign.left,
              ),
            ),
            Provider.of<NearbyHousesList>(context, listen: true).isLoading
                ? const Padding(
                    padding: EdgeInsets.all(30.0),
                    child: CircularProgressIndicator(),
                  )
                : (Provider.of<NearbyHousesList>(context, listen: true)
                        .houses
                        .isNotEmpty
                    ? SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: Provider.of<NearbyHousesList>(context,
                                  listen: true)
                              .houses
                              .length,
                          itemBuilder: (BuildContext context, int index) {
                            return HouseCard(
                              house: Provider.of<NearbyHousesList>(context,
                                      listen: true)
                                  .houses[index],
                              showInfoHandler: _showInfo,
                            );
                          },
                        ),
                      )
                    : Container(
                        margin: const EdgeInsets.all(10.0),
                        padding: const EdgeInsets.symmetric(
                            vertical: 30, horizontal: 80),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF173651)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                        ),
                        child: const Text('No houses found'))),
          ],
        ),
      ),
    );
  }

  void _showInfo(String id) {
    context.read<OfferFormProvider>().updateHouseId(id);
    Navigator.of(context).pushNamed(HouseDetailed.routeName, arguments: {
      'id': id,
    });
  }
}
