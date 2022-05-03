import 'package:besthouse/models/accommodation.dart';
import 'package:besthouse/models/facilities.dart';
import 'package:besthouse/widgets/common/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({
    Key? key,
    required this.filterHandler,
    required this.currentRangeValues,
    required this.radioList,
    required this.checkboxList,
    required this.type,
  }) : super(key: key);

  final RangeValues currentRangeValues;
  final Accommodation type;
  final List<AccommodationObject> radioList;
  final List<Facilities> checkboxList;
  final Function(RangeValues, Accommodation, List<Facilities>) filterHandler;

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  late RangeValues _currentRangeValues = widget.currentRangeValues;
  late Accommodation _type = widget.type;
  late final List<Facilities> _checkboxList =
      widget.checkboxList.map((e) => Facilities(e.name, e.checked)).toList();

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
                  onPressed: () => Navigator.pop(context),
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
                  onChanged: (values) => setState(() {
                    _currentRangeValues = values;
                  }),
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
                                    groupValue: _type,
                                    onChanged: (value) => setState(() {
                                      _type = value!;
                                    }),
                                  ),
                                  Text(
                                    e.name,
                                    style: Theme.of(context).textTheme.subtitle1,
                                  ),
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
                      children: _checkboxList
                          .map(
                            (e) => Row(
                              children: [
                                Checkbox(
                                  activeColor: const Color(0xff24577A),
                                  value: e.checked,
                                  onChanged: (value) => setState(() {
                                    e.checked = value!;
                                  }),
                                ),
                                Text(
                                  e.name,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
            Button(
              clickHandler: () {
                widget.filterHandler(
                  _currentRangeValues,
                  _type,
                  _checkboxList,
                );
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
