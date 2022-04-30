import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextLabel extends StatelessWidget {
  final String label;
  final String? subLabel;

  const TextLabel(
    this.label, {
    this.subLabel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          subLabel != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    subLabel as String,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
