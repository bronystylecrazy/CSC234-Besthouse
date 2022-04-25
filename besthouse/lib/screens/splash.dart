import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'get_start.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 3000,
      splash: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Positioned(
              child: Image.asset("assets/logo.png", scale: 0.8),
              top: 50,
              left: 18,
            ),
            Text('BestHouse',
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.w600, color: const Color(0xFF24577A))),
            Text('Welcome to BestHouse',
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w600, color: const Color(0xFF24577A))),
          ],
        ),
      ),
      nextScreen: const GetStart(),
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}
