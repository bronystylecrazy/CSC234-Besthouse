import 'package:besthouse/screens/house_detailed.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OfferCard extends StatelessWidget {
  const OfferCard(
      {Key? key,
      required this.name,
      required this.isAvailable,
      required this.isEditable,
      this.deleteHandler,
      required this.id,
      this.toggleOfferHandler})
      : super(key: key);
  final String id;
  final String name;
  final bool isAvailable;
  final bool isEditable;
  final Function? deleteHandler;
  final Function? toggleOfferHandler;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Colors.black12, width: 1),
      ),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.only(top: 4, bottom: 4, left: 16, right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              child: Text(name),
              onTap: () {
                Navigator.pushNamed(context, HouseDetailed.routeName);
              },
            ),
            Row(
              children: [
                Card(
                  elevation: 0,
                  color: isAvailable
                      ? const Color(0xffE1FCEF)
                      : const Color(0xffF0EFEF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: Container(
                            width: 6,
                            height: 6,
                            color: isAvailable
                                ? const Color(0xff38A06C)
                                : const Color(0xff94989B),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          isAvailable ? "Available" : "Reserved",
                          style: GoogleFonts.poppins(
                            color: isAvailable
                                ? const Color(0xff38A06C)
                                : const Color(0xff94989B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                isEditable
                    ? PopupMenuButton(
                        padding: const EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: Text(isAvailable ? "Disable" : "Enable"),
                            onTap: () {
                              toggleOfferHandler!(id);
                            },
                          ),
                          PopupMenuItem(
                            child: const Text("Edit"),
                            onTap: () {},
                          ),
                          PopupMenuItem(
                              child: Text("Delete",
                                  style: GoogleFonts.poppins(
                                      color: Theme.of(context).errorColor)),
                              onTap: () {
                                Future.delayed(const Duration(seconds: 0), (() {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text('Are you sure?'),
                                      content: const Text(
                                          "You cannot undo the action"),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Cancel',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            deleteHandler!(id);
                                            Navigator.pop(context);
                                          },
                                          child: Text('OK',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1
                                                  ?.apply(color: Colors.red)),
                                        ),
                                      ],
                                    ),
                                  );
                                }));
                              })
                        ],
                        child: const Icon(
                          Icons.more_vert,
                          size: 18,
                        ),
                      )
                    : Container()
              ],
            )
          ],
        ),
      ),
    );
  }
}
