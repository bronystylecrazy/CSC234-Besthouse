import 'package:besthouse/models/accommodation.dart';
import 'package:besthouse/models/facilities.dart';
import 'package:besthouse/widgets/common/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterSheet extends StatefulWidget {
  FilterSheet({
    Key? key,
    required this.slideHandler,
    required this.radioHandler,
    required this.checkBoxHandler,
    required this.currentRangeValues,
    required this.radioList,
    required this.checkboxList,
    required this.type,
  }) : super(key: key);

  RangeValues currentRangeValues;
  Accommodation? type;
  List<AccommodationObject> radioList;
  List<Facilities> checkboxList;
  final Function slideHandler;
  final Function radioHandler;
  final Function checkBoxHandler;

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Filters",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.keyboard_arrow_down),
                )
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
                      "${widget.currentRangeValues.start.round()} - ${widget.currentRangeValues.end.round()} ฿",
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  ],
                ),
                RangeSlider(
                    activeColor: const Color(0xff24577A),
                    inactiveColor: const Color(0xffC1C1C1),
                    max: 20000,
                    values: widget.currentRangeValues,
                    onChanged: (values) {
                      widget.slideHandler(values);
                      setState(() {
                        widget.currentRangeValues = values;
                      });
                    })
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
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    height: 70,
                    child: GridView.count(
                      childAspectRatio: 6,
                      padding: EdgeInsets.zero,
                      mainAxisSpacing: 4,
                      crossAxisCount: 2,
                      // Generate 100 widgets that display their index in the List.
                      children: widget.radioList
                          .map((e) => Row(
                                children: [
                                  Radio<Accommodation>(
                                      activeColor: const Color(0xff24577A),
                                      value: e.type,
                                      groupValue: widget.type,
                                      onChanged: (value) {
                                        widget.radioHandler(value);
                                        setState(() {
                                          widget.type = value;
                                        });
                                      }),
                                  Text(
                                    e.name,
                                    style: Theme.of(context).textTheme.subtitle1,
                                  )
                                ],
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
            _buildContainer(
              context,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Facilities",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    height: 100,
                    child: GridView.count(
                        childAspectRatio: 6,
                        padding: EdgeInsets.zero,
                        mainAxisSpacing: 4,
                        crossAxisCount: 2,
                        // Generate 100 widgets that display their index in the List.
                        children: widget.checkboxList
                            .map((e) => Row(
                                  children: [
                                    Checkbox(
                                        activeColor: const Color(0xff24577A),
                                        value: e.checked,
                                        onChanged: (value) {
                                          widget.checkBoxHandler(value, e);
                                          setState(() {});
                                        }),
                                    Text(
                                      e.name,
                                      style: Theme.of(context).textTheme.subtitle1,
                                    ),
                                  ],
                                ))
                            .toList()),
                  ),
                ],
              ),
            ),
            Button(
              clickHandler: () {
                Navigator.pop(context);
              },
              text: "Apply",
            )
          ]),
        ),
      ],
    );
  }

  Widget _buildContainer(BuildContext context, Widget child) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).colorScheme.tertiary,
      ),
      child: Padding(padding: const EdgeInsets.all(16.0), child: child),
    );
  }
}
