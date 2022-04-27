import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AvatarProfile extends StatelessWidget {
  const AvatarProfile({
    Key? key,
    required this.userPicture,
  }) : super(key: key);

  final String userPicture;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(120),
      child: SizedBox(
        height: 125,
        width: 125,
        child: Stack(
          children: [
            Image.network(
              userPicture,
              fit: BoxFit.cover,
              width: 125,
              height: 125,
            ),
            Positioned.fill(
                child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: const Color(0xff24577a).withOpacity(0.5),
                      onTap: () {},
                    ))),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 120 * 0.25,
                width: double.infinity,
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Text(
                    "Edit",
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
