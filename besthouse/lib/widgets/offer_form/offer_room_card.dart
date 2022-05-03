import 'package:flutter/material.dart';
// models
import '../../models/offer_form.dart';
// widgets
import 'list_image.dart';
import 'room_sheet.dart';
import 'text_label.dart';

class OfferRoomCard extends StatelessWidget {
  const OfferRoomCard({
    required this.room,
    required this.editHandler,
    required this.deleteHandler,
    required this.index,
    Key? key,
  }) : super(key: key);

  final OfferRoom room;
  final Function(OfferRoom room, int index) editHandler;
  final Function(int index) deleteHandler;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: TextLabel(room.type, subLabel: '${room.amount} rooms'),
                ),
                Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: IconButton(
                          onPressed: () => _buildModalRoom(context),
                          icon: Icon(
                            Icons.edit,
                            size: 18,
                            color: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
                          ),
                          splashRadius: 14,
                          tooltip: 'edit room',
                        )),
                    IconButton(
                      onPressed: () => deleteHandler(index),
                      icon: Icon(
                        Icons.delete,
                        size: 18,
                        color: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
                      ),
                      splashRadius: 14,
                      tooltip: 'delete room',
                    ),
                  ],
                )
              ],
            ),
            ListImage(
              pictures: room.files,
            ),
          ],
        ),
      ),
    );
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
          return RoomSheet(
            room: room,
            index: index,
            editHandler: editHandler,
            isEdit: true,
          );
        });
  }
}
