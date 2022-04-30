import 'package:besthouse/models/house_detail.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class RoomImage extends StatelessWidget {
  final HouseDetail? houseDetail;

  const RoomImage({
    Key? key,
    required this.houseDetail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> pictures = [];
    if (houseDetail != null) {
      for (final room in houseDetail!.rooms) {
        pictures.addAll(room.pictures.map((e) => e.toString()));
      }
    }
    return PhotoViewGallery.builder(
      scrollPhysics: const BouncingScrollPhysics(),
      builder: (BuildContext context, int index) {
        return PhotoViewGalleryPageOptions.customChild(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.network(
              pictures[index],
              fit: BoxFit.cover,
            ),
          ),
          childSize: const Size(500, 300),
          initialScale: PhotoViewComputedScale.contained,
          minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
          maxScale: PhotoViewComputedScale.covered * 4.1,
        );
      },
      itemCount: pictures.length,
      loadingBuilder: (context, event) => SizedBox(
        width: 20.0,
        height: 20.0,
        child: CircularProgressIndicator(
          value: event == null ? 0 : event.cumulativeBytesLoaded / 1000,
        ),
      ),
      backgroundDecoration: const BoxDecoration(
        // borderRadius: BorderRadius.all(Radius.circular(14)),
        color: Colors.white,
      ),
    );
  }
}
