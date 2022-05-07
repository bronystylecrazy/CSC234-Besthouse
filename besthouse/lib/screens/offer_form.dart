import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

// services
import '../services/api/offer_form.dart';
import '../services/provider/offer.dart';
import '../services/debouncer.dart';
import '../services/image_picker.dart';
import '../services/provider/location.dart';
// models
import '../models/response/info_response.dart';
import '../models/location.dart';
import '../models/offer_form.dart';
import '../models/facilities.dart';
// screens
import 'google_location.dart';
import 'guide.dart';
// widgets
import '../widgets/common/alert.dart';
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
  final decimalRegex = RegExp(r'(^\d*\.?\d*)');

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

  bool _isSubmitting = false;
  bool _loadingForm = true;
  bool _isEdit = false;

  late Offerform offer;

  void _handleChange(String prop, dynamic value) {
    _debouncer.run(() {
      setState(() {
        offer.update(prop, value);
      });
    });
  }

  void _handleLocationChange() {
    Navigator.of(context).pushNamed(GoogleLocation.routeName).then((value) {
      final location =
          Provider.of<DesireLocation>(context, listen: false).location;

      offer.location = Location(
          coordinates: [location.target.longitude, location.target.latitude]);
      offer.address =
          Provider.of<DesireLocation>(context, listen: false).address;

      _locationController.text = offer.address;
    });
  }

  void getPicture() async {
    final File? file = await ImagePickerService().getImageFromGallery();
    if (file != null) {
      setState(() {
        offer.picture = File(file.path);
      });
    }
  }

  void _submitOffer() async {
    if (offer.rooms.isEmpty) {
      return _buildDialog(context, 'Rooms', 'Please add at least one room');
    } else if (offer.picture == null && offer.pictureUrl.isEmpty) {
      return _buildDialog(
          context, 'Exterior Picture', 'Please upload an exterior picture');
    }

    if (_formKey.currentState!.validate()) {
      setState(() => _isSubmitting = true);

      offer.facilities =
          checkboxList.where((e) => e.checked).map((e) => e.name).toList();

      try {
        var result = _isEdit
            ? await OfferFormApi.updateOffer(
                offer,
                Provider.of<OfferFormProvider>(context, listen: false).houseId,
              )
            : await OfferFormApi.postOffer(offer);

        if (result is InfoResponse) {
          setState(() => _isSubmitting = false);
          Alert.successAlert(
            result,
            'Success',
            () => Navigator.of(context).pop(),
            context,
          ).then((_) => Navigator.of(context).pop());
          Provider.of<DesireLocation>(context, listen: false).updateLocation(
              Provider.of<CurrentLocation>(context, listen: false)
                  .currentLocation);
        }
      } on DioError catch (e) {
        setState(() => _isSubmitting = false);
        Alert.errorAlert(e, context);
      }
    }
  }

  Future<void> _fetchOfferInfo() async {
    final houseId =
        Provider.of<OfferFormProvider>(context, listen: false).houseId;

    if (houseId.isNotEmpty) {
      try {
        var result = await OfferFormApi.getOfferInfo(houseId);

        if (result is InfoResponse) {
          setState(() {
            offer = Offerform.fromJson(result.data);
            for (var e in offer.facilities) {
              checkboxList.firstWhere((f) => f.name == e).checked = true;
            }
            _locationController.text = offer.address;
            _isEdit = true;
            _loadingForm = false;
          });
        }
      } on DioError catch (e) {
        Alert.errorAlert(e, context).then((_) => Navigator.of(context).pop());
      }
    } else {
      setState(() {
        offer = Offerform();
        _loadingForm = false;
      });
    }
  }

  @override
  void initState() {
    _fetchOfferInfo();
    super.initState();
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyBackButton(
                onpressedHanlder: () =>
                    Provider.of<DesireLocation>(context, listen: false)
                        .updateLocation(
                            Provider.of<CurrentLocation>(context, listen: false)
                                .currentLocation)),
          ),
          actions: <Widget>[
            IconButton(
              splashRadius: 20.0,
              icon: const Icon(Icons.menu_book),
              color: Theme.of(context).colorScheme.secondary,
              tooltip: 'Go to guide page',
              onPressed: () => Navigator.pushNamed(context, Guide.routeName,
                  arguments: {"type": "seller"}),
            ),
          ],
        ),
        body: _loadingForm
            ? const SpinKitRing(
                color: Color(0xFF24577A),
                size: 50.0,
              )
            : SingleChildScrollView(
                child: Container(
                  padding:
                      const EdgeInsets.only(left: 24, right: 24, bottom: 24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              _isEdit ? "Edit the offer" : "Create an offer",
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ),
                        ),
                        const TextLabel('Name'),
                        TextFormField(
                          initialValue: offer.name,
                          onChanged: (String value) =>
                              _handleChange('name', value),
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
                          typeValue: offer.type,
                          iconList: typeIcons,
                          changeHandler: (value) =>
                              setState(() => offer.type = value),
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
                        (offer.pictureUrl.isNotEmpty || offer.picture != null)
                            ? ListImage(
                                pictures: offer.pictureUrl.isNotEmpty
                                    ? [offer.pictureUrl]
                                    : null,
                                files: offer.picture != null
                                    ? [offer.picture!]
                                    : null,
                                deleteHandler: (bool isFile, _) {
                                  setState(() {
                                    if (isFile) {
                                      offer.picture = null;
                                    } else {
                                      offer.pictureUrl = "";
                                    }
                                  });
                                },
                              )
                            : Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                child: RectangleAddButton(
                                    clickHandler: getPicture)),
                        const TextLabel("Total space", subLabel: "(Sq.m.)"),
                        TextFormField(
                          initialValue: offer.totalSize.toString(),
                          onChanged: (String value) =>
                              _handleChange('totalSize', double.parse(value)),
                          validator: (value) {
                            if (value == null || double.parse(value) == 0) {
                              return 'Please enter total space';
                            }
                            return null;
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(decimalRegex)
                          ],
                          decoration: _decorator,
                        ),
                        const TextLabel("Price per month", subLabel: "(Baht)"),
                        TextFormField(
                          initialValue: offer.price.toString(),
                          onChanged: (String value) =>
                              _handleChange('price', int.parse(value)),
                          validator: (value) {
                            if (value == null || double.parse(value) == 0) {
                              return 'Please enter price';
                            }
                            return null;
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
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
                          onChanged: (String value) =>
                              _handleChange('description', value),
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
                        RectangleAddButton(
                            clickHandler: () => _buildModalRoom(context)),
                        ...offer.rooms
                            .asMap()
                            .map((index, room) {
                              return MapEntry(
                                index,
                                OfferRoomCard(
                                  room: room,
                                  index: index,
                                  editHandler: (room, index) => setState(() {
                                    offer.rooms
                                        .replaceRange(index, index + 1, [room]);
                                  }),
                                  deleteHandler: (index) => setState(() {
                                    offer.rooms.removeAt(index);
                                  }),
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
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1,
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
                          child: Center(
                            child: Button(
                              clickHandler: _submitOffer,
                              text: "Submit",
                              isLoading: _isSubmitting,
                            ),
                          ),
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

  void _buildDialog(BuildContext ctx, String field, String message) {
    showDialog(
      context: ctx,
      builder: (_) => AlertDialog(
        title: Text('$field is required'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class OfferFormArguments {
  final String? id;

  OfferFormArguments([this.id]);
}
