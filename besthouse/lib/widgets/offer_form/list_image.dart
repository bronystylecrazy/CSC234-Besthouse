import 'dart:io';

import 'package:besthouse/services/constants.dart';
import 'package:flutter/material.dart';

class ListImage extends StatelessWidget {
  const ListImage({
    this.pictures,
    this.files,
    this.deleteHandler,
    Key? key,
  }) : super(key: key);

  final List<String>? pictures;
  final List<File>? files;
  final Function(bool isFile, String path)? deleteHandler;

  List<dynamic> get _pictures {
    var list = [];
    if (pictures != null) {
      for (var pic in pictures!) {
        list.add(pic);
      }
    }
    if (files != null) {
      for (var file in files!) {
        list.add(file);
      }
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    print('list $files');
    print('list2 $_pictures');
    final BorderRadius borderRadius = BorderRadius.circular(14);

    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _pictures.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius,
            ),
            child: ClipRRect(
              borderRadius: borderRadius,
              child: Stack(
                children: [
                  _pictures[index] is File
                      ? Image.file(
                          _pictures[index] as File,
                          fit: BoxFit.cover,
                          width: 240,
                          height: 130,
                        )
                      : Image.network(
                          Constants.baseUrl + _pictures[index] as String,
                          fit: BoxFit.cover,
                          width: 240,
                          height: 130,
                          errorBuilder: (context, error, stackTrace) => Image.asset(
                            "assets/Portrait_Placeholder.png",
                            fit: BoxFit.cover,
                            width: 240,
                            height: 130,
                          ),
                        ),
                  if (deleteHandler != null)
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
                        onPressed: () {
                          if (_pictures[index] is File) {
                            deleteHandler!(true, _pictures[index].path);
                          } else {
                            deleteHandler!(false, _pictures[index]);
                          }
                        },
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
