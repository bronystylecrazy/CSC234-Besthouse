import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.clickHandler,
    required this.text,
  }) : super(key: key);

  final Function() clickHandler;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: clickHandler,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Ink(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xFF245679),
              Color(0xFF173651),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          width: MediaQuery.of(context).size.width * 0.6,
          child: Text(
            text,
            style: GoogleFonts.poppins(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
