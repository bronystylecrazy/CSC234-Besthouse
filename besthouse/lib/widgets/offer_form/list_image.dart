import 'dart:io';

import 'package:flutter/material.dart';

class ListImage extends StatelessWidget {
  const ListImage({
    required this.pictures,
    required this.deleteHandler,
    Key? key,
  }) : super(key: key);

  final List<File> pictures;
  final Function(int index) deleteHandler;

  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius = BorderRadius.circular(14);

    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: pictures.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius,
            ),
            child: ClipRRect(
              borderRadius: borderRadius,
              child: Stack(
                children: [
                  Image.file(
                    pictures[index],
                    fit: BoxFit.cover,
                    height: 130,
                    width: 240,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: ElevatedButton(
                      child: Icon(
                        Icons.close,
                        color: Colors.black.withAlpha(180),
                        size: 18,
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white.withOpacity(0.5),
                        shape: const CircleBorder(),
                      ),
                      onPressed: () => deleteHandler(index),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
