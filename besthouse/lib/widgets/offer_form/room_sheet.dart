import 'dart:io';

import 'package:besthouse/widgets/offer_form/list_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

// models
import '../../models/offer_form.dart';
// services
import '../../services/image_picker.dart';
// widgets
import '../common/button.dart';
import 'dropdown_menu.dart';
import 'text_label.dart';

class RoomSheet extends StatefulWidget {
  const RoomSheet({
    this.room,
    this.addHandler,
    this.editHandler,
    this.index,
    this.isEdit = false,
    Key? key,
  }) : super(key: key);

  final OfferRoom? room;
  final Function(OfferRoom)? addHandler;
  final Function(OfferRoom room, int index)? editHandler;
  final int? index;
  final bool isEdit;

  @override
  State<RoomSheet> createState() => _RoomSheetState();
}

class _RoomSheetState extends State<RoomSheet> {
  List<String> roomTypes = ['Living room', 'Bedroom', 'Bathroom', 'Kitchen'];
  List<IconData> roomIcons = [
    Icons.chair_rounded,
    Icons.hotel,
    Icons.bathtub_rounded,
    Icons.local_restaurant_rounded,
  ];
  bool isDisabled = true;

  late final OfferRoom _room = widget.room != null
      ? OfferRoom(
          type: widget.room!.type,
          amount: widget.room!.amount,
          files: widget.room!.files,
          pictures: widget.room!.pictures,
        )
      : OfferRoom(
          type: roomTypes[0],
          amount: 0,
        );

  void getRoomPictures() async {
    final List<File>? files = await ImagePickerService().getImagesFromGallery();
    if (files != null) {
      print('file $files');
      setState(() {
        _room.files ??= [];
        _room.files!.addAll(files);

        print('room files ${_room.files}');

        if (isDisabled && _room.amount > 0) {
          isDisabled = false;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.isEdit ? "Edit Room" : "New Room",
                      style: Theme.of(context).textTheme.headline2),
                  IconButton(
                    icon: const Icon(Icons.close),
                    color: Colors.grey,
                    iconSize: 20,
                    splashRadius: 20,
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const TextLabel("Room type"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.55,
                    child: DropdownMenu(
                      list: roomTypes,
                      typeValue: _room.type,
                      changeHandler: (value) {
                        setState(() {
                          _room.type = value;

                          if (isDisabled &&
                              _room.amount > 0 &&
                              (_room.pictures.isNotEmpty || _room.files != null)) {
                            isDisabled = false;
                          }
                        });
                      },
                      iconList: roomIcons,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: TextFormField(
                      initialValue: _room.amount == 0 ? '' : _room.amount.toString(),
                      onChanged: (value) {
                        if (value.isNotEmpty && int.parse(value) > 0) {
                          setState(() {
                            _room.amount = int.parse(value);

                            if ((_room.pictures.isNotEmpty || _room.files != null) && isDisabled) {
                              isDisabled = false;
                            }
                          });
                        } else {
                          if (!isDisabled) {
                            setState(() {
                              isDisabled = true;
                            });
                          }
                        }
                      },
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        hintText: 'Enter Amount',
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
                        fillColor: Theme.of(context).colorScheme.tertiary,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.circular(14),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const TextLabel("Pictures"),
                  TextButton(
                    onPressed: getRoomPictures,
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          size: 17,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        Text(
                          "New Picture",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (_room.pictures.isNotEmpty || _room.files != null)
                ListImage(
                  files: _room.files,
                  pictures: _room.pictures.isNotEmpty ? _room.pictures : null,
                  deleteHandler: (bool isFile, String path) => setState(() {
                    if (isFile) {
                      if (_room.files!.length == 1) {
                        _room.files = null;
                      } else {
                        _room.files!.removeWhere((file) => file.path == path);
                      }
                    } else {
                      _room.pictures.removeWhere((picture) => picture == path);
                    }

                    if (_room.pictures.isEmpty && _room.files == null) {
                      isDisabled = true;
                    } else if (isDisabled) {
                      isDisabled = false;
                    }
                  }),
                ),
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: Center(
                  child: Button(
                    text: widget.isEdit ? "Edit room" : "Add room",
                    clickHandler: isDisabled
                        ? null
                        : () {
                            if (widget.isEdit) {
                              widget.editHandler!(_room, widget.index!);
                            } else {
                              widget.addHandler!(_room);
                            }
                            Navigator.pop(context);
                          },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
