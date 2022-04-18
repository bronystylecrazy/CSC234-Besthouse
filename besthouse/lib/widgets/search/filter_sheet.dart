import 'package:besthouse/models/accommodation.dart';
import 'package:besthouse/models/facilities.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({Key? key}) : super(key: key);
  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  RangeValues _currentRangeValues = const RangeValues(0, 20000);

  var radioList = [
    AccommodationObject("House", Accommodation.house),
    AccommodationObject("Condo", Accommodation.condo),
    AccommodationObject("Hotel", Accommodation.hotel),
    AccommodationObject("Shop", Accommodation.shophouse),
  ];
  Accommodation? type = Accommodation.house;

  var checkboxList = [
    Facilities("Wifi", false),
    Facilities("Parking", false),
    Facilities("Aircondition", false),
    Facilities("Water heater", false),
    Facilities("Fitness", false),
    Facilities("Swimming pool", false),
    Facilities("Fan", false),
    Facilities("Furnishes", false),
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Filters",
            style:
                GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.keyboard_arrow_down))
        ],
      ),
      _buildContainer(
        context,
        Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Price Range",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                "${_currentRangeValues.start.round()} - ${_currentRangeValues.end.round()} ฿",
                style: Theme.of(context).textTheme.bodyText1,
              )
            ],
          ),
          RangeSlider(
            activeColor: const Color(0xff24577A),
            inactiveColor: const Color(0xffC1C1C1),
            max: 20000,
            values: _currentRangeValues,
            onChanged: (RangeValues values) {
              setState(() {
                _currentRangeValues = values;
              });
            },
          )
        ]),
      ),
      _buildContainer(
        context,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Type of accommodation",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(
              height: 80,
              child: GridView.count(
                  childAspectRatio: 5,
                  // physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.zero,
                  mainAxisSpacing: 4,
                  crossAxisCount: 2,
                  // Generate 100 widgets that display their index in the List.
                  children: radioList
                      .map((e) => ListTile(
                            title: Transform.translate(
                              offset: const Offset(-22, 0),
                              child: Text(e.name),
                            ),
                            leading: Radio<Accommodation>(
                              value: e.type,
                              groupValue: type,
                              onChanged: (Accommodation? value) {
                                setState(() {
                                  type = value;
                                });
                                print(type);
                              },
                            ),
                          ))
                      .toList()),
            )
          ],
        ),
      ),
      _buildContainer(
          context,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Facilities"),
              SizedBox(
                height: 250,
                child: GridView.count(
                    childAspectRatio: 5,
                    // physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.zero,
                    mainAxisSpacing: 4,
                    crossAxisCount: 2,
                    // Generate 100 widgets that display their index in the List.
                    children: checkboxList
                        .map((e) => ListTile(
                            title: Transform.translate(
                              offset: const Offset(-22, 0),
                              child: Text(e.name),
                            ),
                            leading: Checkbox(
                              value: e.checked,
                              onChanged: (value) {
                                setState(() {
                                  e.checked = value!;
                                });
                              },
                            )))
                        .toList()),
              )
            ],
          ))
    ]);
  }

  Widget _buildContainer(BuildContext context, Widget child) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xffE2E5F1),
      ),
      child: Padding(padding: const EdgeInsets.all(16.0), child: child),
    );
  }
}
