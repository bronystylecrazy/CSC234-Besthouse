import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OfferCard extends StatelessWidget {
  const OfferCard({Key? key, required this.name, required this.isAvailable})
      : super(key: key);
  final String name;
  final bool isAvailable;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.black12, width: 1),
      ),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.only(top: 4, bottom: 4, left: 16, right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name),
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
                          borderRadius: BorderRadius.circular(4),
                          child: Container(
                            width: 10,
                            height: 10,
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
                GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.more_vert,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
