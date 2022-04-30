import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// services
import '../services/debouncer.dart';
import '../services/image_picker.dart';
import '../services/provider.dart';
// models
import '../models/location.dart';
import '../models/offer_form.dart';
import '../models/facilities.dart';
// screens
import 'google_location.dart';
import 'guide.dart';
// widgets
import '../widgets/offer_form/bills_row.dart';
import '../widgets/offer_form/room_sheet.dart';
import '../widgets/offer_form/tags.dart';
import '../widgets/offer_form/list_image.dart';
import '../widgets/offer_form/dropdown_menu.dart';
import '../widgets/offer_form/rectangle_add_button.dart';
import '../widgets/common/my_back_button.dart';
import '../widgets/common/button.dart';
import '../widgets/offer_form/text_label.dart';
import '../widgets/offer_form/offer_room_card.dart';

class OfferForm extends StatefulWidget {
  const OfferForm({Key? key}) : super(key: key);
  static const routeName = "/offer-form";

  @override
  State<OfferForm> createState() => _OfferFormState();
}

class _OfferFormState extends State<OfferForm> {
  final _formKey = GlobalKey<FormState>();
  final _locationController = TextEditingController();
  final _debouncer = Debouncer(milliseconds: 1500);
  RegExp decimalRegex = RegExp(r'(^\d*\.?\d*)');
  Offer offer = Offer();

  String typeValue = 'House';
  List<String> types = ['House', 'Condominium', 'Hotel', 'Shophouse'];
  List<IconData> typeIcons = [
    Icons.home_filled,
    Icons.location_city_rounded,
    Icons.villa_rounded,
    Icons.night_shelter_rounded,
  ];

  List<Facilities> checkboxList = [
    Facilities("Wifi", false),
    Facilities("Parking", false),
    Facilities("Aircondition", false),
    Facilities("Water heater", false),
    Facilities("Fitness", false),
    Facilities("Swimming pool", false),
    Facilities("Fan", false),
    Facilities("Furnishes", false),
  ];

  void _handleChange(String prop, dynamic value) {
    _debouncer.run(() {
      setState(() {
        offer.update(prop, value);
      });
    });
  }

  void _handleLocationChange() {
    Navigator.of(context).pushNamed(GoogleLocation.routeName).then((value) {
      final location = Provider.of<DesireLocation>(context, listen: false).location;

      offer.location = Location(coordinates: [location.target.latitude, location.target.longitude]);
      offer.address = Provider.of<DesireLocation>(context, listen: false).address;

      _locationController.text = offer.address;
    });
  }

  void getPicture() async {
    final File? file = await ImagePickerService().getImageFromGallery();
    if (file != null) {
      setState(() {
        offer.pictureUrl = File(file.path);
      });
    }
  }

  void _addOfferHandler() {
    if (_formKey.currentState!.validate()) {
      offer.facilities = checkboxList.where((e) => e.checked).map((e) => e.name).toList();
      offer.type = typeValue.toUpperCase();
      print(offer.toJson());
    }
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context)!.settings.arguments as OfferArguments;
    // if (args.offer != null) {
    //   offer = args.offer as Offer;
    // }

    final InputDecoration _decorator = InputDecoration(
      fillColor: Theme.of(context).colorScheme.tertiary,
      filled: true,
      border: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
    );

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 249, 249, 249),
          leadingWidth: 80,
          leading: const Padding(
            padding: EdgeInsets.all(8.0),
            child: MyBackButton(),
          ),
          actions: <Widget>[
            IconButton(
              splashRadius: 20.0,
              icon: const Icon(Icons.menu_book),
              color: Theme.of(context).colorScheme.secondary,
              tooltip: 'Go to guide page',
              onPressed: () =>
                  Navigator.pushNamed(context, Guide.routeName, arguments: {"type": "seller"}),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text("Creat an offer", style: Theme.of(context).textTheme.headline2),
                    ),
                  ),
                  const TextLabel('Name'),
                  TextFormField(
                    initialValue: offer.name,
                    onChanged: (String value) => _handleChange('name', value),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter name';
                      }
                      return null;
                    },
                    decoration: _decorator.copyWith(
                      hintText: 'Enter name',
                    ),
                  ),
                  const TextLabel('Type'),
                  DropdownMenu(
                    list: types,
                    typeValue: typeValue,
                    iconList: typeIcons,
                    changeHandler: (value) => setState(() => typeValue = value),
                  ),
                  const TextLabel('Location'),
                  TextFormField(
                    controller: _locationController,
                    readOnly: true,
                    onTap: _handleLocationChange,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter location';
                      }
                      return null;
                    },
                    decoration: _decorator.copyWith(
                      hintText: 'Search the location',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        color: Theme.of(context).colorScheme.secondary,
                        onPressed: _handleLocationChange,
                      ),
                    ),
                  ),
                  const TextLabel('Exterior Pictures'),
                  Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: RectangleAddButton(clickHandler: getPicture)),
                  if (offer.pictureUrl.path.isNotEmpty)
                    ListImage(
                      pictures: [offer.pictureUrl],
                      deleteHandler: (index) => setState(
                        () => offer.pictureUrl = File(''),
                      ),
                    ),
                  const TextLabel("Total space", subLabel: "(Sq.m.)"),
                  TextFormField(
                    initialValue: offer.totalSize.toString(),
                    onChanged: (String value) => _handleChange('totalSize', double.parse(value)),
                    validator: (value) {
                      if (value == null || double.parse(value) == 0) {
                        return 'Please enter total space';
                      }
                      return null;
                    },
                    inputFormatters: [FilteringTextInputFormatter.allow(decimalRegex)],
                    decoration: _decorator,
                  ),
                  const TextLabel("Price per month", subLabel: "(Baht)"),
                  TextFormField(
                    initialValue: offer.totalSize.toString(),
                    onChanged: (String value) => _handleChange('price', int.parse(value)),
                    validator: (value) {
                      if (value == null || double.parse(value) == 0) {
                        return 'Please enter price';
                      }
                      return null;
                    },
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: _decorator,
                  ),
                  BillsRow(
                    changeHandler: _handleChange,
                    decimalRegex: decimalRegex,
                    electricFee: offer.electricFee,
                    waterFee: offer.waterFee,
                  ),
                  const TextLabel('Description'),
                  TextFormField(
                    initialValue: offer.description,
                    onChanged: (String value) => _handleChange('description', value),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some detail about your property';
                      }
                      return null;
                    },
                    decoration: _decorator.copyWith(
                      hintText: 'Enter some detail',
                    ),
                  ),
                  const TextLabel('Rooms'),
                  RectangleAddButton(clickHandler: () => _buildModalRoom(context)),
                  ...offer.rooms
                      .asMap()
                      .map((index, room) {
                        return MapEntry(
                          index,
                          OfferRoomCard(
                            room: room,
                            index: index,
                            editHandler: (room, index) => setState(() {
                              offer.rooms.replaceRange(index, index + 1, [room]);
                            }),
                            deleteHandler: (index) => setState(() {
                              offer.rooms.removeAt(index);
                            }),
                            deleteImageHandler: (idx) => setState(
                              () {
                                offer.rooms[index].pictures.removeAt(idx);
                              },
                            ),
                          ),
                        );
                      })
                      .values
                      .toList(),
                  const TextLabel("Facilities"),
                  SizedBox(
                    height: 130,
                    child: GridView.count(
                      childAspectRatio: 6,
                      padding: EdgeInsets.zero,
                      mainAxisSpacing: 4,
                      crossAxisCount: 2,
                      children: checkboxList
                          .map((e) => Row(
                                children: [
                                  Checkbox(
                                    activeColor: const Color(0xff24577A),
                                    value: e.checked,
                                    onChanged: (value) {
                                      setState(() {
                                        e.checked = value!;
                                      });
                                    },
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
                  Tags(
                    tags: offer.tags,
                    deleteHandler: (tag) {
                      setState(() {
                        offer.tags.remove(tag);
                      });
                    },
                    addHandler: (tag) {
                      setState(() {
                        offer.tags.add(tag);
                      });
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Center(child: Button(clickHandler: _addOfferHandler, text: "Add offer")),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void _buildModalRoom(BuildContext ctx) {
    showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        context: ctx,
        builder: (_) {
          return RoomSheet(addHandler: (room) {
            setState(() {
              offer.rooms.add(room);
            });
          });
        });
  }
}

class OfferArguments {
  final Offer? offer;

  OfferArguments([this.offer]);
}
